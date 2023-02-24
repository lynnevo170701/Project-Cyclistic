#DATA PROCESS
dir.create("data")
path <- setwd("./data") 
library(tidyverse)
sapply(list.files(path), unzip) #unzip files
file.remove(list.files(path, pattern = "*.zip")) #remove all .zip files because it is no use
file.rename("202209-divvy-publictripdata.csv", "202209-divvy-tripdata.csv") 
#read files
ls_files <- list.files(path, pattern = "*.csv", full.names = TRUE)
read_files <- lapply(ls_files, function(x) {
  read.csv(x)
})

#looking at data
#checking the column names of all files
col_names <- as.data.frame(sapply(1:length(read_files), function(x) {
  names(read_files[[x]])
})) 
sum(sapply(1:(length(col_names)-1), function (x) {
  identical(col_names[x], col_names[x+1])
})) #identical returns logical vector, sum returns 0
df <- data.frame()
df <- as.data.frame(sapply(1:12, function (x) {
  df <- rbind(df, read_files[x])
}))