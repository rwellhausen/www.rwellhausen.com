#### Replication code for all figures in "Judicial Economy and Moving Bars in ####
            #### International Investment Arbitration" ####
#####---------------------------------------------------------------####
# Leslie Johns, Calvin Thrall, & Rachel Wellhausen
#######----------------------------------------------------------#######
# For questions about code, contact Calvin (cthrall@utexas.edu)
########################################################################


## Load tidyverse packages (contains ggplot2, dplyr, tidyr, etc)
# If you don't have the tidyverse installed on your machine, remove the # from line 12 and run code
# install.packages("tidyverse")
library(tidyverse)

## Load data for figures 1-6, 1a, 2a, 4a, and 5a
isdscaseruled <- read_csv("cleanISDSdata.csv")

## Load data for figure 3a
isdsdatacoded <- read_csv("data_for_Fig_3a.csv")

#################################
##
## Figures for the paper
##
#################################


## Figure 3: % of claims ruled on over time
percentruledgraph <- isdscaseruled %>% group_by(yearstart) %>%
  summarise(`Claims Alleged` = sum(total_core_JoWe, na.rm = T),
            `Claims Ruled On` = sum(claimsruled_core, na.rm = T),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:22) %>%
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw()


## Figure 4: % of claims ruled on, conditional on investor victory
isdsinvestorwin <- filter(isdscaseruled, claim1_upheld == 1 |
                            claim2_upheld == 1 |
                            claim3_upheld == 1 |
                            claim4_upheld == 1 |
                            claim5_upheld == 1 |
                            claim6_upheld == 1 |
                            claim7_upheld == 1 |
                            claim8_upheld == 1)


percentruledgraph2 <- isdsinvestorwin %>% group_by(yearstart) %>%
  filter(ruled_on_merits == 1) %>% 
  summarise(`Claims Alleged` = sum(total_core_JoWe, na.rm = T) - sum(nonruled_jurisdiction_claims),
            `Claims Ruled On` = sum(claimsruled_core, na.rm = T) - sum(nonruled_jurisdiction_claims),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:21) %>% 
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw() 

## Figure 5: FET/indir. exp trends graph, jurisdiction losses excluded
isdscaseruled <- isdscaseruled %>% mutate(FET_Indirexp_Claimed = if_else(
  IndirExp_jurisdiction == 1 & FET_jurisdiction == 1, 1, 0
))

FET_indirexp_trendsgraph <- isdscaseruled %>%
  filter(ruled_on_merits == 1) %>% 
  group_by(yearstart) %>% 
  summarise(FET = sum(FET_jurisdiction), IndirExp = sum(IndirExp_jurisdiction),
            n = n(), `% with FET Claim` = (FET/n)*100, `% with Ind. Expropriation Claim` = (IndirExp/n)*100,
            `% with FET & Ind. Expr. claims` = (sum(FET_Indirexp_Claimed)/n)*100,
            judecongap = `% with Ind. Expropriation Claim` - `% with FET & Ind. Expr. claims`) %>%
  slice(1:21) %>%
  gather(key = `Claim Type`, value = ClaimsPercent, `% with FET Claim`, `% with Ind. Expropriation Claim`,
         `% with FET & Ind. Expr. claims`) %>% 
  ggplot(aes(as.factor(yearstart), ClaimsPercent, group = `Claim Type`,
             linetype = `Claim Type`)) +
  geom_smooth(se = F, color = "Black", alpha = .8) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
  labs(x = "Year", y = "Percentage of Cases", linetype = "") +
  theme_bw() +
  theme(legend.position = "bottom")

## Figure 6: FET/indir. exp ruling graph, jurisdiction losses excluded
isdscaseruled <- isdscaseruled %>% mutate(FET_and_IndirExp = case_when(
  FET_ruledon == 1 & IndirExp_ruledon == 1 ~ 1,
  TRUE ~ 0
))

