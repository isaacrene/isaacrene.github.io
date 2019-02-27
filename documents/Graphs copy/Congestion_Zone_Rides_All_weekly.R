rm(list = ls())    #delete objects
cat("\014")

library(forecast)
library(ISLR)
library(astsa)
library(forecast)
library(TSA)
library(xts)



yellow_path   = "/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/"

yellow_daily                <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
yellow_weekly               <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
yellow_monthly              <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_monthly_01-2017_to_06-2018.csv"        , header=TRUE)



yellow_congestion_daily     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
yellow_congestion_weekly    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
yellow_congestion_monthly   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_monthly_01-2017_to_06-2018.csv"        , header=TRUE)
# 
# yellow_congestion_daily_under_6     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_under_6_daily_01-2017_to_06-2018.csv"        , header=TRUE)
# yellow_congestion_weekly_under_6    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_under_6_weekly.csv"        , header=TRUE)
# yellow_congestion_monthly_under_6   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_under_6_monthly_01-2017_to_06-2018.csv"        , header=TRUE)
# 
# yellow_congestion_daily_under_8     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_under_8_daily_01-2017_to_06-2018.csv"        , header=TRUE)
# yellow_congestion_weekly_under_8    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/yellow_congestion_under_8_weekly.csv"        , header=TRUE)
# yellow_congestion_monthly_under_8   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Yellow_Taxi/historical_yellow_congestion_under_8_monthly_01-2017_to_06-2018.csv"        , header=TRUE)
# 


green_daily                <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
green_weekly               <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
green_monthly              <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_monthly.csv"        , header=TRUE)


green_congestion_daily     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
green_congestion_weekly    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
green_congestion_monthly   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_monthly_01-2017_to_06-2018.csv"        , header=TRUE)

# green_congestion_daily_under_6     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_under_6_daily_01-2017_to_06-2018.csv"        , header=TRUE)
# green_congestion_weekly_under_6    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_under_6_weekly.csv"        , header=TRUE)
# green_congestion_monthly_under_6   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_under_6_monthly_01-2017_to_06-2018.csv"        , header=TRUE)
# 
# green_congestion_daily_under_8     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_under_8_daily_01-2017_to_06-2018.csv"        , header=TRUE)
# green_congestion_weekly_under_8    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/green_congestion_under_8_weekly.csv"        , header=TRUE)
# green_congestion_monthly_under_8   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/Green_Taxi/historical_green_congestion_under_8_monthly_01-2017_to_06-2018.csv"        , header=TRUE)
# 


uber_daily                <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA))
uber_weekly               <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
uber_monthly              <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_monthly.csv"        , header=TRUE)


uber_congestion_daily     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_congestion_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA))
uber_congestion_weekly    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_congestion_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
uber_congestion_monthly   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/uber_congestion_monthly_01-2017_to_06-2018.csv"        , header=TRUE)


lyft_daily                <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA))
lyft_weekly               <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
lyft_monthly              <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_monthly.csv"        , header=TRUE)


lyft_congestion_daily     <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_congestion_daily_01-2017_to_06-2018.csv"        , header=TRUE, colClasses=c("Date",NA))
lyft_congestion_weekly    <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_congestion_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
lyft_congestion_monthly   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/NProcessed/FHV/lyft_congestion_monthly_01-2017_to_06-2018.csv"        , header=TRUE)






###### Prepare Data (in thousands) ######



yellow_daily$rides   =    yellow_daily$rides/1000
yellow_weekly$rides  =    yellow_weekly$rides/1000000
yellow_monthly$rides =    yellow_monthly$rides/1000000



yellow_congestion_daily$rides   = yellow_congestion_daily$rides/1000
yellow_congestion_weekly$rides  = yellow_congestion_weekly$rides/1000000
yellow_congestion_monthly$rides = yellow_congestion_monthly$rides/1000000



green_daily$rides     =    green_daily$rides/1000  
green_weekly$rides    =    green_weekly$rides/1000000     
green_monthly$rides   =    green_monthly$rides/1000000


