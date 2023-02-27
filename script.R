#DATA PREPARATION
dir.create("data")
setwd("./data")
path <- getwd() 
library(tidyverse)
library(readr)
sapply(list.files(path), unzip) #unzip files
file.remove(list.files(path, pattern = "*.zip")) #remove all .zip files because it is no use
file.rename("202209-divvy-publictripdata.csv", "202209-divvy-tripdata.csv") 

#DATA PROCESS
#Collect data
ls_files <- list.files(path, pattern = "*.csv", full.names = TRUE)
read_files <- lapply(ls_files, function(x) {
  read.csv(x)
})

#checking the column names of all files
col_names <- as.data.frame(sapply(1:length(read_files), function(x) {
  names(read_files[[x]])
})) 
sum(sapply(1:(length(col_names)-1), function (x) {
  identical(col_names[x], col_names[x+1])
})) #identical returns logical vector, sum returns 0
rm(read_files) #remove it to free up space

#merging all files into one
df <- data.frame()
df <- ls_files %>% 
  lapply(read_csv) %>% 
  bind_rows 

#Inspect the data
head(df) 
dim(df) 
summary(df) 
str(df)
table(df$rideable_type) #check if any misspelling data
table(df$member_casual) #check if any misspelling data

#checking NA values for important variables for further analysis
#station-related variables are used to visualize locations that should be focused on 
#split the info of station from main_df into station_df
start_station_df <- df %>% 
  select(station_id = start_station_id, station_name = start_station_name, latitude = start_lat, longitude = start_lng) %>% 
  drop_na(station_id) %>% 
  distinct(station_id, .keep_all = T) #if there is no .keep_all = T, other columns will be removed
end_station_df <- df %>% 
  select(station_id = end_station_id, station_name = end_station_name, latitude = end_lat, longitude = end_lng) %>% 
  drop_na(station_id) %>% 
  distinct(station_id, .keep_all = T)
station_df <- rbind(start_station_df, end_station_df) 
station_df <- station_df %>% 
  distinct(station_id, .keep_all = T) %>% 
  arrange(station_name)
rm(start_station_df, end_station_df)

#First, look at start_station 
#no NA value for start_lat and start_lng but there is NA for start_station_id
sum(is.na(df$start_station_id)) #843525
#To solve this, we will get info from station_df and enter it into main_df. 
#because there are more than 1 station for the same latitude and longitude, the first station (in alphabetical order) will be chosen
indices_1 <- which(is.na(df$start_station_id)) 
df$start_station_id[indices_1] <- sapply(indices_1, function (x) {
  i <- which(station_df$latitude == df$start_lat[x] & 
               station_df$longitude == df$start_lng[x])[1]
  station_df$station_id[i]
})
indices_2 <- which(is.na(df$start_station_name))
df$start_station_name[is.na(df$start_station_name)] <- sapply(indices_2, function (x) {
  i <- which(station_df$latitude == df$start_lat[x] & 
               station_df$longitude == df$start_lng[x])[1]
  station_df$station_name[i]
})

#end_station
#there is NA value for end_lat and end_lng. end_lat and end-lng depend on end_station_name
#if there is NA for end_station_name, there will be NA as well for end_lat and end_lng but not the other way around
sum(is.na(df$end_station_id)) #902655
sum(is.na(df$end_station_name) & (is.na(df$end_lat))) #5899
sum(is.na(df$end_station_name) & (!is.na(df$end_lat))) #896756
#solve like start_station, but observations that have NA values for end_station_name and end_lat will be removed
indices_3 <- which(is.na(df$end_station_id) & (!is.na(df$end_lat))) 
df$end_station_id[indices_3] <- sapply(indices_3, function (x) {
  i <- which(station_df$latitude == df$end_lat[x] & 
               station_df$longitude == df$end_lng[x])[1]
  station_df$station_id[i]
})
indices_4 <- which(is.na(df$end_station_name)& (!is.na(df$end_lat)))
df$end_station_name[indices_4] <- sapply(indices_4, function (x) {
  i <- which(station_df$latitude == df$end_lat[x] & 
               station_df$longitude == df$end_lng[x])[1]
  station_df$station_name[i]
})
#Results after cleaning station_name
sum(is.na(df$start_station_id)) #514861
sum(is.na(df$end_station_id)) #557950

#create ride_length and day_of_week variables
df$ride_length <- as.numeric(difftime(df$ended_at,df$started_at)) #convert to numeric to do calculations
df$day_of_week <- weekdays(df$started_at)

#Extract datetime columns into date, month, day, and year
df_2$month <- format(as.Date(df_2$date), "%m")
df_2$day <- format(as.Date(df_2$date), "%d")

#Removing bad data by creating a new data frame without
#ride_length was smaller than 5 
df_2 <- df[!(df$ride_length < 300),] %>% as.data.frame()
df_2 <- as.tibble(df_2) #to save memory 

#SHARE
write.csv(df_4, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//member_casual_weekday.csv", row.names =  F)
write.csv(df_5, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//member_casual_rideable_type.csv", row.names =  F)
write.csv(df_6, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//member_casual_rideable_weekday.csv", row.names = F)
write.csv(df_2, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//tripdata_202202_202301.csv", row.names = F)
write.csv(df_7, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//member_station.csv", row.names = F)
write.csv(station_df, file = "D://coursera//google data analytics project capstone//case study 1//Project-Cyclistic//graphic//station.csv", row.names = F)
save(df, file = "df.RData")