FET_indirexp_rulinggraph <- isdscaseruled %>%
  filter(ruled_on_merits == 1) %>% 
  group_by(yearstart) %>%
  summarise(n = n(),
            `FET claim ruled on` = (sum(FET_ruledon)/n)*100,
            `Ind. Expropriation claim ruled on` = (sum(IndirExp_ruledon)/n)*100,
            `FET & Ind. Expr. claims ruled on` = (sum(FET_and_IndirExp)/n)*100) %>% 
  slice(1:21) %>% 
  gather(key = `Claim Type`, value = Claimspercent, `FET claim ruled on`,
         `Ind. Expropriation claim ruled on`,
         `FET & Ind. Expr. claims ruled on`) %>% 
  ggplot(aes(as.factor(yearstart), Claimspercent, group = `Claim Type`, linetype = `Claim Type`)) + 
  geom_smooth(se = F, color = "Black", alpha = .8) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted")) +
  labs(x = "Year", y = "Percentage of Cases") +
  theme_bw() +
  theme(legend.position = "bottom")

#############################
##
## Appendix Figures
##
#############################

## Figure 1a: figure 1 w/ all claims counted
percentruledgraph_allclaims <- isdscaseruled %>% group_by(yearstart) %>%
  summarise(`Claims Alleged` = sum(totalclaims, na.rm = T),
            `Claims Ruled On` = sum(claimsruled_total, na.rm = T),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:22) %>% 
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw()

## Figure 2a: figure 2 w/ all claims counted
percentruledgraph_allclaims2 <- isdsinvestorwin %>% group_by(yearstart) %>%
  filter(ruled_on_merits == 1) %>% 
  summarise(`Claims Alleged` = sum(totalclaims, na.rm = T),
            `Claims Ruled On` = sum(claimsruled_total, na.rm = T),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:21) %>% 
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw() 

## Figure 3a: our codings vs UNCTAD
claimtotals <- tibble(
  claimtype = c("indirect_exp", "direct_exp", "FET", "full_protection", 
                "MST", "MFN", "natl_treatment","indirect_exp", "direct_exp",
                "FET", "full_protection", "MST", "MFN", "natl_treatment"),
  Value = c(sum(isdsdatacoded$UNCTAD_indir_exp, na.rm = T),
            sum(isdsdatacoded$UNCTAD_dir_exp, na.rm = T),
            sum(isdsdatacoded$UNCTAD_FET, na.rm = T),
            sum(isdsdatacoded$UNCTAD_fullprotect, na.rm = T),
            sum(isdsdatacoded$UNCTAD_MST, na.rm = T),
            sum(isdsdatacoded$UNCTAD_MFN, na.rm = T),
            sum(isdsdatacoded$UNCTAD_natltreatment, na.rm = T),
            sum(isdsdatacoded$JoWe_indir_exp, na.rm = T),
            sum(isdsdatacoded$JoWe_dir_exp, na.rm = T),
            sum(isdsdatacoded$JoWe_FET, na.rm = T),
            sum(isdsdatacoded$JoWe_fullprotect, na.rm = T),
            sum(isdsdatacoded$JoWe_MST, na.rm = T),
            sum(isdsdatacoded$JoWe_MFN, na.rm = T),
            sum(isdsdatacoded$JoWe_natltreatment, na.rm = T)),
  Coding_Method = c(rep("UNCTAD", 7), rep("Our Coding", 7))
)

claimsgraph <- ggplot(claimtotals, aes(claimtype, Value, fill = Coding_Method)) +
  geom_bar(position = "dodge", stat = "identity") +
  labs(x = "Claim Type", y = "Count", fill = "Coding Method") +
  scale_fill_manual(values = c("gray1", "gray34"))

## Figure 4a: figure 1 w/ core claims + MST
percentruledgraph_mst <- isdscaseruled %>% group_by(yearstart) %>%
  summarise(`Claims Alleged` = sum(total_core_JoWe, na.rm = T) + sum(JoWe_MST, na.rm = T),
            `Claims Ruled On` = sum(claimsruled_core, na.rm = T) + sum(MST_ruledon, na.rm = T),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:22) %>% 
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw()

