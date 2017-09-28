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

##Create 4 plots in the same image
par(mfcol = c(2,2))

#Plot Global active power over time
plot(data.power$datetime,data.power$Global_active_power, type = 'l',xlab = '',ylab="Global Active Power (kilowatts)")

#plot Energy sub metering over time, legend outline removed
plot(data.power$datetime,data.power$Sub_metering_1, type = 'n',xlab = '',ylab="Energy sub metering")
lines(data.power$datetime,data.power$Sub_metering_1)
lines(data.power$datetime,data.power$Sub_metering_2, col = 'red')
lines(data.power$datetime,data.power$Sub_metering_3, col = 'blue')
legend('topright',lty = c(1,1,1),col = c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),bty = 'n')

#Voltage over time
plot(data.power$datetime,data.power$Voltage,type = 'l',xlab = 'datetime',ylab = 'Voltage')

#Global reactive power over time
plot(data.power$datetime,data.power$Global_reactive_power,type = 'l',xlab = 'datetime',ylab = 'Global_reactive_power')


#save plot
dev.copy(png,file = "plot4.png")
dev.off()