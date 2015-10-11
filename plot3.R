#make sure raw data is downloaded in working folder
library(dplyr)
project1 <- tbl_df(read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", na.strings = c("?", "")))

#fix formats for Dates and Times so that you can easily graph
project1$Date <- as.Date(project1$Date, format = "%d/%m/%Y")
#test formats
str(project1)

project1$timetemp <- paste(project1$Date, project1$Time)  
project1$Time <- strptime(project1$timetemp, format = "%Y-%m-%d %H:%M:%S")
#test formats and look at data
str(project1)
head(project1)
tail(project1)

#subset data for plots
clean_project <- subset(project1, Date == "2007-02-01" | Date == "2007-02-02")
dim(clean_project)
#[1] 2880   10

#code to write graph in directory as png, check by opening png externally
png("plot3.png", 480, 480, units = "px")
plot(clean_project$Time, clean_project$Sub_metering_1, type = "l", col = "black", 
	ylab = "Energy sub metering", xlab = "")
with(clean_project, lines(clean_project$Time, clean_project$Sub_metering_2, col = "red"))
with(clean_project, lines(clean_project$Time, clean_project$Sub_metering_3, col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", 
	"Sub_metering_2", "Sub_metering_3"))	
dev.off()