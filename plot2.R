# This R script file is for generation of the plot 2.


# read files into R:

project <-read.csv('household_power_consumption.txt', sep=";")

# Subset only data from dates 2007-02-01 and 2007-02-02:

project2 <- project[ which(as.Date(project$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(project$Date, "%d/%m/%Y") == "2007-02-02"),]

# Remove records with missing values:

project3 <- project2[which(project2$Time != "?" &
                             project2$Global_active_power != "?" &
                             project2$Global_reactive_power != "?" &
                             project2$Voltage != "?" &
                             project2$Global_intensity != "?" &
                             project2$Sub_metering_1 != "?" &
                             project2$Sub_metering_2 != "?" &
                             project2$Sub_metering_3 != "?" ),]

# Combine the Date and the Time columns into a new column datatime:

project4 <- transform(project3,datetime = paste0(Date, ' ', Time))


# Define the graphics parameters:

par(mfrow = c(1,1))
par(mar = c(2,2,2,2))
par(oma=c(0.5,0.5,0.5,0.5))

# Define png file parameters:

png(filename = "plot2.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "white", res = NA, restoreConsole = TRUE)

# Plotting:


plot(strptime(project4$datetime, format = '%d/%m/%Y%H:%M:%S'), 
     as.numeric(as.character(project4$Global_active_power)),
     ylab='Global Active Power (kilowatts)', xlab = '', type ='o', pch= '.', cex.lab=0.9)


# Turn off the png graphic device:

dev.off()