green_congestion_daily$rides       =    green_congestion_daily$rides/1000 
green_congestion_weekly$rides      =    green_congestion_weekly$rides/1000000 
green_congestion_monthly$rides     =    green_congestion_monthly$rides/1000000


uber_daily$rides       =    uber_daily$rides/1000 
uber_weekly$rides      =    uber_weekly$rides/1000000 
uber_monthly$rides     =    uber_monthly$rides/1000000 


uber_congestion_daily$rides         =    uber_congestion_daily$rides/1000 
uber_congestion_weekly$rides        =    uber_congestion_weekly$rides/1000000 
uber_congestion_monthly$rides       =    uber_congestion_monthly$rides/1000000


lyft_daily$rides           =    lyft_daily$rides/1000 
lyft_weekly$rides          =    lyft_weekly$rides/1000000 
lyft_monthly$rides         =    lyft_monthly$rides/1000000


lyft_congestion_daily$rides        =    lyft_congestion_daily$rides/1000
lyft_congestion_weekly$rides       =    lyft_congestion_weekly$rides/1000000
lyft_congestion_monthly$rides      =    lyft_congestion_monthly$rides/1000000
















#===============================================#
######### Exploratory Data Analysis #############
#===============================================#

##=====================##
## Weekly the Data ##
##=====================##

y_lower_limit = min(yellow_weekly$rides, uber_weekly$rides) 

y_upper_limit = max(yellow_weekly$rides, uber_weekly$rides) 

x_lower_limit = min(yellow_weekly$period_end, uber_weekly$period_end)
  
x_upper_limit = max(yellow_weekly$period_end, uber_weekly$period_end)


