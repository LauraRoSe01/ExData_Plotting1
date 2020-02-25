
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
png(filename = "plot3.png")

plot(data_subset$Time_1, data_subset$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(data_subset$Time_1, data_subset$Sub_metering_2, col="red")
lines(data_subset$Time_1, data_subset$Sub_metering_3, col="blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       col = c("black", "red", "blue"),
       lty=1)

dev.off()