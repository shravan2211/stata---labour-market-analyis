**********************************************
* PLFS 2023-24 Data Extraction & Processing
* Author: Shravan MK
* Date: 23rd September
* Description: Extracts, labels, merges and 
*              processes Household (HHV1) and 
*              Person (PERV1) visit 1 files 
*              from PLFS 2023-24 raw data.
**********************************************


/*******************************************************************************
* SECTION 1: HOUSEHOLD FILE (HHV1) - Data Extraction
*******************************************************************************/

infix str4 file_identification 1-4 ///
str3 schdule 5-7 ///
str2 quarter 8-9 ///
str2 visit 10-11 ///
str1 sector 12-12 ///
str2 state_ut_code 13-14 ///
str2 district_code 15-16 ///
str3 nss_region 17-19 ///
str2 stratum 20-21 ///
str2 sub_stratum 22-23 ///
str1 sub_sample 24-24 ///
str4 fod_sub_region 25-28 ///
str5 fsu 29-33 ///
str1 sample_sg_sb_no 34-34 ///
str1 second_stage_stratum 35-35 ///
str2 sample_hh_number 36-37 ///
str2 month_of_survey 38-39 ///
str1 response_code 40-40 ///
str1 survey_code 41-41 ///
str1 reason_for_substitution 42-42 ///
str2 household_size 43-44 ///
str1 household_type 45-45 ///
str1 religion 46-46 ///
str1 social_group 47-47 /// 
str8 hh_expenditure_month_goodssvs 48-55 ///
str8 imputed_value_homegrown_stock 56-63 ///
str8 imputed_value_wages_free 64-71 ///
str8 hh_annual_exp_clothing_etc 72-79 ///
str8 hh_annual_exp_fridgetv 80-87 ///
str8 hh_consumption_exp_month 88-95 ///
str2 informant_slno 96-97 ///
str8 survey_date 98-105 ///
str4 total_time_taken_to_canvass 106-109 ///
str3 nss 110-112 ///
str3 nsc 113-115 ///
str10 multiplier 116-125 ///
str1 number_quarter 126-126 using "C:\Users\user\Documents\HHV1.TXT"
*(101,920 observations read)*


********************************************************************************
* Labelling of variables 
********************************************************************************
label var file_identification "File Identification"
label var schdule "Schdule"
label var quarter "Quarter"
label var visit "Visit"
label var sector "Sector"
label var state_ut_code "State/Ut Code"
label var district_code "District Code"
label var nss_region "NSS-Region"
label var stratum "Stratum"
label var sub_stratum "Sub-Stratum"
label var sub_sample "Sub-Sample"
label var fod_sub_region "Fod Sub-Region"
label var fsu "FSU"
label var sample_sg_sb_no "Sample Sg/Sb No."
label var second_stage_stratum "Second Stage Stratum No."
label var sample_hh_number "Sample Household Number"
label var month_of_survey "Month of Survey"
label var response_code "Response Code"
label var survey_code "Survey Code"
label var reason_for_substitution "Reason for Substitution of original household"
label var household_size "Household Size"
label var household_type "Household Type"
label var religion "Religion"
label var social_group "Social Group"
label var hh_expenditure_month_goodssvs "Household's Monthly consumer Expenditure for Goods and Services"
label var imputed_value_homegrown_stock "Imputed value of usual consumption in a month Home Grown stock"
label var imputed_value_wages_free "Imputed value of Monthly consumption from wages in kind,free collection, gifts"
label var hh_annual_exp_clothing_etc "Household's Annual Expenditure on purchase of items like clothing, footwear etc"
label var hh_annual_exp_fridgetv "Household's Annual Expenditure on purchase of durables like Bedstead, TV, fridge etc"
label var hh_consumption_exp_month "Household'S Usual Consumer Expenditure In A Month"
label var informant_slno "Informant Serial no."
label var survey_date "Survey Date"
label var total_time_taken_to_canvass "Total Time Taken To Canvass"
label var nss "NSS"
label var nsc "NSC"
label var multiplier "Sub-sample wise Multiplier"
label var number_quarter "Occurance of State*Sec*Str*SStr in 4 quaters"

/*******************************************************************************
* HHID Generation (Common Identifier Across Households)
*******************************************************************************/

egen hhid = concat(quarter visit fsu sample_sg_sb_no second_stage_stratum sample_hh_number)
label var hhid "Unique HHID (Generated)"
order hhid

* Saving the hh file in dta format
cd "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024"
save "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024\hhv1.dta" , replace


/*******************************************************************************
* SECTION 2: PERSON FILE (PERV1) - Data Extraction
*******************************************************************************/