par (  mar=c(7 ,5 ,1 ,1) )
plot(((yellow_weekly$rides+green_weekly$rides)~yellow_weekly$period_end), col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Week (millions)",xlab= '',cex=.7)
lines(uber_weekly$period_end,uber_weekly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)




xtick = seq(min(as.Date(yellow_weekly$period_end)), max(as.Date(yellow_weekly$period_end)), by=7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)

xtick = seq(x_lower_limit, x_upper_limit, by=28)

# axis(1, xtick, format(xtick, '%d %b %y'), cex.axis = 1, at = xtick,las =2)

axis.Date(1, xtick, format= '%d %b %Y', cex.axis = 1, at = xtick,las =2)


ytick = seq(round(y_lower_limit), round(y_upper_limit), by=.1)

axis(2, ytick, cex.axis = 1, at = ytick,las =2)

abline(h=ytick,col="grey", lty=1,lwd = 0.3)

# legend(x_upper_limit-92,y_lower_limit+.13, legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2))

legend("topleft",  legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=15)




##=====================##
## Monthly Data ##
##=====================##


xtick  = seq(as.Date("2017/1/1"), as.Date("2018/6/1"), "months")

y_lower_limit = min(yellow_monthly$rides, uber_monthly$rides) -.1

y_upper_limit = max(yellow_monthly$rides, uber_monthly$rides) + .1

x_lower_limit = min(xtick)

x_upper_limit = max(xtick)


par (  mar=c(5 ,5 ,1 ,1) )
plot((yellow_monthly$rides+green_monthly$rides)~xtick, col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Month (millions)",xlab= '',cex=.7)
lines(xtick,uber_monthly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)



abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)


axis.Date(1, xtick, format= "%Y-%h", cex.axis = 1, at = xtick,las =2)

ytick = seq(round(y_lower_limit), round(y_upper_limit), by=.5)

axis(2, ytick, format(ytick, big.mark=",",scientific=FALSE), cex.axis = 1, at = ytick,las =2 )

abline(h=ytick,col="grey", lty=1,lwd = 0.3 )

# legend(x_upper_limit-90,y_lower_limit+.6, legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2))

legend("topleft",  legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=15)










##=============================##
## Weekly Congestion Zone Data ##
##=============================##

y_lower_limit = min(yellow_congestion_weekly$rides, uber_congestion_weekly$rides) 

y_upper_limit = max(yellow_congestion_weekly$rides, uber_congestion_weekly$rides) + .05

x_lower_limit = min(yellow_congestion_weekly$period_end, uber_congestion_weekly$period_end)

x_upper_limit = max(yellow_congestion_weekly$period_end, uber_congestion_weekly$period_end)


par (  mar=c(7 ,5 ,1 ,1) )
plot(((yellow_congestion_weekly$rides+green_congestion_weekly$rides)~yellow_congestion_weekly$period_end), col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Week (millions)",xlab= '',cex=.7, main = "Congestion Zone Rides")
lines(uber_congestion_weekly$period_end,uber_congestion_weekly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)




xtick = seq(min(as.Date(yellow_congestion_weekly$period_end)), max(as.Date(yellow_congestion_weekly$period_end)), by=7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)

xtick = seq(x_lower_limit, x_upper_limit, by=28)

# axis(1, xtick, format(xtick, '%d %b %y'), cex.axis = 1, at = xtick,las =2)

axis.Date(1, xtick, format= '%d %b %Y', cex.axis = 1, at = xtick,las =2)


ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.1)

axis(2, ytick, cex.axis = 1, at = ytick,las =2)

abline(h=ytick,col="grey", lty=1,lwd = 0.3)

# legend(x_upper_limit-92,y_lower_limit+.13, legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2))


legend("topright",  legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=15)














##================================##
##    Monthly Congestion Data     ##
##================================##


xtick  = seq(as.Date("2017/1/1"), as.Date("2018/6/1"), "months")

y_lower_limit = min(yellow_congestion_monthly$rides, uber_congestion_monthly$rides) 

y_upper_limit = max(yellow_congestion_monthly$rides, uber_congestion_monthly$rides) + .2

x_lower_limit = min(xtick)

x_upper_limit = max(xtick)


par (  mar=c(5 ,5 ,1 ,1) )
plot((yellow_congestion_monthly$rides+green_congestion_monthly$rides)~xtick, col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Month (millions)",xlab= '',cex=.7, main = "Congestion Zone Rides")
lines(xtick,uber_congestion_monthly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)



abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)


axis.Date(1, xtick, format= "%Y-%h", cex.axis = 1, at = xtick,las =2)

ytick = seq(round(y_lower_limit), round(y_upper_limit), by=.5)

axis(2, ytick, format(ytick, big.mark=",",scientific=FALSE), cex.axis = 1, at = ytick,las =2 )

abline(h=ytick,col="grey", lty=1,lwd = 0.3 )

# legend(x_upper_limit-90,y_lower_limit+.6, legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2))



legend("topright",  legend= c('Uber', 'Taxis'), lty=1,col=c('blue','goldenrod'), pch = c(1,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=15)





#====================#
### Full Data Set  ###
#====================#







yellow_weekly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Yellow_Taxi/yellow_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
yellow_monthly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Yellow_Taxi/yellow_monthly_01-2015_to_06-2018.csv"        , header=TRUE)


green_weekly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Green_Taxi/green_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA,NA,NA,NA,NA,NA,NA,NA,NA))
green_monthly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Green_Taxi/green_monthly.csv"        , header=TRUE)


uber_weekly        <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/uber_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
uber_monthly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/uber_monthly.csv"        , header=TRUE)

lyft_weekly        <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/lyft_weekly.csv"        , header=TRUE, colClasses=c("Date","Date",NA))
lyft_monthly       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/lyft_monthly.csv"        , header=TRUE)






###### Prepare Data (in thousands) ######



yellow_weekly$rides  =    yellow_weekly$rides/1000000
yellow_monthly$rides =    yellow_monthly$rides/1000000

green_weekly$rides    =    green_weekly$rides/1000000     
green_monthly$rides   =    green_monthly$rides/1000000

uber_weekly$rides      =    uber_weekly$rides/1000000 
uber_monthly$rides     =    uber_monthly$rides/1000000 

lyft_weekly$rides          =    lyft_weekly$rides/1000000 
lyft_monthly$rides         =    lyft_monthly$rides/1000000





