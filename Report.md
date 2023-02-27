# GOOGLE DATA ANALYTICS PROFESSIONAL CERTIFICATE CASE STUDY

The last part of the course requires students to finish a capstone
project to apply skills that I have learnt throughout the course. This
project is about “How does a bike-share navigate speedy success?”. The
analysis process will go through 5 phases: ask, prepare, process,
analyze, share and act:

-   Ask”: business understanding (identify the business task, consider
    key stakeholders)

-   “Prepare”: prepare data for analysis (store data, identify how it’s
    organized, sort and filter data, determine the credibility of the
    data)

-   “Process”: cleaning or manipulation of data (check the data for
    errors, transform the data)

-   “Analyze”: get the insights of data (organize and format your data,
    make some computations, identify trends and relationships)

-   “Share”: create visualizations and list key findings

-   “Act”: top three recommendations

R is used for preparation, cleaning and analysis. Tableau and PowerBi is
for the visualisation. This is my [Github
repo](https://github.com/lynnevo170701/case-study-1.git) for more
information.

## INTRODUCTION

Cyclistic is a bike-share company in Chicago, launched in 2016. They
offer wide range of pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who buy single-ride passes, full-day
passes are categorized as “casual riders”. Customers who purchase annual
memberships are Cyclistic members. There are 692 stations across
Chicago. Rider can unlock from one station and return to any other
station in the system anytime.

For future growth, the maximization of the number of annual memberships
is the best strategy. Before implementing a new marketing campaign to
convert casual riders into annual members, the marketing team needs to
understand the difference between these two types of pricing plans.

As a junior data analyst, I look at the history data of the past 12
months to analyze and find out the trend of these types to help the
marketing team - in which Lily Moreno is a marketing director – develop
the best marketing strategy that aligns with the casual riders’ motives
for changing to annual memberships. In addition to that, recommendations
are followed up and reported to Cyclistic executive team.

## DATA PREPARATION

Cyclistic’s [historical trip
dataset](https://divvy-tripdata.s3.amazonaws.com/index.html) is
authorized by Motivate International Inc, under [this
license](https://ride.divvybikes.com/data-license-agreement).
Data-privacy issues don’t allow to use riders’personally identifiable
information (credit card numbers…).

The time frame is 12 months from February 2022 to January 2023. The data
is categorized into .csv files split up by each month. The downloaded
files are in .zip format. They needed to be unzipped into .csv files
before cleaning phase. There is one file that was named
“202209-divvy-publictripdata.csv” and needed to be changed to consistent
names as other files. In each data file, the variables are listed below:

<table>
<colgroup>
<col style="width: 7%" />
<col style="width: 28%" />
<col style="width: 64%" />
</colgroup>
<thead>
<tr class="header">
<th>#</th>
<th>Variables</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>ride_id</td>
<td>ID (primary key) for each ride</td>
</tr>
<tr class="even">
<td>2</td>
<td>rideable_type</td>
<td>type of bicycle used</td>
</tr>
<tr class="odd">
<td>3</td>
<td>started_at</td>
<td>the date and time customers book</td>
</tr>
<tr class="even">
<td>4</td>
<td>ended_at</td>
<td>the date and time customers return</td>
</tr>
<tr class="odd">
<td>5</td>
<td>start_station_name</td>
<td>station where customers get the bicycles</td>
</tr>
<tr class="even">
<td>6</td>
<td>start_station_id</td>
<td>ID of start_station</td>
</tr>
<tr class="odd">
<td>7</td>
<td>end_station_name</td>
<td>station where customers return the bicycles</td>
</tr>
<tr class="even">
<td>8</td>
<td>end_station_id</td>
<td>ID of end_station</td>
</tr>
<tr class="odd">
<td>9</td>
<td>start_lat</td>
<td>latitude of the start station</td>
</tr>
<tr class="even">
<td>10</td>
<td>start_lng</td>
<td>longitude of the start station</td>
</tr>
<tr class="odd">
<td>11</td>
<td>ended__lat</td>
<td>latitude of the end station</td>
</tr>
<tr class="even">
<td>12</td>
<td>ended_lng</td>
<td>longituide of the end station</td>
</tr>
<tr class="odd">
<td>13</td>
<td>member_casual</td>
<td>types of membership</td>
</tr>
</tbody>
</table>

## DATA PROCESS

Before merging all files into one file, I will check the column names of
all files if they are identical. Using `sapply` function to repeatedly
apply `names` function (list all the variable names) to each file.
`identical` function is used to check if two objects are exactly the
same. It turns out that all files have the same column names. It’s ready
to merge all files.

After merging all files, inspecting data is to have the first sense with
data to see what data type each column have, if there are any
misspelling mistakes…

    head(df)

    ##            ride_id rideable_type          started_at            ended_at
    ## 1 E1E065E7ED285C02  classic_bike 2022-02-19 18:08:41 2022-02-19 18:23:56
    ## 2 1602DCDC5B30FFE3  classic_bike 2022-02-20 17:41:30 2022-02-20 17:45:56
    ## 3 BE7DD2AF4B55C4AF  classic_bike 2022-02-25 18:55:56 2022-02-25 19:09:34
    ## 4 A1789BDF844412BE  classic_bike 2022-02-14 11:57:03 2022-02-14 12:04:00
    ## 5 07DE78092C62F7B3  classic_bike 2022-02-16 05:36:06 2022-02-16 05:39:00
    ## 6 9A2F204F04AB7E24  classic_bike 2022-02-07 09:51:57 2022-02-07 10:07:53
    ##             start_station_name start_station_id               end_station_name
    ## 1       State St & Randolph St     TA1305000029         Clark St & Lincoln Ave
    ## 2  Halsted St & Wrightwood Ave     TA1309000061 Southport Ave & Wrightwood Ave
    ## 3       State St & Randolph St     TA1305000029            Canal St & Adams St
    ## 4 Southport Ave & Waveland Ave            13235         Broadway & Sheridan Rd
    ## 5       State St & Randolph St     TA1305000029          Franklin St & Lake St
    ## 6       St. Clair St & Erie St            13016        Franklin St & Monroe St
    ##   end_station_id start_lat start_lng  end_lat   end_lng member_casual
    ## 1          13179  41.88462 -87.62783 41.91569 -87.63460        member
    ## 2   TA1307000113  41.92914 -87.64908 41.92877 -87.66391        member
    ## 3          13011  41.88462 -87.62783 41.87926 -87.63990        member
    ## 4          13323  41.94815 -87.66394 41.95283 -87.64999        member
    ## 5   TA1307000111  41.88462 -87.62783 41.88584 -87.63550        member
    ## 6   TA1309000007  41.89435 -87.62280 41.88032 -87.63519        member
    ##   ride_length day_of_week
    ## 1         915    Saturday
    ## 2         266      Sunday
    ## 3         818      Friday
    ## 4         417      Monday
    ## 5         174   Wednesday
    ## 6         956      Monday

    dim(df)

    ## [1] 5754248      15

    summary(df)

    ##    ride_id          rideable_type        started_at                    
    ##  Length:5754248     Length:5754248     Min.   :2022-02-01 00:03:18.00  
    ##  Class :character   Class :character   1st Qu.:2022-06-02 15:18:09.50  
    ##  Mode  :character   Mode  :character   Median :2022-07-27 22:50:40.50  
    ##                                        Mean   :2022-07-29 13:28:03.16  
    ##                                        3rd Qu.:2022-09-22 20:34:47.25  
    ##                                        Max.   :2023-01-31 23:56:09.00  
    ##                                                                        
    ##     ended_at                      start_station_name start_station_id  
    ##  Min.   :2022-02-01 00:09:37.00   Length:5754248     Length:5754248    
    ##  1st Qu.:2022-06-02 15:37:50.50   Class :character   Class :character  
    ##  Median :2022-07-27 23:09:33.00   Mode  :character   Mode  :character  
    ##  Mean   :2022-07-29 13:47:21.50                                        
    ##  3rd Qu.:2022-09-22 20:53:25.25                                        
    ##  Max.   :2023-02-04 04:27:03.00                                        
    ##                                                                        
    ##  end_station_name   end_station_id       start_lat       start_lng     
    ##  Length:5754248     Length:5754248     Min.   :41.64   Min.   :-87.84  
    ##  Class :character   Class :character   1st Qu.:41.88   1st Qu.:-87.66  
    ##  Mode  :character   Mode  :character   Median :41.90   Median :-87.64  
    ##                                        Mean   :41.90   Mean   :-87.65  
    ##                                        3rd Qu.:41.93   3rd Qu.:-87.63  
    ##                                        Max.   :42.07   Max.   :-87.52  
    ##                                                                        
    ##     end_lat         end_lng       member_casual       ride_length     
    ##  Min.   : 0.00   Min.   :-88.14   Length:5754248     Min.   :-621201  
    ##  1st Qu.:41.88   1st Qu.:-87.66   Class :character   1st Qu.:    346  
    ##  Median :41.90   Median :-87.64   Mode  :character   Median :    612  
    ##  Mean   :41.90   Mean   :-87.65                      Mean   :   1158  
    ##  3rd Qu.:41.93   3rd Qu.:-87.63                      3rd Qu.:   1100  
    ##  Max.   :42.37   Max.   :  0.00                      Max.   :2483235  
    ##  NA's   :5899    NA's   :5899                                         
    ##  day_of_week       
    ##  Length:5754248    
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ##                    
    ## 

    str(df)

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 5754248 obs. of  15 variables:
    ##  $ ride_id           : chr  "E1E065E7ED285C02" "1602DCDC5B30FFE3" "BE7DD2AF4B55C4AF" "A1789BDF844412BE" ...
    ##  $ rideable_type     : chr  "classic_bike" "classic_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct, format: "2022-02-19 18:08:41" "2022-02-20 17:41:30" ...
    ##  $ ended_at          : POSIXct, format: "2022-02-19 18:23:56" "2022-02-20 17:45:56" ...
    ##  $ start_station_name: chr  "State St & Randolph St" "Halsted St & Wrightwood Ave" "State St & Randolph St" "Southport Ave & Waveland Ave" ...
    ##  $ start_station_id  : chr  "TA1305000029" "TA1309000061" "TA1305000029" "13235" ...
    ##  $ end_station_name  : chr  "Clark St & Lincoln Ave" "Southport Ave & Wrightwood Ave" "Canal St & Adams St" "Broadway & Sheridan Rd" ...
    ##  $ end_station_id    : chr  "13179" "TA1307000113" "13011" "13323" ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.6 -87.7 -87.6 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 42 41.9 ...
    ##  $ end_lng           : num  -87.6 -87.7 -87.6 -87.6 -87.6 ...
    ##  $ member_casual     : chr  "member" "member" "member" "member" ...
    ##  $ ride_length       : num  915 266 818 417 174 956 229 523 338 350 ...
    ##  $ day_of_week       : chr  "Saturday" "Sunday" "Friday" "Monday" ...
    ##  - attr(*, "spec")=List of 3
    ##   ..$ cols   :List of 13
    ##   .. ..$ ride_id           : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ rideable_type     : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ started_at        :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_datetime" "collector"
    ##   .. ..$ ended_at          :List of 1
    ##   .. .. ..$ format: chr ""
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_datetime" "collector"
    ##   .. ..$ start_station_name: list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ start_station_id  : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ end_station_name  : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ end_station_id    : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   .. ..$ start_lat         : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
    ##   .. ..$ start_lng         : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
    ##   .. ..$ end_lat           : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
    ##   .. ..$ end_lng           : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_double" "collector"
    ##   .. ..$ member_casual     : list()
    ##   .. .. ..- attr(*, "class")= chr [1:2] "collector_character" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr [1:2] "collector_guess" "collector"
    ##   ..$ delim  : chr ","
    ##   ..- attr(*, "class")= chr "col_spec"
    ##  - attr(*, "problems")=<externalptr>

Checking NA values is also important for further analysis
(station-related variables are used to visualize locations). After
cleaning `start_station_name`, missing values drop from 843525 to
514861. Missing values from `end_station_name` also drop from 902655 to
557950. For further analysis, I will create one column to calculate
duration of each ride and one column to extract weekday from column
`started_at`.

Only observations that have `ride_length` more than 5 minutes are
chosen.

## DATA ANALYSIS

Looking at the figure 1, customers that are Cyclistic members have have
more rides. However, the average duration of casual customers are twice
as much as that of members. Members have more time for their annual
membership than casual riders. They may be tourists or infrequent users
who rent for short time but they will make the most of it before
returning.

![Figure 1. Member and casual riders in six days of
week](graphic/day%20of%20week.png)

There is a big gap between casual and member customers. Casual riders
use bikes more in the weekend than weekdays but member bikers have the
opposite trend. This trend can be explained by the reason that members
use bikes for daily commute. That is also a reason why they buy annual
membership rather than buying single-ride passes or full-day passes to
save much money. When it comes to average duration, casual customers
have much higher than member in every day in the week, especially in the
weekend

![Figure 2. Member and casual usage of bike in a
year](graphic/mem_type_month.png)

As shown in Figure 2, member uses bikes more than casual members
throughout the year. However, only from the end of May till half of
July, casual customers were recorded to have more rides. This is the
summer time when tourists and infrequent users have an increasing
pattern of using bike services. In the second graph of Figure 2, I split
the number of rides into three types of bikes: classic, docked and
electric bike. There is nothing much to say for the classic bike. But
for the docked bike, only casual customers use this type of bike. The
electric bike has the same trend as the overall graph.

![Figure 3. Average duration of member and casual in a
month](graphic/mem_day.png)

In Figure 1, average duration of casual riders are twice as much as

## RECOMMENDATIONS

## CONCLUSION

## 