infix str4 file_identification 1-4  ///
str3 schdule 5-7  ///
str2 quarter 8-9  ///
str2 visit 10-11  ///
str1 sector 12-12  ///
str2 state_code 13-14  ///
str2 district_code 15-16  ///
str3 nss_region 17-19  ///
str2 stratum 20-21  ///
str2 sub_stratum 22-23  ///
str1 sub_sample 24-24  ///
str4 fod_sub_region 25-28  ///
str5 fsu 29-33  ///
str1 sample_sg_sb_no 34-34  ///
str1 second_stage_stratum 35-35  ///
str2 sample_hh_number 36-37  ///
str2 person_serial_no 38-39  ///
str1 relationship_to_head 40-40  ///
str1 sex 41-41  ///
str3 age 42-44  ///
str1 marital_status 45-45  ///
str2 general_educaion 46-47  ///
str2 technical_educaion 48-49  ///
str2 years_formal_education 50-51  ///
str2 status_of_current_attendance 52-53  ///
str1 received_voc_training 54-54  ///
str1 completed_training_365days 55-55  ///
str2 field_of_training 56-57  ///
str1 duration_of_training 58-58  ///
str1 type_of_training 59-59  ///
str1 source_funding_training 60-60  ///
str2 upa_status_code 61-62  ///
str5 upa_industry_code 63-67  ///
str3 occupation_code 68-70  ///
str1 engaged_in_subsidiary_capacity 71-71  ///
str2 upa_location_workplace 72-73  ///
str2 upa_enterprise_type 74-75  ///
str1 upa_no_workers_enterprise 76-76  ///
str1 upa_type_of_job_contract 77-77  ///
str1 upa_eligble_of_paid_leave 78-78  ///
str1 upa_social_security_benefits 79-79  ///
str1 upa_usage_product 80-80  ///
str2 upss_status_code 81-82  ///
str5 upss_industry_code 83-87  ///
str3 upss_occupation_code 88-90  ///
str2 upss_location_workplace 91-92  ///
str2 upss_enterprise_type 93-94  ///
str1 upss_no_workers_enterprise 95-95  ///
str1 upss_type_of_job_contract 96-96  ///
str1 upss_eligble_of_paid_leave 97-97  ///
str1 upss_social_security_benefits 98-98  ///
str1 upss_usage_product 99-99  ///
str1 worked_prior_365days 100-100  ///
str1 duration_upa 101-101  ///
str1 duration_upss 102-102  ///
str1 efforts_search_work 103-103  ///
str1 duration_of_spell_unemployment 104-104  ///
str1 whether_ever_worked  105-105  ///
str1 reason_not_working_last_365days 106-107  ///
str1 main_reason_to_principal_stat  108-108  ///
str2 status_act1_7thday 109-110  ///
str2 industry_act1_7thday 111-112  ///
str2 hours_act1_7thday 113-114  ///
str5 wage_act1_7thday 115-119  ///
str2 status_act2_7thday 120-121  ///
str2 industry_act2_7thday 122-123  ///
str2 hours_act2_7thday 124-125  ///
str5 wage_act2_7thday 126-130  ///
str2 total_hoursworked_7thday 131-132  ///
str2 hours_worked_7thday 133-134  ///
str2 status_act1_6thday 135-136  ///
str2 industry_act1_6thday 137-138  ///
str2 hours_act1_6thday 139-140  ///
str5 wage_act1_6thday 141-145  ///
str2 status_act2_6thday 146-147  ///
str2 industry_act2_6thday 148-149  ///
str2 hours_worked_act2_6thday 150-151  ///
str5 wage_act2_6thday 152-156  ///
str2 total_hoursworked_6thday 157-158  ///
str2 hours_worked_6thday 159-160  ///
str2 status_act1_5thday 161-162  ///
str2 industry_act1_5thday 163-164  ///
str2 hours_worked_act1_5thday 165-166  ///
str5 wage_act1_5thday 167-171  ///
str2 status_act2_5thday 172-173  ///
str2 industry_act2_5thday 174-175  ///
str2 hours_worked_act2_5thday 176-177  ///
str5 wage_act2_5thday 178-182  ///
str2 hours_act2_5thday 183-184  ///
str2 hours_worked_5thday 185-186  ///
str2 status_act1_4thday 187-188  ///
str2 industry_act1_4thday 189-190  ///
str2 hours_worked_act1_4thday 191-192  ///
str5 wage_act1_4thday 193-197  ///
str2 status_code_act2_4thday 198-199  ///
str2 industry_code_act2_4thday 200-201  ///
str2 hours_worked_act2_4thday 202-203  ///
str5 wage_act2_4thday 204-208  ///
str2 total_hoursworked_4thday 209-210  ///
str2 hours_worked_4thday 211-212  ///
str2 status_act1_3rdday 213-214  ///
str2 industry_act1_3rdday 215-216  ///
str2 hours_worked_act1_3rdday 217-218  ///
str5 wage_act1_3rdday 219-223  ///
str2 status_act2_3rdday 224-225  ///
str2 industry_act2_3rdday 226-227  ///
str2 hours_worked_act2_3rdday 228-229  ///
str5 wage_act2_3rdday 230-234  ///
str2 total_hoursworked_3rdday 235-236  ///
str2 hours_worked_3rdday 237-238  ///
str2 status_act1_2ndday 239-240  ///
str2 industry_act1_2ndday 241-242  ///
str2 hours_worked_act1_2ndday 243-244  ///
str5 wage_act1_2ndday 245-249  ///
str2 status_act2_2ndday 250-251  ///
str2 industry_act2_2ndday 252-253  ///
str2 hours_worked_act2_2ndday 254-255  ///
str5 wage_act2_2ndday 256-260  ///
str2 total_hoursworked_2ndday 261-262  ///
str2 hours_worked_2ndday 263-264  ///
str2 status_act1_1stday 265-266  ///
str2 industry_act1_1stday 267-268  ///
str2 hours_worked_act1_1stday 269-270  ///
str5 wage_act1_1stday 271-275  ///
str2 status_act2_1stday 276-277  ///
str2 industry_act2_1stday 278-279  ///
str2 hours_worked_act2_1stday 280-281  ///
str5 wage_earning_act2_1stday 282-286  ///
str2 total_hoursworked_1stday 287-288  ///
str2 hours_worked_1stday 289-290  ///
str2 current_weekly_status 291-292  ///
str2 cws_industrycode 293-294  ///
str3 cws_occupationcode 295-297  ///
str8 earnings_salaried 298-305  ///
str8 earnings_selfemployed 306-313  ///
str3 nss 314-316  ///
str3 nsc 317-319  ///
str10 multiplier 320-329  ///
str1 number_quarter 330-330 using "C:\Users\user\Downloads\PERV1.TXT"


