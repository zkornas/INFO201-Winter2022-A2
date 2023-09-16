# A2: U.S. COVID Trends

## Overview
In many ways, we have come to understand the gravity and trends in the COVID-19 pandemic through quantitative means. Regardless of media source, people are consuming more epidemiological information than ever, primarily through reported figures, charts, and maps.

This assignment is your opportunity to work directly with the same data used by the New York Times. While the analysis is guided through a series of questions, it is your opportunity to use programming skills to ask more detailed questions about the pandemic.

You'll load the data directly from the [New York Times GitHub page](https://github.com/nytimes/covid-19-data/), and you should make sure to read through their documentation to understand the meaning of the datasets.

Note, this is a long assignment, meant to be completed over the two weeks when we'll be learning data wrangling skills. I strongly suggest that you **start early**, and approach it with patience. We're asking real questions of real data, and there is inherent trickiness involved.

## Getting Started
You should start this assignment by opening up the `analysis.R` script. The script will guide you through an initial analysis of the data.

* **Coding prompts.** Complete the coding prompts in `analysis.R`.  Your goal is correct code that is understanable.
* **Reflection prompts.** Throughout the script, there are prompts labeled `REFLECTION`. Please write 1 - 3 sentences for each of these prompts below.
As appropriate, provide evidence (e.g., facts from the datasets), give justification for your opinions, or genuinely reflect on your views.  Please strive for concise, clear, and interesting wrirting.

## Reflection Prompts

**R1:** Loading Data
* **R1.a (a)** The county data differs from the state and national data because there are far more observations at the national level. Covid-19 cases and deaths were recorded each day for each county across the US, meaning this dataset is much bigger than the other two. I see that the national-level data is also recording rolling average of cases and deaths, and this data is not recorded at the county-level.
* **R1.a (b)** The county, state, and national-level data is similar as they all record Covid-19 cases and deaths of each day. They all seem to have started collecting these observations on the same day, January 21st 2020.
* **R1.a (c)** FIPS (Federal Information Processing Series) is a series of codes that is used to identify specific counties across the United States. The first two figures represent the state, and the last three figures represent the county within that state. This is very helpful for data collection and processing as it allows us to differentiate between counties that may have the same name across multiple states.

**R2**: Exploratory Analysis
* **R2.a (a)** When I calculated the state with the lowest cases of Covid-19, I learned that this dataset is also tracking Covid-19 data in territories, like American Samoa.
* **R2.a (b)** This tested my assumptions about a dataset because I was apparently unaware of everything that was being tracked. This is important to know because if I were to make broad assumptions based on generic calculations from this dataset, then my results may be skewed due to factors that I was unaware of.
* **R2.b** No, the location with most deaths is in New York and the location with the most cases is in California. I think that this could be due to vaccination rates, which isn't tracked in this dataset. If a place has a really high vaccination rate they could have a high case count with very low deaths and most of the infected population be asymptomatic. A location with a lower vaccination rate could have fewer cases, but a larger proportion of those cases may result in death.
* **R2.c** When viewing the plots, changing the window_size changed the view of the plot, which conveyed a different message to the viewer. If the window_size was set to 1, then it looked like Covid had a very dramatic increase in January 2022, and was relatively under control before then. When we change the window_size to 200 however, it looks like we still have a spike in January 2022, but there now appears to be a dramatic increase from January 2021 to July 2021.

**R3**: Grouped Analysis
* **R3.a** As mentioned earlier, this dataset also tracks Covid-19 rates in U.S. territories like American Samoa, Guam, and Puerto Rico. This makes lowest_in_each_state have more observations than there are U.S. States.

**R4:**: Joins
* **R4.a (a)** While the state and national data seem to line up (0 inconsistencies), there are about 29 inconsistencies between the state and county data. I believe that this is because the county data is so much bigger than both the state and national data, that there is more room for errors.
* **R4.a (b)** I think my next step would be to calculate which dates these inconsistencies occur using a chunk of code and place those dates in a data frame with the observed counts at the state and county level. I would then cross reference this data with two different data sets also recording Covid-19 case/death counts to obtain the correct data.

**R6**: Your Learning
* **R6.a** I really enjoyed working with and exploring this dataset. I think the thing that made me most curious/interested in this dataset was that it was regularly updated, so I could pull the data each day and my answers may change. I enjoyed working with real-time data. I also thought the topic was interesting as it is something we have been dealing with for the past two years that has affected all of our lives personally, making the topic more interesting and relevant than an obscure dataset that has no relation to us.
