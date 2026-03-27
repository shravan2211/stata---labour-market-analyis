/*******************************************************************************
* Project      : Labour Market Analysis – PLFS 2017-18
* Author       : Shravan MK
* Affiliation  : Centre for Sustainable Employment (CSE), Azim Premji University
* Date         : 2024
* Description  : This do file constructs employment type indicators, harmonises
*                state names, merges CPI data, and computes nominal and real
*                daily wages by employment category (salaried, self-employed,
*                casual) using PLFS 2017-18 data.
* Dataset      : PLFS 2017-18 (allblocks_merged) + CPI (base year 2011)
* Output       : Real daily wages by employment type and income quintiles
*******************************************************************************/

clear all
set more off


/*******************************************************************************
* SECTION 1: FILE PATHS
*******************************************************************************/

global data   "C:\Users\user\cse Dropbox\Shravan  MK\plfs cleaned (1)"
global cpi    "C:\Users\user\cse Dropbox\cseteam\projects\swi2023\plfsmobility\projectdata"


/*******************************************************************************
* SECTION 2: LOAD DATA
*******************************************************************************/

use "$data\2017_allblocks_merged.dta", clear


/*******************************************************************************
* SECTION 3: YEAR CREATION
* Assigns survey year based on month of survey
* (July-December = 2017, January-June = 2018)
*******************************************************************************/

gen year = cond(inrange(month_survey_p, "07", "12"), 2017, 2018)
tostring year, replace


/*******************************************************************************
* SECTION 4: EMPLOYMENT TYPE INDICATORS
* Based on Current Weekly Activity Status (cwas)
*   Salaried     : 31, 71, 72
*   Casual       : 41-51
*   Self-employed: 11, 12, 61, 62
*   Any employed : 11-72
*******************************************************************************/

gen sal     = inlist(cwas, 31, 71, 72)
gen casual  = inrange(cwas, 41, 51)
gen selfemp = inlist(cwas, 11, 12, 61, 62)
gen emp     = inrange(cwas, 11, 72)


/*******************************************************************************
* SECTION 5: STATE NAME HARMONISATION
* Decodes state codes and standardises names across PLFS rounds
*******************************************************************************/

decode scode_full, gen(state)
replace state = lower(state)

local old "a & n islands lakshdweep orissa pondicherry uttaranchal"
local new "andaman & nicobar lakshadweep odisha puducherry uttarakhand"

local i = 1
foreach o of local old {
    local n : word `i' of `new'
    replace state = "`n'" if state == "`o'"
    local ++i
}


/*******************************************************************************
* SECTION 6: REGION TYPE
*******************************************************************************/

gen regiontype = cond(sector == 1, "rural", "urban")


/*******************************************************************************
* SECTION 7: MONTH NAME CREATION
* Converts numeric month codes to abbreviated month names for CPI merge
*******************************************************************************/

gen monthname = ""

local months "01 02 03 04 05 06 07 08 09 10 11 12"
local names  "jan feb mar apr may jun jul aug sep oct nov dec"

local i = 1
foreach m of local months {
    local nm : word `i' of `names'
    replace monthname = "`nm'" if month_survey_p == "`m'"
    local ++i
}


/*******************************************************************************
* SECTION 8: MERGE CPI DATA
* Merges monthly state-level CPI (base year 2011) for deflating wages
*******************************************************************************/

merge m:1 monthname year state using "$cpi\cpiwithbase2011.dta", nogen


/*******************************************************************************
* SECTION 9: WAGE CONSTRUCTION
* Constructs daily wages for each employment type:
*   - Salaried  : monthly earnings / 30
*   - Self-emp  : monthly earnings / 30
*   - Casual    : total weekly wage / days worked
*******************************************************************************/

* Total weekly wage (sum across 7 days, activity 1)
egen wage = rowtotal(cds_act1_wage_?_p), missing

* Number of days worked in reference week
gen days_worked = 0
forvalues d = 1/7 {
    replace days_worked = days_worked + ///
        (cds_act1_wage_`d'_p > 0 & !missing(cds_act1_wage_`d'_p))
}

* Daily earnings by employment type
gen dailyreg    = cws_monthly_earnings_regsalaried / 30
gen dailyself   = cws_monthly_earnings_selfemp / 30
gen dailycasual = wage / days_worked

* Combined daily earnings
egen daily = rowtotal(dailyreg dailyself dailycasual), missing
drop if daily <= 0


/*******************************************************************************
* SECTION 10: SUMMARY STATISTICS
* Daily earnings among employed individuals aged 15+
*******************************************************************************/

summ daily if age >= 15 & emp == 1 [aw = weight], detail


/*******************************************************************************
* SECTION 11: REAL WAGE CONSTRUCTION
* Deflates nominal daily wages using rural (CPIR) and urban (CPIU) CPI
*******************************************************************************/

foreach var in salaried selfemp casual {

    gen real`var' = .

    if "`var'" == "salaried" {
        replace real`var' = dailyreg    / CPIR if sector == 1 & sal    == 1
        replace real`var' = dailyreg    / CPIU if sector == 2 & sal    == 1
    }

    if "`var'" == "selfemp" {
        replace real`var' = dailyself   / CPIR if sector == 1 & selfemp == 1
        replace real`var' = dailyself   / CPIU if sector == 2 & selfemp == 1
    }

    if "`var'" == "casual" {
        replace real`var' = dailycasual / CPIR if sector == 1 & casual  == 1
        replace real`var' = dailycasual / CPIU if sector == 2 & casual  == 1
    }
}

* Combined real daily earnings
egen realdaily = rowtotal(realsalaried realselfemp realcasual), missing
drop if realdaily <= 0


/*******************************************************************************
* SECTION 12: INCOME QUINTILES
* Divides sample into 5 equal groups based on real daily earnings
*******************************************************************************/

xtile pctotinc_q = realdaily [aw = weight], nq(5)

tabstat realdaily [aw = weight], by(pctotinc_q)


/*******************************************************************************
* END OF DO FILE
*******************************************************************************/