********************************************************************************
* Labelling Variables
********************************************************************************

lab var file_identification "File Identification"
lab var schdule "Schdule"
lab var quarter "Quarter"
lab var visit "Visit"
lab var sector "Sector"
lab var state_code "State/Ut Code"
lab var district_code "District Code"
lab var nss_region "NSS-Region"
lab var stratum "Stratum"
lab var sub_stratum "Sub-Stratum"
lab var sub_sample "Sub-Sample"
lab var fod_sub_region "Fod Sub-Region"
lab var fsu "FSU"
lab var sample_sg_sb "Sample Sg/Sb No."
lab var second_stage_stratum "Second Stage Stratum No."
lab var sample_hh_number "Sample Household Number"
lab var person_serial_no "Person Serial No."
lab var relationship_to_head "Relationship To Head"
lab var sex "Sex"
lab var age "Age"
lab var marital_status "Marital Status"
lab var general_educaion "General Educaion Level"
lab var technical_educaion "Technical Educaion Level"
lab var years_formal_education "No. of years in Formal Education"
lab var status_of_current_attendance "Status of Current Attendance in Educational Institution"
lab var received_voc_training "Whether received any Vocational/Technical Training"
lab var completed_training_365days "Whether Training completed during last 365 Days"
lab var field_of_training "Field Of Training"
lab var duration_of_training "Duration Of Training"
lab var type_of_training "Type Of Training"
lab var source_funding_training "Source Of Funding The Training"
lab var upa_status_code "Status Code"
lab var upa_industry_code "Industry Code (NIC)"
lab var occupation_code "Occupation Code (NCO)"
lab var engaged_in_subsidiary_capacity "Whether Engaged In Any Work In Subsidiary Capacity"
lab var upa_location_workplace "(Principal)location Of Workplace Code"
lab var upa_enterprise_type "(Principal) Enterprise Type Code"
lab var upa_no_workers_enterprise "(Principal) No. Of Workers In The Enterprise"
lab var upa_type_of_job_contract "(Principal)  Type Of Job Contract"
lab var upa_eligble_of_paid_leave "(Principal) Eligble Of Paid Leave"
lab var upa_social_security_benefits "(Principal) Social Security Benefits"
lab var upa_usage_product "(Principal) Usage of product of the economic activity"
lab var upss_status_code "Status Code"
lab var upss_industry_code "Industry Code (NIC)"
lab var upss_occupation_code "Occupation Code (NCO)"
lab var upss_location_workplace "(Subsidiary) location Of Workplace Code"
lab var upss_enterprise_type "(Subsidiary)  Enterprise Type Code"
lab var upss_no_workers_enterprise "(Subsidiary)  No. Of Workers In The Enterprise"
lab var upss_type_of_job_contract "(Subsidiary)   Type Of Job Contract"
lab var upss_eligble_of_paid_leave "(Subsidiary)  Eligble Of Paid Leave"
lab var upss_social_security_benefits "(Subsidiary)  Social Security Benefits"
lab var upss_usage_product "(Subsidiary) Usage of product of the economic activity"
lab var worked_prior_365days "Ever Worked Prior to last 365 days"
lab var duration_upa "Duration of engagement in the economic activity in usual Principal Activity Status"
lab var duration_upss "Duration of engagement in the economic activity in Subsidiary Activity Status"
lab var efforts_search_work "Efforts undertaken to search work"
lab var duration_of_spell_unemployment "Duration of spell of Unemployment"
lab var whether_ever_worked "Whether Ever Worked"
lab var reason_not_working_last_365days "Reason for not working in last 365 days"
lab var main_reason_to_principal_stat "Main reason for being in Principal activity status (91 to 97)"
lab var status_act1_7thday "Status Code for activity 1"
lab var industry_act1_7thday "Industry Code (NIC) for activity 1"
lab var hours_act1_7thday "hours actually worked for activity 1 on 7th day"
lab var wage_act1_7thday "wage earning for activity 1 on 7th day"
lab var status_act2_7thday "Status Code for activity 2"
lab var industry_act2_7thday "Industry Code (NIC) for activity 2"
lab var hours_act2_7thday "hours actually worked for activity 2 on 7th day"
lab var wage_act2_7thday "wage earning for activity 2 on 7th day"
lab var total_hoursworked_7thday "total hours actually worked on 7th day"
lab var hours_worked_7thday "hours available for additional work on 7th day"
lab var status_act1_6thday "Status Code for activity 1"
lab var industry_act1_6thday "Industry Code (NIC) for activity 1"
lab var hours_act1_6thday "hours actually worked for activity 1 on 6th day"
lab var wage_act1_6thday "wage earning for activity 1 on 6th day"
lab var status_act2_6thday "Status Code for activity 2"
lab var industry_act2_6thday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_6thday "hours actually worked for activity 2 on 6th day"
lab var wage_act2_6thday "wage earning for activity 2 on 6th day"
lab var total_hoursworked_6thday "total hours actually worked on 6th day"
lab var hours_worked_6thday "hours available for additional work on 6th day"
lab var status_act1_5thday "Status Code for activity 1"
lab var industry_act1_5thday "Industry Code (NIC) for activity 1"
lab var hours_worked_act1_5thday "hours actually worked for activity 1 on 5th day"
lab var wage_act1_5thday "wage earning for activity 1 on 5th day"
lab var status_act2_5thday "Status Code for activity 2"
lab var industry_act2_5thday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_5thday "hours actually worked for activity 2 on 5th day"
lab var wage_act2_5thday "wage earning for activity 2 on 5th day"
lab var hours_act2_5thday "total hours actually worked on 5th day"
lab var hours_worked_5thday "hours available for additional work on 5th day"
lab var status_act1_4thday "Status Code for activity 1"
lab var industry_act1_4thday "Industry Code (NIC) for activity 1"
lab var hours_worked_act1_4thday "hours actually worked for activity 1 on 4th day"
lab var wage_act1_4thday "wage earning for activity 1 on 4th day"
lab var status_code_act2_4thday "Status Code for activity 2"
lab var industry_code_act2_4thday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_4thday "hours actually worked for activity 2 on 4th day"
lab var wage_act2_4thday "wage earning for activity 2 on 4th day"
lab var total_hoursworked_4thday "total hours actually worked on 4th day"
lab var hours_worked_4thday "hours available for additional work on 4th day"
lab var status_act1_3rdday "Status Code for activity 1"
lab var industry_act1_3rdday "Industry Code (NIC) for activity 1"
lab var hours_worked_act1_3rdday "hours actually worked for activity 1 on 3rd day"
lab var wage_act1_3rdday "wage earning for activity 1 on 3rd day"
lab var status_act2_3rdday "Status Code for activity 2"
lab var industry_act2_3rdday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_3rdday "hours actually worked for activity 2 on 3rd day"
lab var wage_act2_3rdday "wage earning for activity 2 on 3rd day"
lab var total_hoursworked_3rdday "total hours actually worked on 3rd day"
lab var hours_worked_3rdday "hours available for additional work on 3rd day"
lab var status_act1_2ndday "Status Code for activity 1"
lab var industry_act1_2ndday "Industry Code (NIC) for activity 1"
lab var hours_worked_act1_2ndday "hours actually worked for activity 1 on 2nd day"
lab var wage_act1_2ndday "wage earning for activity 1 on 2nd day"
lab var status_act2_2ndday "Status Code for activity 2"
lab var industry_act2_2ndday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_2ndday "hours actually worked for activity 2 on 2nd day"
lab var wage_act2_2ndday "wage earning for activity 2 on 2nd day"
lab var total_hoursworked_2ndday "total hours actually worked on 2nd day"
lab var hours_worked_2ndday "hours available for additional work on 2nd day"
lab var status_act1_1stday "Status Code for activity 1"
lab var industry_act1_1stday "Industry Code (NIC) for activity 1"
lab var hours_worked_act1_1stday "hours actually worked for activity 1 on 1st day"
lab var wage_act1_1stday "wage earning for activity 1 on 1st day"
lab var status_act2_1stday "Status Code for activity 2"
lab var industry_act2_1stday "Industry Code (NIC) for activity 2"
lab var hours_worked_act2_1stday "hours actually worked for activity 2 on 1st day"
lab var wage_earning_act2_1stday "wage earning for activity 2 on 1st day"
lab var total_hoursworked_1stday "total hours actually worked on 1st day"
lab var hours_worked_1stday "hours available for additional work on 1st day"
lab var current_weekly_status "Current Weekly Status (CWS)"
lab var cws_industrycode "Industry Code (CWS)"
lab var cws_occupationcode "Occupation Code (CWS)"
lab var earnings_salaried "Earnings For Regular Salaried/Wage Activity"
lab var earnings_selfemployed "Earnings For Self-Employed Activity"
lab var nss "Ns count for sector x stratum x substratum x sub-sample"
lab var nsc "Ns count for sector x stratum x substratum"
lab var multiplier "Sub-sample wise Multiplier"
lab var number_quarter "Occurance of FSUs in State x Sector x Stratum x SubStratum in 4 Quarters"


