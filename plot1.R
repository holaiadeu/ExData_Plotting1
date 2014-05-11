#Data is read taking into account decimal separator, column classes and NA type
#Dataset is assumed to be present in the working directory
data = read.csv2("household_power_consumption.txt", dec=".",na.strings="?", 
                 colClasses=c(rep("character",2), rep("numeric",7)))

#data is filtered to take into account only the desired dates
data = data[data$Date %in% c("1/2/2007", "2/2/2007"),]

#dates and types are converted from 2 character columns to 1 single column of
#the appropriate date/time type
datesTime = strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")

#Date and Time columns are replaced by the new Date_Time column
data = cbind(datesTime,data[,3:9])
names(data)[1]="Date_Time"

#A .png file with the desired dimensions is opened
png(file="plot1.png", width=480, height=480, units="px")

#The desired histogram is plotted
with(data,hist(Global_active_power, col="red", main="Global Active Power", ylim=range(0,1200),xlab="Global Active Power (kilowatts)"))

#.png file is closed
dev.off()
