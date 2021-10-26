rm(list=ls())
library(readr)
library(stargazer)
library(fixest)
library(modelsummary)

# create a folder to store the regression results
if(!file.exists("regression_results")){
  dir.create("regression_results")
}

# read data ---------------------------------------------------------------
data <-  read_delim('data/covid_analysis.csv', col_names = TRUE)

# covid and country basic characteristics ---------------------------------
# OLS
ols1 <- lm(total_cases_per_million ~ population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ population_density + median_age + aged_65_older 
           + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ 
             population_density + median_age + aged_65_older + gdp_per_capita , data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_basic_reg.html', 
          title = 'Relationship between covid and basic control variables')
# continent FE

fe1 <- feols(total_cases_per_million ~ population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe2 <- feols(total_deaths_per_million ~  population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)
fe3 <- feols(positive_rate ~  population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~  population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)

models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)

omit_stat <- "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type"

modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_basic_reg.html', 
             title = 'Relationship between covid and basic control variables with continent FE')


# covid and individualism -------------------------------------------------
# OLS
ols1 <- lm(total_cases_per_million ~ idv + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ idv + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ idv +  population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ idv + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_individualism_reg.html', 
          title = 'Relationship between covid and individualism')
# continent FE

fe1 <- feols(total_cases_per_million ~ idv + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ idv + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe3 <- feols(positive_rate ~ idv + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ idv + population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)

models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_individualism_reg.html', 
             title = 'Relationship between covid and individualism with continent FE')


# covid and democracy -----------------------------------------------------
# democracy: using democracy index
# OLS
ols1 <- lm(total_cases_per_million ~ democ + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ democ + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ democ + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ democ + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_democracy_reg.html', 
          title = 'Relationship between covid and democracy')

# continent FE

fe1 <- feols(total_cases_per_million ~ democ + population_density + median_age 
             + aged_65_older + gdp_per_capita  | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ democ + population_density + median_age 
             + aged_65_older + gdp_per_capita  | continent, data = data)
fe3 <- feols(positive_rate ~ democ + population_density + median_age 
             + aged_65_older + gdp_per_capita  | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ democ + population_density 
             + median_age + aged_65_older + gdp_per_capita  | continent, data = data)

models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)

modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_democracy_reg.html', 
             title = 'Relationship between covid and democracy with continent FE')

# autocracy and democracy: using polity2 index, add square term (by scatter plot)
# OLS
ols1 <- lm(total_cases_per_million ~ polity2 + I(polity2^2) + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ polity2 + I(polity2^2) + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ polity2 + I(polity2^2) + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ polity2 + I(polity2^2) 
           + population_density + median_age + aged_65_older + gdp_per_capita, data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_polity2_reg.html', 
          title = 'Relationship between covid and autocracy or democracy')
# continent FE

fe1 <- feols(total_cases_per_million ~ polity2+ I(polity2^2) + population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ polity2 + I(polity2^2) + population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)
fe3 <- feols(positive_rate ~ polity2 + I(polity2^2) + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ polity2 + I(polity2^2)
             + population_density + median_age + aged_65_older 
             + gdp_per_capita | continent, data = data)


models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)

modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_polity2_reg.html', 
             title = 'Relationship between covid and autocracy or democracy with continent FE')

# covid and state capacity ------------------------------------------------
# relative political reach
# OLS
ols1 <- lm(total_cases_per_million ~ rpr + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ rpr + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ rpr + population_density + median_age + aged_65_older 
           + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ rpr + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_rpr_reg.html', 
          title = 'Relationship between covid and relative political reach')
# continent FE

fe1 <- feols(total_cases_per_million ~ rpr + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ rpr + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe3 <- feols(positive_rate ~ rpr + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ rpr + population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)

models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)

modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_rpr_reg.html', 
             title = 'Relationship between covid and relative political reach with continent FE')

# relative political extraction
# OLS
ols1 <- lm(total_cases_per_million ~ rpe + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols2 <- lm(total_deaths_per_million ~ rpe + population_density + median_age 
           + aged_65_older + gdp_per_capita, data = data)
ols3 <- lm(positive_rate ~ rpe + population_density + median_age + aged_65_older 
           + gdp_per_capita, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ rpe + population_density 
           + median_age + aged_65_older + gdp_per_capita, data = data)

stargazer(ols1, ols2, ols3, ols4, type = 'text', 
          out = 'regression_results/ols_rpe_reg.html', 
          title = 'Relationship between covid and relative political extraction')
# continent FE

fe1 <- feols(total_cases_per_million ~ rpe + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ rpe + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe3 <- feols(positive_rate ~ rpe + population_density + median_age 
             + aged_65_older + gdp_per_capita | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ rpe + population_density 
             + median_age + aged_65_older + gdp_per_capita | continent, data = data)

models <- list('cases per million' = fe1, 'deaths per million' = fe2, 
               'positive rate' = fe3, 'vaccinated per hundred' = fe4)

modelsummary(models, gof_omit = omit_stat, 
             stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01),
             output = 'regression_results/fe_rpe_reg.html', 
             title = 'Relationship between covid and relative political extraction with continent FE')