/*******************************************************************************
* SECTION 3: UNIQUE IDENTIFIERS - HHID and Person ID
*******************************************************************************/

* HHID
egen hhid = concat(quarter visit fsu sample_sg_sb_no second_stage_stratum sample_hh_number)

* Person ID
egen pid = concat(hhid person_serial_no)

lab var pid "Person ID (Generated)"
order hhid pid

* Save in dta format
cd "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024"
save "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024\PERV1.dta" , replace


/*******************************************************************************
* SECTION 4: MERGE - Person File (Visit 1) with Household File (Visit 1)
*******************************************************************************/

use "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024\PERV1.dta", clear

merge m:1 hhid using "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024\hhv1.dta"


/*******************************************************************************
* SECTION 5: RENAMING VARIABLES
*******************************************************************************/

ren file_identification file_id_p
ren schdule schedule 
ren quarter qtr_p
ren visit visit_p
ren sector sector
ren state_code state
ren district_code district
ren nss_region state_region
ren stratum stratum
ren sub_stratum substratum
ren sub_sample subsample 
ren fod_sub_region fodsubregion
ren fsu fsu
ren sample_sg_sb_no hg_subblk
ren second_stage_stratum second_stage_stratum
ren sample_hh_number hhsno
ren person_serial_no psno
ren relationship_to_head rel_hhh
ren sex sex
ren age age
ren marital_status marital
ren general_educaion g_edu
ren technical_educaion t_edu_p
ren years_formal_education yrs_formaledu_p
ren status_of_current_attendance current_attend_eduinst
ren received_voc_training voc_train_received
ren completed_training_365days voc_trng_365days_p
ren field_of_training field_voc_train
ren duration_of_training voc_trng_duration_p
ren type_of_training voc_trng_type_p
ren source_funding_training voc_trng_funding_p
ren upa_status_code upa_status
ren upa_industry_code upa_nic5d2008
ren occupation_code upa_nco3d2004
ren engaged_in_subsidiary_capacity whether_subact
ren upa_location_workplace upa_location_workplace
ren upa_enterprise_type upa_enterprise_type
ren upa_no_workers_enterprise upa_enterprise_size
ren upa_type_of_job_contract upa_contract_type
ren upa_eligble_of_paid_leave upa_paid_leave
ren upa_social_security_benefits upa_ss_benefits
ren upss_status_code usa_status
ren upss_industry_code usa_nic5d2008
ren upss_occupation_code usa_nco3d2004
ren upss_location_workplace usa_location_workplace
ren upss_enterprise_type usa_enterprise_type
ren upss_no_workers_enterprise usa_enterprise_size
ren upss_type_of_job_contract usa_contract_type
ren upss_eligble_of_paid_leave usa_paid_leave
ren upss_social_security_benefits usa_ss_benefits
ren status_act1_7thday cds_act1_7_p
ren industry_act1_7thday cds_act1_nic_7_p
ren hours_act1_7thday cds_act1_hrs_wrkd_7_p
ren wage_act1_7thday cds_act1_wage_7_p
ren status_act2_7thday cds_act2_7_p
ren industry_act2_7thday cds_act2_nic_7_p
ren hours_act2_7thday cds_act2_hrs_wrkd_7_p
ren wage_act2_7thday cds_act2_wage_7_p
ren total_hoursworked_7thday cds_total_hrs_wrkd_7_p
ren hours_worked_7thday cds_total_hrs_available_7_p
ren status_act1_6thday cds_act1_6_p
ren industry_act1_6thday cds_act1_nic_6_p
ren hours_act1_6thday cds_act1_hrs_wrkd_6_p
ren wage_act1_6thday cds_act1_wage_6_p
ren status_act2_6thday cds_act2_6_p
ren industry_act2_6thday cds_act2_nic_6_p
ren hours_worked_act2_6thday cds_act2_hrs_wrkd_6_p
ren wage_act2_6thday cds_act2_wage_6_p
ren total_hoursworked_6thday cds_total_hrs_wrkd_6_p
ren hours_worked_6thday cds_total_hrs_available_6_p
ren status_act1_5thday cds_act1_5_p
ren industry_act1_5thday cds_act1_nic_5_p
ren hours_worked_act1_5thday cds_act1_hrs_wrkd_5_p
ren wage_act1_5thday cds_act1_wage_5_p
ren status_act2_5thday cds_act2_5_p
ren industry_act2_5thday cds_act2_nic_5_p
ren hours_worked_act2_5thday cds_act2_hrs_wrkd_5_p
ren wage_act2_5thday cds_act2_wage_5_p
ren hours_act2_5thday cds_total_hrs_wrkd_5_p
ren hours_worked_5thday cds_total_hrs_available_5_p
ren status_act1_4thday cds_act1_4_p
ren industry_act1_4thday cds_act1_nic_4_p
ren hours_worked_act1_4thday cds_act1_hrs_wrkd_4_p
ren wage_act1_4thday cds_act1_wage_4_p
ren status_code_act2_4thday cds_act2_4_p
ren industry_code_act2_4thday cds_act2_nic_4_p
ren hours_worked_act2_4thday cds_act2_hrs_wrkd_4_p
ren wage_act2_4thday cds_act2_wage_4_p
ren total_hoursworked_4thday cds_total_hrs_wrkd_4_p
ren hours_worked_4thday cds_total_hrs_available_4_p
ren status_act1_3rdday cds_act1_3_p
ren industry_act1_3rdday cds_act1_nic_3_p
ren hours_worked_act1_3rdday cds_act1_hrs_wrkd_3_p
ren wage_act1_3rdday cds_act1_wage_3_p
ren status_act2_3rdday cds_act2_3_p
ren industry_act2_3rdday cds_act2_nic_3_p
ren hours_worked_act2_3rdday cds_act2_hrs_wrkd_3_p
ren wage_act2_3rdday cds_act2_wage_3_p
ren total_hoursworked_3rdday cds_total_hrs_wrkd_3_p
ren hours_worked_3rdday cds_total_hrs_available_3_p
ren status_act1_2ndday cds_act1_2_p
ren industry_act1_2ndday cds_act1_nic_2_p
ren hours_worked_act1_2ndday cds_act1_hrs_wrkd_2_p
ren wage_act1_2ndday cds_act1_wage_2_p
ren status_act2_2ndday cds_act2_2_p
ren industry_act2_2ndday cds_act2_nic_2_p
ren hours_worked_act2_2ndday cds_act2_hrs_wrkd_2_p
ren wage_act2_2ndday cds_act2_wage_2_p
ren total_hoursworked_2ndday cds_total_hrs_wrkd_2_p
ren hours_worked_2ndday cds_total_hrs_available_2_p
ren status_act1_1stday cds_act1_1_p
ren industry_act1_1stday cds_act1_nic_1_p
ren hours_worked_act1_1stday cds_act1_hrs_wrkd_1_p
ren wage_act1_1stday cds_act1_wage_1_p
ren status_act2_1stday cds_act2_1_p
ren industry_act2_1stday cds_act2_nic_1_p
ren hours_worked_act2_1stday cds_act2_hrs_wrkd_1_p
ren wage_earning_act2_1stday cds_act2_wage_1_p
ren total_hoursworked_1stday cds_total_hrs_wrkd_1_p
ren hours_worked_1stday cds_total_hrs_available_1_p
ren current_weekly_status cwas
ren cws_industrycode cwas_nic5d2008
ren cws_occupationcode cwas_nco3d2004
ren earnings_salaried cws_monthly_earnings_regsalaried
ren earnings_selfemployed cws_monthly_earnings_selfemp
ren month_of_survey month_survey_p
ren reason_for_substitution substitution_code
ren household_size hh_size
ren household_type hh_type
ren hh_expenditure_month_goodssvs mhce
ren informant_slno informant_sno
ren survey_date date_survey
ren total_time_taken_to_canvass time_sch10_0
ren nss _23nss
ren nsc _23nsc
ren multiplier _23mlt
ren number_quarter _23_no_qtrs


