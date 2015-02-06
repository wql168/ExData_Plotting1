# This R script file is for generation of the plot 3.


# read files into R:

project <-read.csv('household_power_consumption.txt', sep=";")

# Subset only date from dates 2007-02-01 and 2007-02-02:

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

png(filename = "plot3.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "white", res = NA, restoreConsole = TRUE)

# Plotting:

# Plot the Sub_metering_1: 

plot(strptime(project4$datetime, format = '%d/%m/%Y%H:%M:%S'), 
     as.numeric(as.character(project4$Sub_metering_1)), ylim = c(1, 40),
     ylab='Energy sub metering', xlab = '', type ='o', pch= '.', cex.lab=0.9)

# Plot the Sub_metering_2: 

par(new=T)

plot(strptime(project4$datetime, format = '%d/%m/%Y%H:%M:%S'), 
     as.numeric(as.character(project4$Sub_metering_2)), ylim = c(1, 40), col = 'red',
     ylab='Energy sub metering', xlab = '', type ='o', pch= '.', cex.lab=0.9)

# Plot the Sub_metering_3: 

par(new=T)

plot(strptime(project4$datetime, format = '%d/%m/%Y%H:%M:%S'), 
     as.numeric(as.character(project4$Sub_metering_3)), ylim = c(1, 40), col = 'blue',
     ylab='Energy sub metering', xlab = '', type ='o', pch= '.', cex.lab=0.9)

# Add legends:

legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"), lwd=1, lty=c(1,1,1), 
        pch=c(NA,NA,NA), cex=1.2)


# Turn off the png graphice device:

dev.off()