##=====================##
## Weekly the Data ##
##=====================##

y_lower_limit = min(yellow_weekly$rides, uber_weekly$rides, lyft_weekly$rides ) -.10

y_upper_limit = max(yellow_weekly$rides+green_weekly$rides, uber_weekly$rides) 

x_lower_limit = min(yellow_weekly$period_end, uber_weekly$period_end)

x_upper_limit = max(yellow_weekly$period_end, uber_weekly$period_end)


par (  mar=c(7 ,5 ,1 ,1) )
plot(((yellow_weekly$rides+green_weekly$rides)~yellow_weekly$period_end), col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Week (millions)",xlab= '',cex=.7, main ='FULL')
lines(uber_weekly$period_end,uber_weekly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)


lines(yellow_weekly$period_end,c(rep(NA,13),lyft_weekly$rides),col = c('red'),type = 'o', pch = 2,cex=.7)


xtick = seq(min(as.Date(yellow_weekly$period_end)), max(as.Date(yellow_weekly$period_end)), by=7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)

xtick = seq(x_lower_limit, x_upper_limit, by=28)

# axis(1, xtick, format(xtick, '%d %b %y'), cex.axis = 1, at = xtick,las =2)

axis.Date(1, xtick, format= '%d %b %Y', cex.axis = 1, at = xtick,las =2)


ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.1)

axis(2, ytick, cex.axis = 1, at = ytick,las =2)

abline(h=ytick,col="grey", lty=1,lwd = 0.3)



# legend(x_upper_limit-200,y_lower_limit+.3, legend= c('Uber', 'Taxis', "Lyft"), lty=1,col=c('blue','goldenrod','red'), pch = c(1,2,5),cex = .9)

legend("topright",  legend= c('Uber', 'Taxis','Lyft'), lty=1,col=c('blue','goldenrod','red'), pch = c(1,2,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=50)




##=====================##
## Monthly Data ##
##=====================##


xtick  = seq(as.Date("2015/1/1"), as.Date("2018/6/1"), "months")

y_lower_limit = min(yellow_monthly$rides, uber_monthly$rides,lyft_monthly$rides) 

y_upper_limit = max(yellow_monthly$rides, uber_monthly$rides) + 1.5

x_lower_limit = min(xtick)

x_upper_limit = max(xtick)


par (  mar=c(5 ,5 ,1 ,1) )
plot((yellow_monthly$rides+green_monthly$rides)~xtick, col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Month (millions)",xlab= '',cex=.7, main ='FULL')
lines(xtick,uber_monthly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)

lines(xtick,c(rep(NA,3),lyft_monthly$rides),col = c('red'),type = 'o', pch = 2,cex=.7)


abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)


axis.Date(1, xtick, format= "%Y-%h", cex.axis = 1, at = xtick,las =2)

ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.5)

axis(2, ytick, format(ytick, big.mark=",",scientific=FALSE), cex.axis = 1, at = ytick,las =2 )

abline(h=ytick,col="grey", lty=1,lwd = 0.3 )

# legend(x_upper_limit-200,y_lower_limit+1.5, legend= c('Uber', 'Taxis','Lyft'), lty=1,col=c('blue','goldenrod'), pch = c(1,2,2), cex =.9)


legend("topright",  legend= c('Uber', 'Taxis','Lyft'), lty=1,col=c('blue','goldenrod','red'), pch = c(1,2,2), cex =.9,y.intersp = 0.7,x.intersp = 0.3,text.width=50)















#All with Lyft + Uber



##=====================##
## Weekly the Data ##
##=====================##


lyft_weekly_appended = c(rep(0,13),lyft_weekly$rides)

uber_and_lyft_weekly = (uber_weekly$rides+lyft_weekly_appended)

y_lower_limit = min(yellow_weekly$rides, uber_and_lyft_weekly,lyft_weekly$rides ) -.10

y_upper_limit = max(yellow_weekly$rides+green_weekly$rides, uber_and_lyft_weekly) 