/*******************************************************************************
* SECTION 6: WEIGHTS GENERATION
*******************************************************************************/

destring _23mlt, replace
gen weight = .
replace weight = _23mlt/100 if _23nss == _23nsc
replace weight = _23mlt/200 if _23nss != _23nsc


/*******************************************************************************
* SECTION 7: CONVERT STRING TO NUMERIC
*******************************************************************************/

destring age schedule sector state district state_region stratum substratum subsample fsu hg_subblk second_stage_stratum hhsno response_code survey_code substitution_code hh_size hh_type religion social_group mhce time_sch10_0 _23nss _23nsc _23_no_qtrs psno rel_hhh sex marital g_edu t_edu_p yrs_formaledu_p current_attend_eduinst voc_train_received voc_trng_365days_p voc_trng_duration_p voc_trng_type_p voc_trng_funding_p upa_status upa_enterprise_size upa_usage_product whether_subact upa_location_workplace upa_enterprise_type upa_contract_type upa_paid_leave upa_ss_benefits usa_status usa_nco3d2004 usa_location_workplace usa_enterprise_type usa_enterprise_size usa_contract_type usa_paid_leave usa_ss_benefits worked_prior_365days duration_upa duration_upss efforts_search_work duration_of_spell_unemployment whether_ever_worked reason_not_working_last_365days state cds_act1_7_p cds_act1_nic_7_p cds_act1_hrs_wrkd_7_p cds_act1_wage_7_p cds_act2_7_p cds_act2_nic_7_p cds_act2_hrs_wrkd_7_p cds_act2_wage_7_p cds_total_hrs_wrkd_7_p cds_total_hrs_available_7_p cds_act1_6_p cds_act1_nic_6_p cds_act1_hrs_wrkd_6_p cds_act1_wage_6_p cds_act2_6_p cds_act2_nic_6_p cds_act2_hrs_wrkd_6_p cds_act2_wage_6_p cds_total_hrs_wrkd_6_p cds_total_hrs_available_6_p cds_act1_5_p cds_act1_nic_5_p cds_act1_hrs_wrkd_5_p cds_act1_wage_5_p cds_act2_5_p cds_act2_nic_5_p cds_act2_hrs_wrkd_5_p cds_act2_wage_5_p cds_total_hrs_wrkd_5_p cds_total_hrs_available_5_p cds_act1_4_p cds_act1_nic_4_p cds_act1_hrs_wrkd_4_p cds_act1_wage_4_p cds_act2_4_p cds_act2_nic_4_p cds_act2_hrs_wrkd_4_p cds_act2_wage_4_p cds_total_hrs_wrkd_4_p cds_total_hrs_available_4_p cds_act1_3_p cds_act1_nic_3_p cds_act1_hrs_wrkd_3_p cds_act1_wage_3_p cds_act2_3_p cds_act2_nic_3_p cds_act2_hrs_wrkd_3_p cds_act2_wage_3_p cds_total_hrs_wrkd_3_p cds_total_hrs_available_3_p cds_act1_2_p cds_act1_nic_2_p cds_act1_hrs_wrkd_2_p cds_act1_wage_2_p cds_act2_2_p cds_act2_nic_2_p cds_act2_hrs_wrkd_2_p cds_act2_wage_2_p cds_total_hrs_wrkd_2_p cds_total_hrs_available_2_p cds_act1_1_p cds_act1_nic_1_p cds_act1_hrs_wrkd_1_p cds_act1_wage_1_p cds_act2_1_p cds_act2_nic_1_p cds_act2_hrs_wrkd_1_p cds_act2_wage_1_p cds_total_hrs_wrkd_1_p cds_total_hrs_available_1_p cwas cwas_nic5d2008 cws_monthly_earnings_regsalaried cws_monthly_earnings_selfemp field_voc_train imputed_value_homegrown_stock imputed_value_wages_free hh_annual_exp_clothing_etc hh_annual_exp_fridgetv hh_consumption_exp_month informant_sno, replace


