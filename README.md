# Covid Study

## Description

This project studies the relationship between covid situation and culture (specifically individualism), institution (specifically democracy), and state capacity. 

Covid situation is measured by 4 variables: cases per million, deaths per million, positive rate and vaccinated per hundred. Data source: Our world in data. 

Individualism is measured by individualism index based on Hofstede's cultural dimenstions theory. The higher the index, the more individualism, the less collectivism the country shows. 

Democracy is measured by either variable democ or polity2 from the polity5 dataset. Democ is a democracy index from 0 to 10, the higher the index, the more democratic the country is. polity2 is an index for both democracy and autocracy from -10 to 10, the more negative, the more autocratic; the more positive, the more democratic. 

State capacity is measured by RPE and RPR from relative political capacity dataset. RPE means relative political extraction, which measures the ability of government to appropriate portions of the national output to advance public goals. RPR means relative political reach, which measures the capacity of government to mobilize populations under their control.

## Remarks on the code

You need to install Python and R to run the project. Additionally, the txt file packages_requirements.txt shows which R packages you need specifically.

To run the project, please run the code "snakemake --cores 1 all" in the terminal that is opened into your project's directory.

The project will run by the following order:

1. First it runs download_data.R script to download all the datasets that we will use from the internet.

2. Then it runs clean_data.R script to clean each dataset, e.g., keep useful variables only, deal with missings, correct wrong country names, calculate 5-year-average for certain variables, as well as merge all the datasets to one file. 

3. Then it runs exploratory_data_analysis.R script to do some basic summary statistics, and do some scatter plots to explore basic correlation between interested variables, either by continent, or pooled. 

4. Finally it runs regression_analysis.R script to run both OLS regressions and regression with continent fixed effects to study the relationship between covid situation and individualism, democracy and state capacity. Please note that these variables can be endogenous, so we are only studying correlation, not necessarily causal relationship here. 

## Main findings

1. Higher individualism is positively correlated with cases per million and deaths per million, but only significant for deaths per million. The coefficient on positive rate is close to 0. It's also negatively correlated with vaccinated per hundred.

2. Higher democracy is positively correlated with cases per million and deaths per million. No significant result is found on positive rate. It's also positively correlated with vaccinated per hundred, although not significant. The coefficient on the quadratic term of polity2 variable is positive, indicating that both autocracy and democracy is positively correlated with covid cases and deaths.

3. Relative political reach is positively correlated with cases per million, deaths per million and positive rate, significant for cases per million and positive rate. But it's also positively correlated with vaccinated per hundred, although not significant. Relative political extraction is positively correlated with cases per million, but not significant. It's significantly negatively correlated with deaths per million. No clear relationship with positive rate. And it's negatively correlated with vaccinated per hundred, although not significant. 