x_lower_limit = min(yellow_weekly$period_end, uber_weekly$period_end)

x_upper_limit = max(yellow_weekly$period_end, uber_weekly$period_end)


par (  mar=c(7 ,5 ,1 ,1) )
plot(((yellow_weekly$rides+green_weekly$rides)~yellow_weekly$period_end), col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Week (millions)",xlab= '',cex=.7, main ='FULL')


lines(uber_weekly$period_end,uber_and_lyft_weekly,col = c('gray8'),type = 'o', pch = 5,cex=.7)

lines(uber_weekly$period_end,uber_weekly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)


lines(yellow_weekly$period_end,c(rep(NA,13),lyft_weekly$rides),col = c('red'),type = 'o', pch = 2,cex=.7)


xtick = seq(min(as.Date(yellow_weekly$period_end)), max(as.Date(yellow_weekly$period_end)), by=7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)

xtick = seq(x_lower_limit, x_upper_limit, by=28)

# axis(1, xtick, format(xtick, '%d %b %y'), cex.axis = 1, at = xtick,las =2)

axis.Date(1, xtick, format= '%d %b %Y', cex.axis = 1, at = xtick,las =2)


ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.1)

axis(2, ytick, cex.axis = 1, at = ytick,las =2)

abline(h=ytick,col="grey", lty=1,lwd = 0.3)



# legend(x_upper_limit-270,y_lower_limit+.4, legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),cex = .8)

legend("topleft", legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),y.intersp = 0.7,x.intersp = 0.3,cex = .8,text.width=50)



##=====================##
##     Monthly Data    ##
##=====================##


lyft_monthly_appended = c(rep(0,3),lyft_monthly$rides)

uber_and_lyft_monthly = (uber_monthly$rides+lyft_monthly_appended)

xtick  = seq(as.Date("2015/1/1"), as.Date("2018/6/1"), "months")

y_lower_limit = min(yellow_monthly$rides, uber_monthly$rides,lyft_monthly$rides) 

y_upper_limit = max(yellow_monthly$rides, uber_monthly$rides,uber_and_lyft_monthly ) +.5

x_lower_limit = min(xtick)

x_upper_limit = max(xtick)


par (  mar=c(5 ,5 ,1 ,1) )
plot((yellow_monthly$rides+green_monthly$rides)~xtick, col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Month (millions)",xlab= '',cex=.7, main ='FULL')
lines(xtick,uber_monthly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)

lines(xtick,c(rep(NA,3),lyft_monthly$rides),col = c('red'),type = 'o', pch = 2,cex=.7)

lines(xtick,uber_and_lyft_monthly,col = c('gray8'),type = 'o', pch = 5,cex=.7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)


axis.Date(1, xtick, format= "%Y-%h", cex.axis = 1, at = xtick,las =2)

ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.5)

axis(2, ytick, format(ytick, big.mark=",",scientific=FALSE), cex.axis = 1, at = ytick,las =2 )

abline(h=ytick,col="grey", lty=1,lwd = 0.3 )

# legend(x_upper_limit-120,y_lower_limit+1.8, legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),cex = .8)

legend("topleft", legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),y.intersp = 0.7,x.intersp = 0.3,cex = .8,text.width=50)






















##=============================##
## Weekly Congestion Zone Data ##
##=============================##



uber_and_lyft_weekly = (uber_congestion_weekly$rides+lyft_congestion_weekly$rides)

y_lower_limit = min(yellow_congestion_weekly$rides, uber_congestion_weekly$rides, lyft_congestion_weekly$rides) 

y_upper_limit = max(yellow_congestion_weekly$rides, uber_congestion_weekly$rides, uber_and_lyft_weekly ) + .10

x_lower_limit = min(yellow_congestion_weekly$period_end, uber_congestion_weekly$period_end)

x_upper_limit = max(yellow_congestion_weekly$period_end, uber_congestion_weekly$period_end)


