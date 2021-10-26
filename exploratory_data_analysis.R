rm(list=ls())
library(readr)
library(ggplot2)
library(dplyr)
library(vtable)

# read data ---------------------------------------------------------------
data <-  read_delim('data/covid_analysis.csv', col_names = TRUE)

# single variable summary ----------------------------------------------------------
# create a folder to store the tables and figures
if(!file.exists("figures_tables")){
  dir.create("figures_tables")
}

# bar graph of number of countries by continent

g1 <- ggplot(data) +
  geom_bar(aes(x = continent)) +
  labs(y = 'number of countries',
       title = 'Number of countries by continent') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/countries_by_continent.png',plot = g1, width = 8, height = 6, dpi = 300)

# covid information by continent

sub1 <- subset(data, select = c("continent","total_cases_per_million","positive_rate","people_fully_vaccinated_per_hundred"))
st(sub1, group='continent', group.long = TRUE, title = 'Covid by continent', out = FALSE, file='figures_tables/covid_cont.html')

# individualsm vs. collectivism by continent
sub2 <- subset(data, select = c("continent", "idv"))
st(sub2, group='continent', group.long = TRUE, title = 'Culture by continent', out = FALSE, file='figures_tables/culture_cont.html')

# democracy by continent
sub3 <- subset(data, select = c("continent", "democ", "polity2"))
st(sub3, group='continent', group.long = TRUE, title = 'Democracy by continent', out = FALSE, file='figures_tables/demo_cont.html')

# state capacity by continent
sub4 <- subset(data, select = c("continent", "ape", "rpe", "rpr"))
st(sub4, group='continent', group.long = TRUE, title = 'State capacity by continent', out = FALSE, file='figures_tables/capacity_cont.html')


# correlation plots----------------------------------------
# covid cases and gdp per capita
g2 <- ggplot(data) + 
  geom_point(aes(x = gdp_per_capita, y = total_cases_per_million, color = continent)) +
  labs(y = 'total cases per million',
       x = 'GDP per capita',
       title = 'Relationship between covid cases and GDP per capita') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_gdp.png',plot = g2, width = 8, height = 6, dpi = 300)


# death and proportion of older than 65
g3 <- ggplot(data) + 
  geom_point(aes(x = aged_65_older, y = total_deaths_per_million, color = continent)) +
  labs(y = 'total deaths per million',
       x = 'Proportion of population older than 65',
       title = 'Relationship between covid deaths and age') +
  theme(plot.title = element_text(hjust = 0.5)) 
ggsave('figures_tables/death_age.png',plot = g3, width = 8, height = 6, dpi = 300)


# correlation-culture, institution by continent ---------------------------
# covid cases and individualism
g4 <- ggplot(data, aes(x = idv, y = total_cases_per_million)) + 
  geom_point() +
  labs(y = 'total cases per million',
       x = 'individualism index',
       title = 'Relationship between covid cases and individualism') +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~continent, nrow = 2)
ggsave('figures_tables/case_ind.png',plot = g4, width = 8, height = 6, dpi = 300)


# covid cases and democracy
g5 <- ggplot(data, aes(x = democ, y = total_cases_per_million)) +   # using polity2 gives similar result
  geom_point() +
  labs(y = 'total cases per million',
       x = 'democarcy index',
       title = 'Relationship between covid cases and democracy') +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~continent, nrow = 2)
ggsave('figures_tables/case_demo.png',plot = g5, width = 8, height = 6, dpi = 300)

# covid cases and state capacity: relative political reach
g6 <- ggplot(data, aes(x = rpr, y = total_cases_per_million)) +   # using polity2 gives similar result
  geom_point() +
  labs(y = 'total cases per million',
       x = 'state capacity index RPR',
       title = 'Relationship between covid cases and state capacity-relative political reach') +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~continent, nrow = 2)
ggsave('figures_tables/case_cap_rpr.png',plot = g6, width = 8, height = 6, dpi = 300)

# covid cases and state capacity: relative political extraction
g7 <- ggplot(data, aes(x = rpe, y = total_cases_per_million)) +   # using polity2 gives similar result
  geom_point() +
  labs(y = 'total cases per million',
       x = 'state capacity index RPE',
       title = 'Relationship between covid cases and state capacity-relative political extraction') +
  theme(plot.title = element_text(hjust = 0.5)) +
  facet_wrap(~continent, nrow = 2)
ggsave('figures_tables/case_cap_rpe.png',plot = g7, width = 8, height = 6, dpi = 300)


# correlation-culture, institution pooled ---------------------------------
# covid cases and individualism
g8 <- ggplot(data, aes(x = idv, y = total_cases_per_million)) + 
  geom_point() +
  geom_smooth() + 
  labs(y = 'total cases per million',
       x = 'individualism index',
       title = 'Relationship between covid cases and individualism') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_ind_pool.png',plot = g8, width = 8, height = 6, dpi = 300)

# covid cases and democracy
g9 <- ggplot(data, aes(x = democ, y = total_cases_per_million)) + 
  geom_point() +
  geom_smooth() + 
  labs(y = 'total cases per million',
       x = 'democracy index',
       title = 'Relationship between covid cases and democracy') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_demo_pool.png',plot = g9, width = 8, height = 6, dpi = 300)

g10 <- ggplot(data, aes(x = polity2, y = total_cases_per_million)) + 
  geom_point() +
  geom_smooth() + 
  labs(y = 'total cases per million',
       x = 'autocracy-democracy index',
       title = 'Relationship between covid cases and polity score') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_polity_pool.png',plot = g10, width = 8, height = 6, dpi = 300)

# covid cases and state capacity-RPR
g11 <- ggplot(data, aes(x = rpr, y = total_cases_per_million)) + 
  geom_point() +
  geom_smooth() + 
  labs(y = 'total cases per million',
       x = 'state capacity index RPR',
       title = 'Relationship between covid cases and state capacity-relative political reach') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_rpr_pool.png',plot = g11, width = 8, height = 6, dpi = 300)

# covid cases and state capacity-RPE
g12 <- ggplot(data, aes(x = rpe, y = total_cases_per_million)) + 
  geom_point() +
  geom_smooth() + 
  labs(y = 'total cases per million',
       x = 'state capacity index RPE',
       title = 'Relationship between covid cases and state capacity-relative political extraction') +
  theme(plot.title = element_text(hjust = 0.5))
ggsave('figures_tables/case_rpe_pool.png',plot = g12, width = 8, height = 6, dpi = 300)




