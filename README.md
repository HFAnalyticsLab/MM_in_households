# MM_in_households
Multimorbidity in households and health care costs

#### Status: In Progress

## Project Description

As the number of people with multiple long-term conditions grows, meeting their needs will be one of the biggest challenges facing the NHS. Patients with two or more conditions account for over half of [primary and secondary care activity and costs](https://www.health.org.uk/publications/understanding-the-health-care-needs-of-people-with-multiple-health-conditions).                            

The responsibility for managing these conditions falls mostly on the individuals themselves and on their informal carers but people who are less able to effectively manage their conditions [need more care from the NHS](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6288702/). It is important to understand the wider context of people living with multiple conditions and any impact this has on health care activity and costs.

This project examines whether the health care activity and costs of a person with multiple conditions depends on their household health context.

## Data source

We used data from the Clinical Practice Research Datalink (CPRD) linked to Hospital Episode Statistics (HES), ONS mortality and Indices of Multiple Deprivation. ISAC protocol number [17_150RMn2](https://www.cprd.com/protocol/high-need-patients-chronic-conditions-primary-and-secondary-care-utilisation-and-costs).

From an original random sample, we selected a subsample of two-person households. We counted the nunber of conditions they had at baseline (1st April 2014) and calculated their health care activity and cost [described in](https://www.health.org.uk/publications/a-descriptive-analysis-of-health-care-use-by-high-cost-high-need-patients-in-england) over two years of follow-up.

## How does it work?

As the data used for this analysis is not publically available, the code cannot be used to replicate the analysis on this dataset. However, with modifications the code will be able to be used on other patient-level CPRD extracts.

### Requirements

These scripts were written in SAS Enterprise Guide Version 7.12 and RStudio Version 1.1.383. 
The following R packages are used: 

* **[haven](https://cran.r-project.org/web/packages/haven/index.html)**
* **[here](https://cran.r-project.org/web/packages/here/index.html)**
* **[tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html)**

### Getting started

The SAS folder contains:  
* **Derive_twopersonhouseholds**  - Uses the denominator file from CPRD to select patients in two-person households. 
We limited the sample to people aged 50+ that registered at their practice within 1 year of each other. The resulting list of patient IDs can then be merged with other variables for analysis. We merged with data on [multiple conditions](https://github.com/HFAnalyticsLab/High_cost_users/blob/master/Scripts/05_multimorbidity.sas) and [primary and secondary care activity and costs](https://github.com/HFAnalyticsLab/High_cost_users/tree/master/Scripts). 
                                                                                                                            
The R folder contains:   
* **01_Derive_variables_for_regression** - Prepare variables for the two-part regression models

* **02_Two_part_regression_models** - Combines logistic model for whether has a non-zero cost with a gamma distribution for cost where this is non-zero. Predicted values are estimated for each level of household multimorbidity. Confidence intervals are coming soon....

## Authors - please feel free to get in touch
                                                                                                                            
* **Mai Stafford** - [@stafford_xm](https://twitter.com/stafford_xm) -[maistafford](https://github.com/maistafford)
* **Kathryn Dreyer** - [@kathrynadreyer](https://twitter.com/kathrynadreyer) - [kathdreyer](https://github.com/kathdreyer)

## License

This project is licensed under the [MIT License](https://github.com/HFAnalyticsLab/High_cost_users/blob/master/LICENSE).

                                                                                                                           
