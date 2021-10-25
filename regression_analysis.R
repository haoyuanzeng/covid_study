rm(list=ls())

# read data ---------------------------------------------------------------
library(readr)
data <-  read_delim('data/covid_analysis.csv', col_names = TRUE)


# covid and country basic characteristics ---------------------------------
# OLS
ols1 <- lm(total_cases_per_million ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))


# covid and individualism -------------------------------------------------
# OLS
ols1 <- lm(total_cases_per_million ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ idv + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))


# covid and democracy -----------------------------------------------------
# democracy: using democracy index
# OLS
ols1 <- lm(total_cases_per_million ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ democ + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))

# autocracy and democracy: using polity2 index, add square term (by scatter plot)
# OLS
ols1 <- lm(total_cases_per_million ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ polity2 + I(polity2^2) + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))


# covid and state capacity ------------------------------------------------
# relative political reach
# OLS
ols1 <- lm(total_cases_per_million ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ rpr + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))

# relative political extraction
# OLS
ols1 <- lm(total_cases_per_million ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols2 <- lm(total_deaths_per_million ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols3 <- lm(positive_rate ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
ols4 <- lm(people_fully_vaccinated_per_hundred ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index, data = data)
library(stargazer)
stargazer(ols1, ols2, ols3, ols4, type = 'text')
# continent FE
library(fixest)
fe1 <- feols(total_cases_per_million ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe2 <- feols(total_deaths_per_million ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe3 <- feols(positive_rate ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
fe4 <- feols(people_fully_vaccinated_per_hundred ~ rpe + population + population_density + median_age + aged_65_older + gdp_per_capita + human_development_index | continent, data = data)
library(modelsummary)
models <- list('cases per million' = fe1, 'deaths per million' = fe2, 'positive rate' = fe3, 'vaccinated per hundred' = fe4)
modelsummary(models, gof_omit = "AIC|BIC|DF|Deviance|IC|Log|Adj|Pseudo|Within|se_type", stars = c('*'  = 0.1, '**' = 0.05, '***' = 0.01))


