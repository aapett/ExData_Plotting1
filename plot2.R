library(tidyverse);library(stringr);library(lubridate)
rm(list=ls())

#load data filter the dates of interest, and paste date and time variables together
data.power <- read_delim('../household_power_consumption.txt',delim = ';',na = '?',
                         col_types = cols(Date = col_character(),
                                          Time = col_character(),
                                          Global_active_power = col_number(),
                                          Global_reactive_power = col_number(),
                                          Voltage = col_number(),
                                          Global_intensity = col_number(),
                                          Sub_metering_1 = col_number(),
                                          Sub_metering_2 = col_number(),
                                          Sub_metering_3 = col_number())) %>% 
  filter(str_detect(Date,"^[12]{1}/2/2007")) %>% 
  mutate(datetime = dmy_hms(paste(Date,Time)))

#plot Global Active Power over time
plot(data.power$datetime,data.power$Global_active_power, type = 'l',xlab = '',ylab="Global Active Power (kilowatts)")

#save plot
dev.copy(png,file = "plot2.png")
dev.off()

