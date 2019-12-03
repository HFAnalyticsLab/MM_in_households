# =======================================================
# Project: Multimorbidity in Households
# Purpose: Descriptive statistics
# Author: Mai Stafford & Kathryn Dreyer
# Date: 19/11/2019
# =======================================================


##########################################################################################
#Cohort Descriptives

# sex
femhh <- table(data_for_glm$female,data_for_glm$selfother)
addmargins(femhh)
prop.table(femhh,1)

# age
agehh <- table(data_for_glm$agec_at50,data_for_glm$selfother)
addmargins(agehh)
prop.table(agehh,1)

# IMD
imdhh <- table(data_for_glm$imd2015_10,data_for_glm$selfother)
addmargins(imdhh)
prop.table(imdhh,1)

##########################################################################################
#Utilisation Descriptives

attach(data_for_glm)
outcomes <- cbind(apc_cost, ae_cost, op_cost, p_cost, drug_cost, total_cost,
                  admit_spells, elect_spells, emerg_spells, other_spells,
                  total_los, ave_los, ae_atts, op_atts, p_contacts, anyhosp, 
                  anyelect, anyemerg, anylos, anyae, anyop, anyprim)
options(scipen = 100)
options(digits=3)
stat.desc(outcomes, basic=F)