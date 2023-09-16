# Assignment Overview ----------------------------------------------------------------
# Assignment 2: U.S. COVID Trends  (INFO-201, Winter 2022)
# 
# (Acknowledgement: Thanks to Mike Freeman and Kyle Thayer for developing 
# this assignment. Also, thanks to Abdiwahid Hajir, who provided assistance
# in this revision. Any errors with this version are, of course, my fault. 
# David Hendry.)
#

## 1.0 Background ----

#       |       xxx
#       |      x 
#       |     x
#  f(t) |       
#       |    x
#       |xxxx      
#       -----------------
#        123456789 ... N 
#             Time ---> 
#
# This figure shows a rough sketch of a "cumulative sum" time series. 
#
# A time series means data collected sequentially, usually at regular
# time intervals; for example, every 15 minutes, every 24 hours, or 
# some other appropriate unit of time. A "cumulative sum" means that
# at each point something changes and that the time series is the sum
# of all previous changes. 
#
# Each "x" in the figure represents a data point in a time series, 
# with 1 being the earliest recording and N being the most recent. 
# The y-axis, represents the cumulative sum of things being counted. 
# Sometimes there are large changes, sometimes there are no changes. 
#
# When data is structured this way, the counts strictly increase. 
# In other words, this relationship is, in theory, ALWAYS true:
#     f(t+1) >= f(t)
#
# (In practice, there might be occasions when f(t+1) < f(t); for 
# example, when data collection errors are corrected. Such 
# declines, however, would indicate a problem of some kind - and,
# ideally, one would want to update all necessary data points 
# so that declines are never present.)
#
# In a cumulative sum time series, the most recent point is also 
# the total count (objects made, tasks completed, events that 
# have occurred, etc.).

## 2.0 Introduction ----
# In this assignment you will work with three datasets, each  
# is a cumulative sum time series. The time interval is 
# one day (24 hours) and two things are being recorded during
# each daily interval: 
#
#     cases -  the number of COVID infections 
#     deaths - the number of deaths due to COVID. 
#
# Further, the case and death counts are collected at three 
# different geographic levels: 
#     national    The U.S. Nation as a whole. 
#     state       U.S. States (50 official U.S. States, plus District
#                 of Columbia, plus other territories).
#     county      Each state is divided into counties. There are around 3,000 
#                 counties in the U.S. And, FYI, Washington State has 
#                 39 counties.*
#
#                 *See County, United States (2022, January 25). In Wikipedia. 
#                          https://en.wikipedia.org/wiki/County_(United_States)
#
# These geographic levels differ in granularity. A state is made up of 
# counties and the nation as a whole is made of states.  Thus, in theory
# the county data should add up to the state data and the state data should
# add up to the national data. 
#
# The data for Assignment 2 come from the New York Times:  
#     The New York Times. (2022). Coronavirus (Covid-19) Data in the 
#          United States. Retrieved [January, 2022], 
#          from https://github.com/nytimes/covid-19-data."
#
# The charts that you might have seen in the New York Times 
# are created from this data: 
#      https://www.nytimes.com/interactive/2021/us/covid-cases.html 
#
# PAUSE        It is remarkable that we have access to this
#   &          data. Please pause and consider what this data 
# THINK        represents and its profound importance.

## 3.0 Instructions ----
# As with Assignment 1, there are two kinds of prompts: 
#
#    Coding prompts:      Write the necessary code to compute the answer. 
#                         For grading, it is important that you store your
#                         answers in the variable names listed with each 
#                         question in `backtics`. Please make sure to store
#                         the appropriate variable type (e.g., 
#                         a string, a vector, a data frame, etc.).
#
#                         Note: Unless otherwise stated, use DPLYR functions
#                         to solve all coding tasks.
#
#    Reflection prompts:  For each prompt marked `REFLECTION`, please write
#                         a response in your `README.md` file.

## 4.0 Getting Started ----
# Some of the coding prompts are difficult. If you get stuck, 
# here are some suggestions: 
#       1. Work slowly and systematically. Try to break the problem into small 
#          parts and tackle the parts, one by one. 
#       2. Clear the RStudio environment variables frequently. Check that 
#          variables contain exactly that data you expect. It is good practice 
#          to source your code from the beginning of the file. 
#       3. Go to the textbook and study the basics - complete the lecture 
#          exercises.
#       4. Search and read the dplyr documentation here: 
#          dplyr API documents: https://dplyr.tidyverse.org/reference/index.html
#          dply cheatsheet    : https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf
#       5. Post a message on Teams and/or ask for help form your TA
#       6. Do a Google search.
#
#  As always, if something is unclear please ask a Teaching Assistant. 

