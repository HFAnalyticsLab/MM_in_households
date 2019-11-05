# =======================================================
# Project: Multimorbidity in Households
# Purpose: Read in cost data and patient spine
# Author: Mai Stafford & Kathryn Dreyer
# Date: 01/11/2019
# =======================================================

pth <- "R:/R_repository"

install.packages(c("glmmTMB"), 
                 repos = file.path("file://", pth),
                 type = "win.binary", dependencies = TRUE)
install.packages(c("here"), 
                 repos = file.path("file://", pth),
                 type = "win.binary", dependencies = TRUE)
install.packages(c("data.table"), 
                 repos = file.path("file://", pth),
                 type = "win.binary", dependencies = TRUE)


#Load libraries
library(plyr) #load before tidyverse
library(tidyverse)
library(here)
library(haven)
library(data.table)


#Set inflation figures
inflation_1516 <- 1.019
inflation_1617 <- 1.034
inflation_1718 <- 1.026

#define inflation functions
inflate_1415 <- function(x){
  x * inflation_1516 * inflation_1617 * inflation_1718
}

inflate_1516 <- function(x){
  x * inflation_1617 * inflation_1718
}


#Import patient data
patient_import <- read_sas([file path removed])

#select variables we need
patient_data <- select(patient_import, c(patid, pracfamnumber, female, agec_at50, imd2015_10, selfother))

#set variables as factors for model below
patient_data <- patient_data %>% 
  mutate(pracfamnumber = factor(pracfamnumber)) %>% 
  mutate(female = factor(female)) %>% 
  mutate(selfother = factor(selfother, levels=c(3,4,1,2),labels=c("MM/healthy co-res", "Both MM", "Both healthy", "Healthy/MM co-res"))) # this orders the categories so that 3 is reference

patient_data$imd2015_10 <- cut(patient_data$imd2015_10, breaks=c(-Inf, 2, 4, 6, 8, Inf),
                               labels=c("Least deprived", "IMDQ2", "IMDQ3", "IMDQ4", "most deprived")) 
patient_data$agec_at50 <- cut(patient_data$agec_at50, breaks=c(-Inf, 9, 19, 29, Inf),
                              labels=c("50-59y", "60-69y", "70-79y", "80+y"))  


#Import cost and utilisation data
import_all_1516 <- read_csv([file path removed])
import_all_1415 <- read_csv([file path removed])


#Select the cost & utilisation variables we need
costs_1516 <- select(import_all_1516, c(patid, apctotcost, elcost, emcost, aetotcost, optotcost, ptotcost, drugtotcost, finalcost, spells, 
                                        elects, emergs, others, los, avlos, aeatts, opatts, pcontacts))
costs_1415 <- select(import_all_1415, c(patid, apctotcost, elcost, emcost, aetotcost, optotcost, ptotcost, drugtotcost, finalcost, spells, 
                                        elects, emergs, others, los, avlos, aeatts, opatts, pcontacts))

#Inflat costs to 17/18 terms
costs_1516_inf <- costs_1516 %>% 
  mutate_at(c("apctotcost", "elcost", "emcost", "aetotcost", "optotcost", "ptotcost", "drugtotcost", "finalcost"), inflate_1516)

costs_1415_inf <- costs_1415 %>% 
  mutate_at(c("apctotcost", "elcost", "emcost", "aetotcost", "optotcost", "ptotcost", "drugtotcost", "finalcost"), inflate_1415)

#Join the two years together and get an average per year
costs_merge <- merge(costs_1415_inf, costs_1516_inf, by = "patid")

costs <- costs_merge %>% 
  mutate(apc_cost = (apctotcost.x + apctotcost.y)/2) %>% 
  mutate(ae_cost = (aetotcost.x + aetotcost.y)/2) %>% 
  mutate(op_cost = (optotcost.x + optotcost.y)/2) %>% 
  mutate(p_cost = (ptotcost.x + ptotcost.y)/2) %>% 
  mutate(drug_cost = (drugtotcost.x + drugtotcost.y)/2) %>% 
  mutate(total_cost = (finalcost.x + finalcost.y)/2) %>% 
  mutate(hosp_cost = apc_cost + ae_cost + op_cost) %>%
  mutate(elect_cost = (elcost.x + elcost.y)/2) %>%
  mutate(em_cost = (emcost.x + emcost.y)/2) %>%
  mutate(admit_spells = (spells.x + spells.y)/2) %>% 
  mutate(elect_spells = (elects.x + elects.y)/2) %>% 
  mutate(emerg_spells = (emergs.x + emergs.y)/2) %>% 
  mutate(other_spells = (others.x + others.y)/2) %>% 
  mutate(total_los = (los.x + los.y)/2) %>% 
  mutate(ave_los = (avlos.x + avlos.y)/2) %>% 
  mutate(ae_atts = (aeatts.x + aeatts.y)/2) %>% 
  mutate(op_atts = (opatts.x + opatts.y)/2) %>% 
  mutate(p_contacts = (pcontacts.x + pcontacts.y)/2) %>%
  mutate(anyhosp = ifelse(hosp_cost>0, 1, 0)) %>%
  mutate(anyop = ifelse(op_cost>0, 1, 0)) %>%
  mutate(anyelect = ifelse(elect_cost>0, 1, 0)) %>%
  mutate(anyemerg = ifelse(em_cost>0, 1, 0)) %>%
  mutate(anyae = ifelse(ae_cost>0, 1, 0)) %>%
  mutate(anylos = ifelse(total_los>0, 1, 0)) %>%
  mutate(anyprim = ifelse(p_contacts>0, 1, 0))


glm_costs <- select(costs, c(patid, apc_cost, elect_cost, em_cost, ae_cost, op_cost, p_cost, drug_cost, total_cost, hosp_cost, 
                             admit_spells, elect_spells, emerg_spells, other_spells,
                             total_los, ave_los, ae_atts, op_atts, p_contacts, 
                             anyhosp, anyop, anyelect, anyemerg, anyae, anylos, anyprim))

#Join the data together
data_for_glm <- left_join(patient_data, glm_costs, by = c("patid" = "patid"))
#NOTE: there is a warning about different attributes for patid as the one table is from SAS



