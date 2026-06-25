// Master .do file, "International Law and Foreign Direct Reinvestment," International Organization (2019)
// Rachel L. Wellhausen, Associate Professor, University of Texas at Austin
// rwellhausen@utexas.edu; www.rwellhausen.com
// This is the .do file. 
// Please get in touch with any questions or problems.

clear all
set more off
cd "/Users/rw23826/Dropbox/Under Review/Law and FDI/Paper"
set matsize 1500

use WellhausenIO2019_replication.dta, clear

* Table 1: Reinvestment Summary
count if end==1 // Concluded arbitrations = 574
count if end==1 & reinvst==1 // Reinvestment among concluded arbitrations = 183
count if end==1 & reinvst_return==1 // Reinvestment if exited/returned = 14 
count if end==1 & reinvst_stay==1 // Reinvestment during and after arbitration = 108
count if end==1 & reinvst_2015==1 // Reinvestment as of end of 2015 = 159
count if end==0 // Incomplete arbitrations (as of 31 December 2015) = 155
count if end==0 & reinvst==1 // Reinvestment during incomplete arbitration = 39
count if reinvst==1 // Total reinvestment instances = 222


* Table 2: Reinvestment by Sector
tab sector reinvst


* Table 3: Reinvestment Summary (Hypotheses 1-5)
// Law Invoked (H1)
count if contract==1 & iia==0
count if contract==1 & iia==0 & reinvst==1
count if iia==1 & contract==0
count if iia==1 & contract==0 & reinvst==1
count if contract==1 & iia==1
count if contract==1  & iia==1 & reinvst==1
ttest reinvst, by(contract)

// Claim (H2)
count if exp_direct==1
count if exp_direct==1 & reinvst==1
count if exp_notdirect==1 
count if exp_notdirect==1 & reinvst==1
ttest reinvst, by(exp_notdirect)

// Outcome (H3a)
count if win_settle==1
count if win_settle==1 & reinvst==1
count if win_settle==0
count if win_settle==0 & reinvst==1
ttest reinvst, by(win_settle)

// Compensation (H3b)
count if win_is==1
count if win_is==1 & reinvst==1
count if win_is==0
count if win_is==0 & reinvst==1
ttest reinvst, by(win_is)

// Award Won (H4)
count if aratio_quart1==1
count if aratio_quart1==1 & reinvst==1
count if aratio_quart2==1
count if aratio_quart2==1 & reinvst==1
count if aratio_quart3==1
count if aratio_quart3==1 & reinvst==1
ttest reinvst, by(aratio_quart3)

// Enforcement (H5)
count if annul==1
count if annul==1 & reinvst==1
count if enforce_0==0
count if enforce_0==0 & reinvst==1
count if enforce_0==1 
count if enforce_0==1 & reinvst==1
ttest reinvst, by(enforce_0)


* Table 4: Reinvestment (Considering H1-5 separately)
eststo clear
_eststo: quietly logit reinvst contract trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst exp_notdirect trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst win_ruling_0 trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst win_is trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst aratio trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
esttab using "bivariate.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.3f) labels("Observations")) ///
indicate ("Sector=*.sector" "Region = *.region") ///
title("Reinvestment (Considering H1-5 separately)"\label{bivariate.tex})


* Table 5: Reinvestment (Considering H1-5 in combination)
eststo clear
_eststo: quietly logit reinvst contract exp_notdirect trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst win_ruling_0 aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst win_is aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst contract exp_notdirect win_ruling_0 aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst contract exp_notdirect win_is aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
esttab using "multivariate.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.4f) labels("Observations")) ///
indicate ("Sector=*.sector" "Region = *.region") ///
title("Reinvestment (Considering H1-5 in combination)"\label{multivariate.tex})


******************************************************************************************


** APPENDIX **

* Section 0.1: Reinvestment by region of host state
// Table 6
tab region reinvst

* Section 0.2: Regressions Accounting for ICSID
// Table 7
eststo clear
_eststo: quietly logit reinvst icsid contract trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst icsid exp_notdirect trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst icsid win_ruling_0 trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst icsid win_is trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst icsid aratio trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst icsid enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
esttab using "bivariate_icsid.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.3f) labels("Observations")) ///
indicate ("Sector=*.sector" "Region = *.region") ///
title("Reinvestment (Considering H1-5 separately, with ICSID)"\label{bivariate_icsid.tex})

// Table 8
eststo clear
_eststo: quietly logit reinvst icsid contract exp_notdirect trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst icsid win_ruling_0 aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst icsid win_is aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst icsid contract exp_notdirect win_ruling_0 aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
_eststo: quietly logit reinvst icsid contract exp_notdirect win_is aratio enforce_0 trend ib2.region ib3.sector if end==1, vce(cluster host)
esttab using "multivariate_icsid.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.3f) labels("Observations")) ///
indicate ("Sector=*.sector" "Region = *.region") ///
title("Reinvestment (Considering H1-5 in combination, with ICSID)"\label{multivariate_icsid.tex})


* Section 0.3 Sector Fixed Effects
// Table 9 
eststo clear
_eststo: quietly logit reinvst ib6.sector trend ib2.region if sector_str!=".", vce(cluster host)
_eststo: quietly logit reinvst ib6.sector contract exp_notdirect win_is aratio enforce_0 trend ib2.region if sector_str!=".", vce(cluster host)
esttab using "sector.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.3f) labels("Observations")) ///
indicate ("Region = *.region") ///
title("Reinvestment (Sector effects, relative to Oil/Gas)"\label{sector.tex})


* Section 0.4: Potential Host-state-level Correlates of Reinvestment
// Table 10
eststo clear
_eststo: quietly logit reinvst lngdppc contract exp_notdirect win_is aratio enforce_0 trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst lngdppc lngdp infdipgdp contract exp_notdirect win_is aratio enforce_0 trend ib2.region ib3.sector, vce(cluster host)
_eststo: quietly logit reinvst lngdppc lngdp infdipgdp va_wgi corruptcontrol_wgi contract exp_notdirect win_is aratio enforce_0 trend ib2.region ib3.sector, vce(cluster host)
esttab using "multivariate_hostcontrols.tex", replace booktabs se ///
star(* 0.1 ** 0.05 *** 0.01) ///
stats(N, fmt(%9.0gc %9.3f) labels("Observations")) ///
indicate ("Sector=*.sector" "Region = *.region") ///
title("Reinvestment (Testing H1-5 in combination, with Host-country-level controls)"\label{multivariate_hostcontrols.tex})


