# This R script file is for generation of the plot 1.


# read files into R:

project <-read.csv('household_power_consumption.txt', sep=";")


# Subset only data from dates 2007-02-01 and 2007-02-02:

project2 <- project[ which(as.Date(project$Date, "%d/%m/%Y") == "2007-02-01" | as.Date(project$Date, "%d/%m/%Y") == "2007-02-02"),]

# May also use the following way:
# project2 <- rbind(subset(project, Date ==  '1/2/2007'), subset(project, Date == '2/2/2007'))

# nrow(project2)
# [1] 2880

# names(project2)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3" 

# Remove records with missing values:

project3 <- project2[which(project2$Time != "?" &
                             project2$Global_active_power != "?" &
                             project2$Global_reactive_power != "?" &
                             project2$Voltage != "?" &
                             project2$Global_intensity != "?" &
                             project2$Sub_metering_1 != "?" &
                             project2$Sub_metering_2 != "?" &
                             project2$Sub_metering_3 != "?" ),]

# No such rows found: 
# nrow(project3)
# [1] 2880

# Define the graphics parameters:

par(mfrow = c(1,1))
par(mar = c(4,2,2,2))
par(oma=c(0.5,0.5,0.5,0.5))

# Define png file parameters:

png(filename = "plot1.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "white", res = NA, restoreConsole = TRUE)

# Plotting:

hist(as.numeric(as.character(project3$Global_active_power)),
     xlab='Global Active Power (kilowatts)', 
     main = 'Global Active Power', col= 'red')

# Turn off the png graphic device:

dev.off()