# 1 Loading data ------------------------------------------------------------

# You'll load data at the national, state, and county level. As you move
# through the assignment, you'll need to consider the appropriate data to 
# answer each question. 

# NOTE: To load the data you will need to get the "raw URLs" from the New 
# York Times GitHub page: https://github.com/nytimes/covid-19-data/

# This will clear your environment variables - helpful for keeping 
# your work tidy and for debugging. You will find bugs more more quickly 
# if you study your environment variables and start fresh frequently.
rm(list = ls())

# IMPORTANT: You MUST set your working directory. You can do this in 
# a couple of ways.  One way is to edit this absolute directory 
# path for your computer.  It MUST point to the directory within 
# which you are working.
setwd("E:/A2/a2-starter-zkornas")

# Here, some assignment functions are loaded. You do not need to 
# understand these functions - but you might want to look at this 
# file and see what's there!
install.packages("RcppRoll")
install.packages("stringr")
library(stringr)
library(RcppRoll)
source("a2-functions.R")

# 1.a Load the tidyverse package
library(tidyverse)

# NOTE: In these coding tasks, replace the NULL value to the correct R code. 
#       For some of the prompts, we have typed the variable names for you, 
#       to save you a little typing!
#
#       About NULL: Recall that NULL is a special R symbol which means, 
#       basically, "empty" or "nothing." Often it means, specifically, 
#       that an R object, such as a function or data frame, has not been 
#       initialized. 
#
# SUGGESTION: To learn more about NULL, do this Google search: "R NULL value". 

# 1.b Load the *national level* data into a variable. `national`
national <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us.csv")

# 1.c Load the *state level* data into a variable. `states`
states <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

# 1.d Load the *county level* data into a variable. `counties`
#     NOTE: This is a large dataset. It may take 30-60 seconds to load.
counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

# 1.e How many observations (rows) are in each dataset?
# Create `obs_national`, `obs_states`, `obs_counties`
obs_national <- nrow(national)
obs_states <- nrow(states)
obs_counties <- nrow(counties)

# 1.f How many features (columns) are there in each dataset?
# Create `num_features_national`, `num_features_states`, `num_features_counties`
num_features_national <- ncol(national)
num_features_states <- ncol(states)
num_features_counties <- ncol(counties)

# R1.a REFLECTION: Use View() to open the three datasets and explore 
#      the data, and with documentation form the New York Times, answer 
#      these questions: 
#        (a) How does the County-level data differ from the 
#            the State-level and U.S. National-level? 
#        (b) What is the same about these three datasets? 
#        (c) What does the feature "fips" mean? Do a Google search and/or
#            visit: https://www.census.gov/library/reference/code-lists/ansi.html
View(national)
# 2 Exploratory Analysis ----------------------------------------------------

# Use functions from the DPLYR package to explore the datasets by answering
# the following questions. Note, you must return the specific column being
# asked about. You do this with the pull() function. For example: 
#
#       What is the earliest date in the National-level dataset? `earliest_date`
#       This code is CORRECT because pull() is used to return a single value:
       earliest_date <- national %>%
           filter(date == min(date)) %>%
           pull(date)
#
#       This is NOT correct because an entire row is returned
       earliest_date <- national %>%
           filter(date == min(date))

# SUGGESTION: Un-comment the code and try out these two dpyler expressions.
#             Examine the data that is being returned.

# NOTE: Unless otherwise stated, use DPLYR functions to solve all coding 
#       tasks.

# 2.a How many total cases have there been in the U.S. by the most recent date
# in the dataset? `total_us_cases`
total_us_cases <- national %>%
  filter(date == max(date)) %>%
  pull(cases)

# 2.b How many total deaths have there been in the U.S. by the most recent date
# in the dataset? `total_us_deaths`
total_us_deaths <- national %>%
  filter(date == max(date)) %>%
  pull(deaths)

# 2.c Which state has had the highest number of cases?
# `state_highest_cases`
state_highest_cases <- states %>%
  filter(cases == max(cases)) %>%
  pull(state)

# 2.d What is the highest number of cases in a state?
# `num_highest_state`
num_highest_state <- states %>%
  filter(cases == max(cases)) %>%
  pull(cases)

