---
editor_options: 
  markdown: 
    wrap: 72
---

# GOOGLE DATA ANALYTICS PROFESSIONAL CERTIFICATE CASE STUDY

The last part of the course requires students to finish a capstone
project to apply skills that I have learnt throughout the course. This
project is about "How does a bike-share navigate speedy success?". The
analysis process will go through 5 phases: ask, prepare, process,
analyze, share and act:

-   Ask": business understanding (identify the business task, consider
    key stakeholders)

-   "Prepare": prepare data for analysis (store data, identify how it's
    organized, sort and filter data, determine the credibility of the
    data)

-   "Process": cleaning or manipulation of data (check the data for
    errors, transform the data)

-   "Analyze": get the insights of data (organize and format your data,
    make some computations, identify trends and relationships)

-   "Share": create visualizations and list key findings

-   "Act": top three recommendations

At the preparation stage, R will be used. For the analysis part, I will
use R as well. Tableau is for the visualisation. [Github
repo](https://github.com/lynnevo170701/case-study-1.git) for more
information.

## INTRODUCTION

Cyclistic is a bike-share company in Chicago, launched in 2016. We offer
wide range of pricing plans: single-ride passes, full-day passes, and
annual memberships.

For future growth, the maximization of the number of annual memberships
is the best strategy. Before implementing a new marketing campaign to
convert casual riders into annual members, the marketing team needs to
understand the difference between these two types of pricing plans.

As a junior data analyst, I look at the history data of the past 6
months to analyze and find out the trend of these types to help the
marketing team - in which Lily Moreno is a marketing director -- develop
the best marketing strategy that aligns with the casual riders' motives
for changing to annual memberships. In addition to that, recommendations
are followed up and reported to Cyclistic executive team.

## DATA PREPARATION

Cyclistic's [historical trip
dataset](https://divvy-tripdata.s3.amazonaws.com/index.html) is
authorized by Motivate International Inc, under [this
license](https://ride.divvybikes.com/data-license-agreement).
Data-privacy issues don't allow to use riders'personally identifiable
information (credit card numbers...).

The time frame is 12 months from February 2022 to January 2023. The data
is categorized into .csv files split up by each month. The downloaded
files are in .zip format. They needed to be unzipped into .csv files
before cleaning phase. There is one file that was named
"202209-divvy-publictripdata.csv" and needed to be changed to consistent
names as other files. In each data file, the variables are listed below:

| \#  | Variables            | Description                                 |
|-----|----------------------|---------------------------------------------|
| 1   | ride_id              | ID (primary key) for each ride              |
| 2   | r ideable_type       | type of bicycle used                        |
| 3   | started_at           | the date and time customers book            |
| 4   | ended_at             | the date and time customers return          |
| 5   | start\_ station_name | station where customers get the bicycles    |
| 6   | star t_station_id    | ID of start_station                         |
| 7   | end\_ station_name   | station where customers return the bicycles |
| 8   | en d_station_id      | ID of end_station                           |
| 9   | start_lat            | latitude of the start station               |
| 10  | start_lng            | longitude of the start station              |
| 11  | end\_\_lat           | latitude of the end station                 |
| 12  | end_lng              | longituide of the end station               |
| 13  | m ember_casual       | types of membership                         |

## DATA PROCESS

Before merging all files into one file, I will check the column names of
all files if they are identical. Using `sapply` function to repeatedly
apply `names` function (list all the variable names) to each file.
`identical` function is used to check if two objects are exactly the
same. It turns out that all files have the same column names. It's ready
to merge all files.
