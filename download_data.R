rm(list=ls())

# Create a folder to store raw data ---------------------------------------

if (!dir.exists('data')){
  dir.create('data')
}

# Download covid data from our world in data (with country code) --------------------------------------------
download.file(url = 'https://github.com/owid/covid-19-data/raw/master/public/data/latest/owid-covid-latest.xlsx',
              destfile = 'data/covid_data.xlsx')

# Download culture data ---------------------------------------------------

download.file(url = 'http://geerthofstede.com/wp-content/uploads/2016/08/6-dimensions-for-website-2015-08-16.csv',
              destfile = 'data/culture_data.csv')


# Download democracy data ---------------------------------------------

# use polity 5 data
download.file(url = 'http://www.systemicpeace.org/inscr/p5v2018.xls',
              destfile = 'data/polity5.xls')


# Download state capacity data --------------------------------------------

download.file(url = 'https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/NRR7MB/6DC2YR',
              destfile = 'data/state_capacity.tab')




