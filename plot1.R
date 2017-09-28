library(tidyverse);library(stringr);library(png)
rm(list=ls())

#load data and filter the dates of interest
data.power <- read_delim('../household_power_consumption.txt',delim = ';',na = '?',col_types = cols(Date = col_date(format = "%d/%m/%Y"),
                                                                                       Time = col_time(format = ""),
                                                                                       Global_active_power = col_number(),
                                                                                       Global_reactive_power = col_number(),
                                                                                       Voltage = col_number(),
                                                                                       Global_intensity = col_number(),
                                                                                       Sub_metering_1 = col_number(),
                                                                                       Sub_metering_2 = col_number(),
                                                                                       Sub_metering_3 = col_number())) %>% 
  filter(Date >= "2007-02-01", Date <= "2007-02-02")

#create histogram of Global Active Power
png('plot1.png',width = 480,height = 480)
hist(data.power$Global_active_power, col = "Red", main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()