# 2.e Which state has the highest ratio of deaths to cases (deaths/cases), 
# as of the most recent date? HINT: You may need to create a new column in 
# order to do this. `state_highest_ratio`
state_highest_ratio <- states %>%
  mutate(ratio = (deaths/cases)) %>%
  filter(ratio == max(ratio)) %>%
  pull(state)

# 2.f Which state has had the fewest number of cases *as of the most 
# recent date*? HINT: This is a little trickier to calculate than the 
# maximum because of the meaning of the row. `state_lowest_cases`
state_lowest_cases <- states %>%
  filter(date == max(date, na.rm = TRUE)) %>%
  filter(cases == min(cases, na.rm = TRUE)) %>%
  pull(state)

# R2.a REFLECTION: (a) What did you learn about the dataset when you calculated
#      the state with the lowest cases; and (b) What does that tell you about 
#      testing your assumptions in a dataset?  
#      REMINDER: Please answer in the README.md.

# 2.g Which county has had the highest number of cases?
# `county_highest_cases`
county_highest_cases <- counties %>%
  filter(cases == max(cases)) %>%
  pull(county)

# 2.h What is the highest number of cases that have happened in a single county?
# `num_highest_cases_county`
county_highest_cases <- counties %>%
  filter(cases == max(cases)) %>%
  pull(cases)

# 2.i Because there are multiple counties with the same name across states, it
# will be helpful to have a column that stores the county and state together, 
# in this form: "COUNTY, STATE". Therefore, add a new column to your `counties` 
# data frame called `location` that stores the county and state (separated by 
# a comma and space). You can do this in at least two ways:
#   (1) `mutate()`   and the `paste0()` string function; or
#   (2) `unite()`  - see https://tidyr.tidyverse.org/reference/unite.html 
#       (Note: Be sure to keep the original columns.
#              To do so, use the parameter `remove=FALSE`.)
counties <- counties %>%
  mutate(location = paste(county, ", ", state))

# 2.j What is the name of the location (county, state) with the highest number
# of deaths? `location_most_deaths`
location_most_deaths <- counties %>%
  filter(deaths == max(deaths, na.rm = TRUE)) %>%
  pull(location)

# R2.b REFLECTION: Is the location with the highest number of cases the 
#      location with the most deaths? If not, why do you believe that may be 
#      the case?

# NOTE: As you have seen, the three datasets are "cumulative sums," that is, running 
# totals of the number of cases and deaths. On each day the cases and deaths counts
# either stay the same or increase. They should never decrease. It is often very 
# helpful to know by how much the numbers have increased (if at all) between 
# successive times. 

# 2.k Add a new column to your `national` data frame called `new_cases`; that is, 
# the number new cases each day.
# HINTS:
#    (1) Recall that the dyplr mutate() function is used to add new columns.
#    (2) The dyplr lag() function will be very helpful. Search "R dplyr lag()" 
#        on Google and look for a good link. 
national <- national %>%
  mutate(new_cases = cases - lag(cases))

# 2.l Similarly, the `deaths` columns *is not* the number of new deaths per day.
# Add  a new column to the `national` data frame called `new_deaths`
# that has the number of *new* deaths each day
national <- national %>%
  mutate(new_deaths = deaths - lag(deaths))

# 2.m What was the date when the most new cases occurred?
# `date_most_cases`
date_most_cases <- national %>%
  filter(new_cases == max(new_cases, na.rm = TRUE)) %>%
  pull(date)

# 2.n What was the date when the most new deaths occurred?
# `date_most_deaths`
date_most_deaths <- national %>%
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(date)

# 2.o How many people died on the date when the most deaths occurred? `most_deaths`
most_deaths <- national %>%
  filter(new_deaths == max(new_deaths, na.rm = TRUE)) %>%
  pull(new_deaths)

# 2.p Create a (very basic) plot by passing `national$new_cases` column to the
# `plot()` function. Store the result in a variable `new_cases_plot`.
new_cases_plot <- plot(national$new_cases)

# 2.q Create a (very basic) plot by passing the `new_deaths` column to the
# `plot()` function. Store the result in a variable `new_deaths_plot`.
new_deaths_plot <- plot(national$new_deaths)

