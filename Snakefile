rule all:
    input:
        download_data = {
            'data/covid_data.xlsx', 'data/culture_data.csv',
            'data/polity5.xls', 'data/state_capacity.tab'
        },
        clean_data = 'data/covid_analysis.csv',
        figures_tables = {
            'figures_tables/capacity_cont.html', 'figures_tables/case_cap_rpe.png', 
            'figures_tables/case_cap_rpr.png', 'figures_tables/case_demo_pool.png', 
            'figures_tables/case_demo.png', 'figures_tables/case_gdp.png', 
            'figures_tables/case_ind_pool.png', 'figures_tables/case_ind.png', 
            'figures_tables/case_polity_pool.png', 'figures_tables/case_rpe_pool.png', 
            'figures_tables/case_rpr_pool.png', 'figures_tables/countries_by_continent.png', 
            'figures_tables/covid_cont.html', 'figures_tables/culture_cont.html',
            'figures_tables/death_age.png', 'figures_tables/demo_cont.html'
        },
        regression_results = {
            'regression_results/basic_reg.html',
            'regression_results/democracy_reg.html',
            'regression_results/individualism_reg.html',
            'regression_results/polity2_reg.html',
            'regression_results/rpe_reg.html',
            'regression_results/rpr_reg.html'
        },
        fig = 'dag.png'



rule download_data:
    input:
        script = 'download_data.R',
    output:
        download_data = {
            'data/covid_data.xlsx', 'data/culture_data.csv',
            'data/polity5.xls', 'data/state_capacity.tab'
        },
    shell:
        'Rscript {input.script} > {output.download_data}'



rule clean_data:
    input:
        script = 'clean_data.R',
        download_data = {
            'data/covid_data.xlsx', 'data/culture_data.csv',
            'data/polity5.xls', 'data/state_capacity.tab'
        },
    output:
        clean_data = 'data/covid_analysis.csv'
    shell:
        'Rscript {input.script} {input.download_data} > {output.clean_data}'



rule exploration:
    input:
        script = 'exploratory_data_analysis.R',
        clean_data = 'data/covid_analysis.csv'
    output:
        figures_tables = {
            'figures_tables/capacity_cont.html', 'figures_tables/case_cap_rpe.png', 
            'figures_tables/case_cap_rpr.png', 'figures_tables/case_demo_pool.png', 
            'figures_tables/case_demo.png', 'figures_tables/case_gdp.png', 
            'figures_tables/case_ind_pool.png', 'figures_tables/case_ind.png', 
            'figures_tables/case_polity_pool.png', 'figures_tables/case_rpe_pool.png', 
            'figures_tables/case_rpr_pool.png', 'figures_tables/countries_by_continent.png', 
            'figures_tables/covid_cont.html', 'figures_tables/culture_cont.html',
            'figures_tables/death_age.png', 'figures_tables/demo_cont.html'
        },
    shell:
        'Rscript {input.script} {input.clean_data} > {output.figures_tables}'



rule regression:
    input:
        script = 'regression_analysis.R',
        clean_data = 'data/covid_analysis.csv'
    output:
        regression_results = {
            'regression_results/basic_reg.html',
            'regression_results/democracy_reg.html',
            'regression_results/individualism_reg.html',
            'regression_results/polity2_reg.html',
            'regression_results/rpe_reg.html',
            'regression_results/rpr_reg.html'
        },
    shell:
        'Rscript {input.script} {input.clean_data} > {output.regression_results}'



rule dag:
    output:
        graph = 'dag.png'
    shell:
        "snakemake --dag | dot -Tpng > {output.graph}"