/*******************************************************************************
* SECTION 8: STATE CODE HARMONISATION
* Syncing state codes across PLFS rounds (55th, 61st, 68th) to create
* a consistent identifier including new states (Telangana, Ladakh)
*******************************************************************************/

tostring state, replace
gen scode_full = .

replace scode_full = 1  if state == "28"   // Andhra Pradesh
replace scode_full = 24 if state == "12"   // Arunachal Pradesh
replace scode_full = 2  if state == "18"   // Assam
replace scode_full = 3  if state == "10"   // Bihar
replace scode_full = 28 if state == "30"   // Goa
replace scode_full = 4  if state == "24"   // Gujarat
replace scode_full = 5  if state == "6"    // Haryana
replace scode_full = 6  if state == "2"    // Himachal Pradesh
replace scode_full = 7  if state == "1"    // Jammu & Kashmir
replace scode_full = 8  if state == "29"   // Karnataka
replace scode_full = 9  if state == "32"   // Kerala
replace scode_full = 10 if state == "23"   // Madhya Pradesh
replace scode_full = 11 if state == "27"   // Maharashtra
replace scode_full = 12 if state == "14"   // Manipur
replace scode_full = 13 if state == "17"   // Meghalaya
replace scode_full = 30 if state == "15"   // Mizoram
replace scode_full = 14 if state == "13"   // Nagaland
replace scode_full = 15 if state == "21"   // Orissa
replace scode_full = 16 if state == "3"    // Punjab
replace scode_full = 17 if state == "8"    // Rajasthan
replace scode_full = 18 if state == "11"   // Sikkim
replace scode_full = 19 if state == "33"   // Tamil Nadu
replace scode_full = 20 if state == "16"   // Tripura
replace scode_full = 21 if state == "9"    // Uttar Pradesh
replace scode_full = 22 if state == "19"   // West Bengal
replace scode_full = 23 if state == "35"   // A & N Islands
replace scode_full = 25 if state == "4"    // Chandigarh
replace scode_full = 32 if state == "25"   // Daman & Diu and D & N Haveli
replace scode_full = 27 if state == "7"    // Delhi
replace scode_full = 29 if state == "31"   // Lakshadweep
replace scode_full = 31 if state == "34"   // Pondicherry
replace scode_full = 33 if state == "22"   // Chhattisgarh
replace scode_full = 34 if state == "20"   // Jharkhand
replace scode_full = 35 if state == "5"    // Uttarakhand
replace scode_full = 36 if state == "36"   // Telangana
replace scode_full = 37 if state == "37"   // Ladakh

