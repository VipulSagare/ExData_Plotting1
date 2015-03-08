plot3 <- function() {
  
  ## read the data
  ## File name
  filename<-"./exdata-data-household_power_consumption/household_power_consumption.txt"
  if(!file.exists(filename)){
    cat("File could not locate")
    return
  }
  ## Read file
  power <- read.table(filename, header=T, sep=";")
  ## Format the date
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  ## Get date for 2 days which was asked.
  df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  ##release memory as we do not need variable "power"
  power<-"clean"
  ## Get data for plot
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
  df$Voltage <- as.numeric(as.character(df$Voltage))
  df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
  df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
  df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
  df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
  ##
  
  
  ## draw plot
  plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  ## Add other 2 data points with different colors
  lines(df$timestamp,df$Sub_metering_2,col="red")
  lines(df$timestamp,df$Sub_metering_3,col="blue")
  ## Legend in the top right corner
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
         
  ##write it to PNG file
  dev.copy(png, file="plot3.png", width=480, height=480)
  ## make sure you close the write pipe
  dev.off()
  ## let the user know the location.
  cat("Plot3.png saved in the directory", getwd())
}