## Figure 5a: figure 2 w/ core claims + MST
percentruledgraph_mst2 <- isdscaseruled %>% 
  filter(ruled_on_merits == 1) %>% 
  group_by(yearstart) %>%
  summarise(`Claims Alleged` = sum(total_core_JoWe, na.rm = T) + sum(JoWe_MST, na.rm = T) - sum(nonruled_jurisdiction_claimsMST),
            `Claims Ruled On` = sum(claimsruled_core, na.rm = T) + sum(MST_ruledon, na.rm = T) - sum(nonruled_jurisdiction_claimsMST),
            `Percent Ruled On` = (`Claims Ruled On`/`Claims Alleged`)*100,
            Cases = n(), `Avg. Claims Alleged/Case` = `Claims Alleged`/Cases,
            `Avg. Claims Ruled/Case` = `Claims Ruled On`/Cases) %>% 
  slice(1:21) %>% 
  ggplot(aes(x = as.factor(yearstart), y = `Percent Ruled On`, size = `Avg. Claims Alleged/Case`)) +
  geom_point() +
  labs(x = "Year", y = "Claims Ruled on (%)", size = "Avg. # of Claims Alleged per Case") + 
  theme_bw()

## Figure 6a: core claim trends over time

coretrends <- isdscaseruled %>% 
  group_by(yearstart) %>% 
  summarize(n = n(), FET = (sum(JoWe_FET)/n)*100, indirexp = (sum(JoWe_indir_exp)/n)*100, direxp = (sum(JoWe_dir_exp)/n)*100,
            FPS = (sum(JoWe_fullprotect)/n)*100, MFN = (sum(JoWe_MFN)/n)*100, NatTreat = (sum(JoWe_natltreatment)/n)*100) %>%
  slice(1:22) %>% 
  gather(key = claimtype, value = claimpercent, FET, indirexp, direxp, FPS, MFN, NatTreat) %>%
  ggplot(aes(x = as.factor(yearstart), y = claimpercent, group = claimtype, linetype = claimtype)) +
  geom_smooth(se = F, color = "Black") +
  labs(x = "Year", y = "Percentage of Cases", linetype = "Claim Type")+
  theme_bw() +
  theme(legend.position = "bottom")

## Basic t-tests for trends


rulingspre2004 <- isdscaseruled %>%
  filter(ruled_on_merits == 1, yearstart < 2004) %>% 
  select(yearstart, FET_ruledon, IndirExp_ruledon, FET_and_IndirExp)

t.test(rulingspre2004$IndirExp_ruledon, rulingspre2004$FET_ruledon,
       alternative = "greater")

t.test(rulingspre2004$FET_ruledon, rulingspre2004$FET_and_IndirExp,
       alternative = "greater")

rulingspost2004 <- isdscaseruled %>%
  filter(ruled_on_merits == 1, yearstart >= 2004) %>% 
  select(yearstart, FET_ruledon, IndirExp_ruledon, FET_and_IndirExp)

t.test(rulingspost2004$FET_ruledon, rulingspost2004$IndirExp_ruledon,
       alternative = "greater")

t.test(rulingspost2004$IndirExp_ruledon, rulingspost2004$FET_and_IndirExp,
       alternative = "greater")

trendspre2004 <- isdscaseruled %>%
  filter(ruled_on_merits == 1, yearstart < 2004) %>% 
  select(yearstart, FET_jurisdiction, IndirExp_jurisdiction, FET_Indirexp_Claimed)

t.test(trendspre2004$IndirExp_jurisdiction, trendspre2004$FET_jurisdiction, 
       alternative = "greater")



trendspost2004 <- isdscaseruled %>%
  filter(ruled_on_merits == 1, yearstart >= 2004) %>% 
  select(yearstart, FET_jurisdiction, IndirExp_jurisdiction, FET_Indirexp_Claimed)

t.test(trendspost2004$FET_jurisdiction, trendspost2004$IndirExp_jurisdiction,
       alternative = "greater")






