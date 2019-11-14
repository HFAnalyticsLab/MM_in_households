

# Multimorbidity in households

#### Status: In Progress

## Contents
* [Project Description](https://github.com/HFAnalyticsLab/MM_in_households/blob/master/README.md#project-description)
                        * [Data Sources](https://github.com/HFAnalyticsLab/MM_in_households/blob/master/README.md#data-sources)
                                         * [How does it work?](https://github.com/HFAnalyticsLab/MM_in_households#how-does-it-work)
                                                               * [Requirements](https://github.com/HFAnalyticsLab/MM_in_households#requirements)
                                                                                * [Getting started](https://github.com/HFAnalyticsLab/MM_in_households#getting-started)
                                                                                                    * [Authors](https://github.com/HFAnalyticsLab/MM_in_households#authors---please-feel-free-to-get-in-touch)
                                                                                                                * [License](https://github.com/HFAnalyticsLab/MM_in_households#license)
                                                                                                                            
                                                                                                                            
                                                                                                                            ## Project Description
                                                                                                                            As the number of people with multiple long-term conditions grows, meeting their needs will be one of the biggest challenges facing the NHS. Patients with two or more conditions account for over half of [primary and secondary care activity and costs](. [downloaded from the Clinical Codes repository](https://www.health.org.uk/publications/understanding-the-health-care-needs-of-people-with-multiple-health-conditions).
                                                                                                                            The responsibility for managing these conditions falls mostly on the individuals themselves and on their informal carers but people who are less able to effectively manage their conditions need more care from the NHS. It is important to understand the wider context of people living with multiple conditions and any inpact this has on health care activity and costs.
                                                                                                                            This project examines whether the health care activity and costs of a person with multiple conditions depends on the household health context
                                                                                                                            
                                                                                                                            ## Data Sources
                                                                                                                            Clinical Practice Research Datalink 
                                                                                                                            Included patients were eligble for linkage to Hospital Episode Statistics, ONS mortality and Indices of Multiple Deprivation
                                                                                                                            Data access for this project has been approved (ISAC 17_150RMn2). 
                                                                                                                            
                                                                                                                            ## How does it work?
                                                                                                                            
                                                                                                                            As the data used for this analysis is not publically available, the code cannot be used to replicate the analysis on this dataset. However, with modifications the code will be able to be used on other patient-level CPRD extracts.
                                                                                                                            
                                                                                                                            ### Requirements
                                                                                                                            
                                                                                                                            These scripts are written in R (version 3.6.1). 
                                                                                                                            The following R packages are used (all available on CRAN):  
                                                                                                                              
                                                                                                                            - [here](https://cran.r-project.org/package=here)         
                                                                                                                            - [plyr](https://cran.r-project.org/package=plyr)
                                                                                                                            - [tidyverse](https://cran.r-project.org/package=tidyverse)  
                                                                                                                            - [haven](https://cran.r-project.org/package=haven)  
                                                                                                                            - [data.table](https://cran.r-project.org/package=data.table)  
                                                                                                                            
                                                                                                                            ### Getting started
                                                                                                                            
                                                                                                                            The SAS folder contains:  
                                                                                                                              1. Derive_twopersonhouseholds.sas  - Uses the denominator file from CPRD to select patients in two-person households. We limited the sample to people aged 50+ that registered at their practice within 1 year of each other. The resulting list of patient IDs can then be merged with other variables for analysis. 
                                                                                                                              We merged with data on [multiple conditions](https://github.com/HFAnalyticsLab/High_cost_users/blob/master/Scripts/05_multimorbidity.sas) and [primary and secondary care activity and costs](https://github.com/HFAnalyticsLab/High_cost_users/tree/master/Scripts) from the HF Analytics Lab High_cost_users project. 
                                                                                                                            
                                                                                                                            The R folder contains:   
                                                                                                                              1. 01_Derive_variables_for_regression.R - Prepare variables for the two-part regression models
                                                                                                                              2. 02_Two_part_regression_models.R - Combines logistic model for whether has a non-zero cost with a gamma distribution for cost where this is non-zero. Predicted values are estimated for each level of household multimorbidity. Confidence intervals are coming soon....
                                                                                                                              
                                                                                                                            
                                                                                                                            ## Authors - please feel free to get in touch
                                                                                                                            
                                                                                                                            - Mai Stafford, PhD - [on github](https://github.com/maistafford) / [on twitter](https://twitter.com/stafford_xm)
                                                                                                                            
                                                                                                                            ## License
                                                                                                                            This project is licensed under the [MIT License](https://github.com/HFAnalyticsLab/IAPT/blob/master/LICENSE).