# INTERLUDE -  Have fun! - No specific points.
#
# The plots you just created are rudimentary. As you have seen, 
# the charts in the New York Times are more refined. See: 
# https://www.nytimes.com/interactive/2021/us/covid-cases.html 
#
# We have developed a chart that demonstrates that you too will
# soon be able to create insightful and beautiful charts. 
#
# Run this code several times, changing the window size. 
# Suggestions for window sizes: 1, 3, 7, 20, 50, 200. You
# should see the charts in the RStudio "Plots" tab.
window_size <- 200
national <- moving_avg_counts(national, window_size)
moving_avg_cases_plot <- plot_moving_avg_cases(national, window_size)
print(moving_avg_cases_plot)

# This chart would NOT be possible without the data wrangling 
# that you did in part 2.0!!  (If the chart does not appear, 
# please contact your TA.)
#
# If you like, review the two functions: moving_avg_counts() and 
# plot_moving_avg_cases() in the file `a2-functions.R`. You will 
# see R functions and coding strategies that you have already learned. 
#
# Take note that you have the foundation coding knowledge 
# to do this kind of work, and much more! 

# R2.c REFLECTION: Briefly comment on plots that you have just 
#                  reviewed.

# 3. Grouped Analysis --------------------------------------------------------

# An incredible power of R is to perform the same computation *simultaneously*
# across groups of rows. As you know, this capability is called aggregation 
# it relies on the group_by() and summarize() functions in dplyr. 
#
# For more on summarize, see: https://dplyr.tidyverse.org/index.html
# For more on group_by() see: https://dplyr.tidyverse.org/articles/grouping.html?q=group%20_%20by#group_by 

# 3.a What is the county with the *current* highest number of cases in each state? 
# *Current* means the the most recent date. Your answer, stored in
# `highest_in_each_state`, should be a *vector* of  `location` names, that is, 
# the column with COUNTY, STATE.  HINT: Be careful about the order of filtering 
# your data.
highest_in_each_state <- counties %>%
  filter(date == max(date, na.rm = TRUE)) %>%
  group_by(state) %>%
  filter(cases == max(cases, na.rm = TRUE)) %>%
  pull(location)

# 3.b Using the variable `highest_in_each_state`, which location (COUNTY, STATE) has had
# the highest number of cases in Washington? `highest_in_wa`
# Hint: Use the function str_detect() from the stringr() package. 
x <- str_detect(highest_in_each_state, "Washington")
highest_in_wa <- highest_in_each_state[x]

# 3.c What is the county with the *current* (e.g., on the most recent date)
# lowest number of deaths in each state? Your answer, stored in
# `lowest_in_each_state`, should be a *vector* of
# `location` names (the column with COUNTY, STATE).
lowest_in_each_state <- counties %>%
  filter(date == max(date, na.rm = TRUE)) %>%
  group_by(state) %>%
  filter(cases == min(cases, na.rm = TRUE)) %>%
  pull(location)

# R3.a REFLECTION: Why are there so many observations (counties) in the 
#      variable `lowest_in_each_state`? That is, wouldn't you expect 
#      the number to be around 50? 

# 3.d What *proportion* of counties have had zero deaths in each state? 
# This is a very simple question. But, as is often the case, with data 
# and code, it is actually quite complex. Consider that:  
#    prop =  ncz / T,   where ncz is the number of counties with zero deaths
#                       and T is the total number of counties. 
# Given this, the goal is to return a *data frame* with both the state name, 
# and the proportion (`prop`) in a variable called `prop_no_deaths`
#
# There are several ways to tackle this question. This is a long but 
# relatively straightforward approach: 
#    (1) Create a data frame with two columns: `state` and `ncz`. 
#    (2) Create a second data frame with two columns: `state` and `T`
#    (3) Join the two data frames by `state` and add the `prop` column
#    (4) You will note that the data frame from step 3 has a lot of NAs. 
#        Why? You can replace the NAs with `replace_na()`
#        See https://tidyr.tidyverse.org/reference/replace_na.html

# NOTE: As you work on steps (1) and (2) carefully consider how to group 
# the data.
prop_no_deaths <- counties %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(no_deaths = sum(deaths == 0),
            ncz = no_deaths / n()) %>%
  select(state, ncz)

# 3.e Using the `prop_no_deaths` variable (3.d), what proportion of counties in 
# Washington State have had zero deaths? `wa_prop_no_deaths`
wa_prop_no_deaths <- prop_no_deaths %>%
  filter(state == "Washington", na.rm = TRUE) %>%
  pull(ncz)

