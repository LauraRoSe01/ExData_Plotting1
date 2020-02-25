
#read data, read first column as date and second as time
library(readr)
data_household_power <- read_delim("C:/Users/waws0/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", 
   ";", escape_double = FALSE, col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
   Time = col_time(format = "%H:%M:%S")), 
   trim_ws = TRUE)

#subset dates needed
data_subset <- subset(data_household_power, Date == "2007-02-01" | Date ==  "2007-02-02")

# check for missing values
sum(is.na(data_subset)) #no missing values

## add a column with dates and times together
data_subset$Time_1 <- paste(data_subset$Date, data_subset$Time, sep = " ")
library(lubridate)
data_subset$Time_1 <- ymd_hms(data_subset$Time_1)

#plot and save as .png
png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(data_subset$Time_1, data_subset$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (killowatts)",
     xlab= " ")

dev.off()