label define state_f 1 "Andhra Pradesh" 2 "Assam" 3 "Bihar" 4 "Gujarat" 5 "Haryana" 6 "Himachal Pradesh" 7 "Jammu & Kashmir" 8 "Karnataka" 9 "Kerala" 10 "Madhya Pradesh" 11 "Maharashtra" 12 "Manipur" 13 "Meghalaya" 14 "Nagaland" 15 "Orissa" 16 "Punjab" 17 "Rajasthan" 18 "Sikkim" 19 "Tamil Nadu" 20 "Tripura" 21 "Uttar Pradesh" 22 "West Bengal" 23 "A & N Islands" 24 "Arunachal Pradesh" 25 "Chandigarh" 26 "Dadra & Nagar Haveli" 27 "Delhi" 28 "Goa" 29 "Lakshadweep" 30 "Mizoram" 31 "Pondicherry" 32 "Daman & Diu and D & N Haveli" 33 "Chhattisgarh" 34 "Jharkhand" 35 "Uttarakhand" 36 "Telangana" 37 "Ladakh"

label val scode_full state_f
label var scode_full "State code synced across 55th, 61st, 68th PLFS rounds with unique codes for new states"


/*******************************************************************************
* SECTION 9: CLEANING EARNINGS VARIABLES
* Set earnings to missing for activity statuses where earnings are not applicable
*******************************************************************************/