# 4. Joins  --------------------------------------------------------

# As described at the New York Times GitHub page, collecting this 
# data has been a massive effort. Accordingly, there might be 
# mistakes in the data. After all, data is being collected 
# for more than 3,000 U.S. counties.  
#
# (Incidentally, to determine exactly how many counties are in your
# dataset you could use this command: 
#    n_distinct(counties$location) or
#    length(unique(counties$location))
# See: https://dplyr.tidyverse.org/reference/n_distinct.html) 
#
# One check for data consistency is the following: 
# 
#     On each day, (a) All the County case counts for
#     a State (`counties` data frame) should sum to the State
#     case counts (`states`); and, also, (b) The States case 
#     counts should sum to the National case counts (`national`).
#
# If (a) is false or (b) is false then something is wrong.
#
# A convenient way to test for this data consistency check
# is to create the following four-column data frame 
# (`all_totals`) and then compare the national, state, and 
# county totals: 
#
# all_totals: 
# date | national_total_cases | state_total_cases | county_total_cases 
#
# Column                Brief description 
# date:                 Each day in the time series 
# national_total_cases: The case counts in the `national` data frame
# state_total_cases:    The sum of all case counts in the `states` data frame
# county_total_cases:   The sum of all case counts in the `counties` data frame
#
# We now guide you through the steps for this consistency check. We've typed the 
# variable names to save you a little bit of work.
#
# 4.a Create a `county_by_day` data frame with columns: 
#     `date` and `county_total_cases`. HINT: To summarize 
#      the case counts, how do you need to group the data?
county_by_day <- counties %>%
  group_by(date) %>%
  summarise(county_total_cases = sum(cases))

# 4.b Create a `state_by_day` data frame with columns: 
#     `date` and `state_total_cases`.  HINT: See previous 
#      hint.
state_by_day <- states %>%
  group_by(date) %>%
  summarise(state_total_cases = sum(cases))

# 4.c Join the `county_by_day` and `state_by_day` data frames. Call
#     this data frame `totals_by_day`.
totals_by_day <- left_join(county_by_day, state_by_day, by = "date")

# 4.d Join `totals_by_day` with the `nation` data frame and, for 
#     clarity, rename the `cases` column to `national_total_cases`. Call 
#     this data frame `all_totals`.
all_totals <- left_join(national, totals_by_day, by = "date")
all_totals <- rename(all_totals, national_total_cases = cases)

# Finally, with this convenient data frame (`all_totals`), you can 
# write code to test the consistency check. 

# 4.e How many differences do you find between `national_total_cases` and 
#     `state_total_cases`? 
#     `national_state_diff`  (as a numeric value - use pull() function )
national_state_diff <- sum(all_totals$national_total_cases != all_totals$state_total_cases)

# 4.f How many differences do you find between `state_total_cases` and 
#     `county_total_cases'? 
#     `state_county_diff` (as a numeric value - use the pull() function)
state_county_diff <- sum(all_totals$state_total_cases != all_totals$county_total_cases)

# R4.a REFLECTION: When the check was carried out on January 25, 2022
#      an inconsistency was found. (a) Given the work that you've just
#      completed (4.a - 4.f), what can you say about the source of the 
#      inconsistency? (b) What might be your next step to discover where 
#      exactly in the data the inconsistency lies? To answer questions
#      (a) and (b), consider exploring the data frames that 
#      you have created in the above steps.

# 5. Independent exploration -------------------------------------------------

# 5.a In sections 2-4, you were asked to find answers to questions about 
#     three cumulative sum time series, of profound importance for making 
#     sense of the present and for shaping human action in the future. 
#     Now, it is your turn. Ask your own question and then wrangle some 
#     data to answer your question. Show that your code works. As 
#     appropriate, please comment your code so that it is understandable.

# QUESTION:  Write your question for 5.a here:
#            What are the 5 days of highest Covid-19 cases in each state?    and the code is ... 
the_answer_is <- states %>%
  arrange(desc(cases)) %>%
  group_by(state) %>%
  slice(1:5)
  
# 6. Your learning  ----------------------------------------------------------

# R6.a REFLECTION: Please briefly comment on one of these or similar questions: 
#      (a) What, if anything, made you curious? (b) What, if anything, 
#      surprised you about this coding work? (c) What might you do the same 
#      or differently on your next data wrangling project? 
