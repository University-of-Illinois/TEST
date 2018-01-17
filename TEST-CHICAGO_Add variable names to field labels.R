.libPaths("H:\\R Library")
library(plyr)
library(dplyr)

# Read in the data dictionary from REDCap. Add variable names to field label
# All variables in Master are in DCCRA --> decided to use CRFs from DCCRA
dictionary_dccRA <- read.csv("I:\\PROJECTS\\CHICAGO Plan\\DCC\\DCC RA DBM\\Data Sets\\Data Dictionary\\CHICAGOTrialDCCRA_DataDictionary_2017-11-06.csv", stringsAsFactors = F)

dictionary_dccRA$Field.Label <- paste0("[",dictionary_dccRA$Variable...Field.Name,"]", " ", dictionary_dccRA$Field.Label)

# Remove Spanish forms

Spanish.forms <- grep("_spanish",dictionary_dccRA$Form.Name,value =T)

dictionary_dccRA_noSpanish <- subset(dictionary_dccRA, !Form.Name %in%  Spanish.forms)

# There is one exception to the Spanish form name

dictionary_dccRA_noSpanish <- subset(dictionary_dccRA_noSpanish, Form.Name != "s_caregiver_promis_short_anxiety_depression_sleep")

# Remove forms b_physician_letter_180_days, card_tracker, a_dcc_ra_data_review, data_query
dictionary_dccRA_final <- subset(dictionary_dccRA_noSpanish, !Form.Name %in% c("b_physician_letter_180_days", "card_tracker", "a_dcc_ra_data_review", "data_query") )

write.csv(dictionary_dccRA_final, "I:/General Data_Programs/Data Cluster/CHICAGO PLAN/Hannah/Datasets for sites/Data_dictionary_DCCRA_add variable names.csv", row.names = F, na= "")


# Chart review databases

dictionary_PM_old <- read.csv("I:\\PROJECTS\\CHICAGO Plan\\DCC\\PM Chart Review DBM\\Data Sets\\Data Dictionary\\OLD VERSION_CHICAGOChartReviewForProjectMa_DataDictionary_2017-11-06.csv", stringsAsFactors = F)

dictionary_PM_old$Field.Label <- paste0("[", dictionary_PM_old$Variable...Field.Name,".PM]", " ", dictionary_PM_old$Field.Label)


#write.csv(dictionary_PM_old,"I:\\PROJECTS\\CHICAGO Plan\\DCC\\CRFs with listed variable names\\OLD VERSION_CHICAGOChartReviewForProjectMa_DataDictionary_2017-11-06_add variable names.csv", row.names = F, na = "")

dictionary_PM_new <- read.csv("I:\\PROJECTS\\CHICAGO Plan\\DCC\\PM Chart Review DBM\\Data Sets\\Data Dictionary\\NEW VERSION_CHICAGOPlanProjectManagerChart_DataDictionary_2017-11-06.csv", stringsAsFactors = F)

dictionary_PM_new$Field.Label <- paste0("[", dictionary_PM_new$Variable...Field.Name,".PMnew]", " ", dictionary_PM_new$Field.Label)


#write.csv(dictionary_PM_new,"I:\\PROJECTS\\CHICAGO Plan\\DCC\\CRFs with listed variable names\\NEW VERSION_CHICAGOPlanProjectManagerChart_DataDictionary_2017-11-06_add variable names.csv", row.names = F, na = "")

dictionary_PM <- rbind.fill(dictionary_PM_old, dictionary_PM_new)

# Remove Participant Information Form
#dictionary_PM <- subset(dictionary_PM, Form.Name != "participant_information")
write.csv(dictionary_PM, "I:/General Data_Programs/Data Cluster/CHICAGO PLAN/Hannah/Datasets for sites/Data_dictionary_PM_add variable names.csv",row.names = F, na = "")

dictionary <- rbind.fill(dictionary_dccRA_final, dictionary_PM)
write.csv(dictionary, "I:/General Data_Programs/Data Cluster/CHICAGO PLAN/Hannah/Datasets for sites/Data_dictionary_add variable names.csv",row.names = F, na = "")


#####################################################################################
# Create CRF forms for clinical outcomes only #######################################
# Subset the data dictionary for Asthma Impact Parent Proxy Promis Short, Asthma Impact - Pediatric, cACT, Pediatric Asthma Caregivers QoL, Caregiver Promis Short: Anxiety, Depression, Sleep,Fatigue and Satisfaction forms only
dictionary_dccRA_outcomes <- subset(dictionary_dccRA, Form.Name %in% c("asthma_impact_parent_proxy_promis_short", "e_asthma_impact_pediatric", "e_cact", "pediatric_asthma_caregivers_qol", "caregiver_promis_short_anxiety_depression_sleep_fa"))
write.csv(dictionary_dccRA_outcomes, "I:/General Data_Programs/Data Cluster/CHICAGO PLAN/Hannah/Data/Data_dictionary_outcome.csv",row.names = F, na = "")