* Self-employment earnings: set to missing for non-self-employed statuses
replace cws_monthly_earnings_selfemp = . if inrange(cwas, 31, 51) | inrange(cwas, 71, 99)

* Salaried earnings: set to missing for non-salaried statuses
replace cws_monthly_earnings_regsalaried = . if (inrange(cwas, 11, 21)) | inrange(cwas, 41, 62) | inrange(cwas, 81, 99)

* Daily activity wages: set to missing where status is not wage employment
replace cds_act1_wage_7_p = . if inrange(cds_act1_7_p, 11, 31) | inrange(cds_act1_7_p, 61, 99)
replace cds_act1_wage_6_p = . if inrange(cds_act1_6_p, 11, 31) | inrange(cds_act1_6_p, 61, 99)
replace cds_act1_wage_5_p = . if inrange(cds_act1_5_p, 11, 31) | inrange(cds_act1_5_p, 61, 99)
replace cds_act1_wage_4_p = . if inrange(cds_act1_4_p, 11, 31) | inrange(cds_act1_4_p, 61, 99)
replace cds_act1_wage_3_p = . if inrange(cds_act1_3_p, 11, 31) | inrange(cds_act1_3_p, 61, 99)
replace cds_act1_wage_2_p = . if inrange(cds_act1_2_p, 11, 31) | inrange(cds_act1_2_p, 61, 99)
replace cds_act1_wage_1_p = . if inrange(cds_act1_1_p, 11, 31) | inrange(cds_act1_1_p, 61, 99)

save "C:\Users\user\cse Dropbox\Shravan  MK\plfs2024\allblocks_merged_2023.dta", replace


/*******************************************************************************
* SECTION 10: CROSS-CHECK WITH PLFS REPORT NUMBERS
* Labour Force Participation, WPR, and Unemployment Rate (Usual Status ps+ss)
*******************************************************************************/

use "C:\Users\hp\Downloads\2017_allblocks_merged.dta", clear

destring upa_status, replace
destring usa_status, replace

* Labour force participation
gen lf = (upa_status < 90 | usa_status < 90)
lab var lf "In the labour force"

* Unemployment
gen unemployed = (upa_status == 81 & usa_status == .)
lab var unemployed "Unemployed"

tab lf unemployed if age >= 15 [aw = weight], col nofreq
bysort sector: tab lf unemployed if age >= 15 [aw = weight], col nofreq

* Worker Population Ratio (WPR) - Usual Status (ps+ss)
gen employed = ((upa_status <= 51 & upa_status >= 11) | (usa_status <= 51 & usa_status >= 11))
tab employed if age >= 15 [aw = weight]
bysort sector: tab employed if age >= 15 [aw = weight]
bysort sector: tab employed if inrange(age, 15, 29) [aw = weight]

* Unemployment Rate (UR) - Usual Status (ps+ss)
tab unemployed if lf == 1 [aw = weight]
bysort sector sex: tab unemployed if lf == 1 [aw = weight]