par (  mar=c(7 ,5 ,1 ,1) )
plot(((yellow_congestion_weekly$rides+green_congestion_weekly$rides)~yellow_congestion_weekly$period_end), col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Week (millions)",xlab= '',cex=.7, main = "Congestion Zone Rides")
lines(uber_congestion_weekly$period_end,uber_congestion_weekly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)
lines(lyft_congestion_weekly$period_end,lyft_congestion_weekly$rides,col = c('red'),type = 'o', pch = 2,cex=.7)

lines(lyft_congestion_weekly$period_end,uber_and_lyft_weekly,col = c('gray8'),type = 'o', pch = 1,cex=.7)




xtick = seq(min(as.Date(yellow_congestion_weekly$period_end)), max(as.Date(yellow_congestion_weekly$period_end)), by=7)

abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)

xtick = seq(x_lower_limit, x_upper_limit, by=28)

# axis(1, xtick, format(xtick, '%d %b %y'), cex.axis = 1, at = xtick,las =2)

axis.Date(1, xtick, format= '%d %b %Y', cex.axis = 1, at = xtick,las =2)


ytick = seq(floor(y_lower_limit), ceiling(y_upper_limit), by=.1)

axis(2, ytick, cex.axis = 1, at = ytick,las =2)

abline(h=ytick,col="grey", lty=1,lwd = 0.3)

# legend(x_upper_limit-65,y_upper_limit+.07, legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),cex = .5)




legend("topright", legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),y.intersp = 0.7,x.intersp = 0.3,cex = .8,text.width=30)















##================================##
##    Monthly Congestion Data     ##
##================================##



uber_and_lyft_monthly = (uber_congestion_monthly$rides+lyft_congestion_monthly$rides)

y_lower_limit = min(yellow_congestion_monthly$rides, uber_congestion_monthly$rides, lyft_congestion_monthly$rides) -1


xtick  = seq(as.Date("2017/1/1"), as.Date("2018/6/1"), "months")


y_upper_limit = max(yellow_congestion_monthly$rides, uber_congestion_monthly$rides) + 1

x_lower_limit = min(xtick)

x_upper_limit = max(xtick)


par (  mar=c(5 ,5 ,1 ,1) )
plot((yellow_congestion_monthly$rides+green_congestion_monthly$rides)~xtick, col = 'goldenrod', ylim= c(y_lower_limit,y_upper_limit), xaxt='n',yaxt='n',type = 'o', pch = 2, ylab= "Rides Per Month (millions)",xlab= '',cex=.7, main = "Congestion Zone Rides")
lines(xtick,uber_congestion_monthly$rides,col = c('blue'),type = 'o', pch = 1,cex=.7)

lines(xtick,uber_and_lyft_monthly,col = c('gray8'),type = 'o', pch = 5,cex=.7)

lines(xtick,lyft_congestion_monthly$rides,col = c('red'),type = 'o', pch = 2,cex=.7)


abline(v=xtick,col="grey50", lty='dotted',lwd = 0.3)


axis.Date(1, xtick, format= "%Y-%h", cex.axis = 1, at = xtick,las =2)

ytick = seq(round(y_lower_limit), round(y_upper_limit), by=.5)

axis(2, ytick, format(ytick, big.mark=",",scientific=FALSE), cex.axis = 1, at = ytick,las =2 )

abline(h=ytick,col="grey", lty=1,lwd = 0.3 )

# legend(x_upper_limit-105,y_lower_limit+1.1, legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),cex = .8)

legend("topright", legend= c('Uber & Lyft','Uber','Lyft', 'Taxis'), lty=1,col=c('gray8','blue','red','goldenrod'), pch = c(5,1,2,2),y.intersp = 0.7,x.intersp = 0.3,cex = .8,text.width=30)






sum(yellow_congestion_weekly$rides)/sum(yellow_weekly$rides[-78])



sum(uber_congestion_weekly$rides)/sum(uber_weekly$rides[-78])

sum(green_congestion_weekly$rides)/sum((yellow_congestion_weekly$rides+green_congestion_weekly$rides))

mean(green_congestion_weekly$rides/green_weekly$rides[-78])
