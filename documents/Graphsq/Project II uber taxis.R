rm(list = ls())    #delete objects
cat("\014")

library(forecast)
library(ISLR)
library(astsa)
library(forecast)
library(TSA)
library(xts)



yellow_rides_per_day         <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Yellow_Taxi/historical_yellow.csv"        , header=TRUE)
yellow_rides_per_week       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Yellow_Taxi/weekly_rides_yellow_2018.csv"        , header=TRUE)
yellow_rides_per_month       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Yellow_Taxi/monthly_yellow.csv"        , header=TRUE)


green_rides_per_day         <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Green_Taxi/historical_green.csv"        , header=TRUE)
green_rides_per_week       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Green_Taxi/weekly_rides_green_2018.csv"        , header=TRUE)
green_rides_per_month       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/Green_Taxi/monthly_green.csv"        , header=TRUE)


uber_rides_per_day         <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/historical_uber.csv"        , header=TRUE)
uber_rides_per_week        <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/weekly_rides_uber.csv"        , header=TRUE)
uber_rides_per_month       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/monthly_uber_new.csv"        , header=TRUE)

lyft_rides_per_day         <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/historical_lyft.csv"        , header=TRUE)
lyft_rides_per_week        <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/weekly_rides_lyft.csv"        , header=TRUE)
lyft_rides_per_month       <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/monthly_Lyft_new.csv"        , header=TRUE)

x_labels                   <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Labels/date_labels_forecast.csv"        , header=FALSE)
x_labels               = x_labels[,]



###### Prepare Data (in thousands) ######


taxis_per_day   = (yellow_rides_per_day['rides'] + green_rides_per_day['rides'])[,]
ubers_per_day     = (uber_rides_per_day['rides'])[,]


taxis_per_week   =  (yellow_rides_per_week['rides'] + green_rides_per_week['rides'])[,]
ubers_per_week    =  (uber_rides_per_week['rides'])[,]

taxis_per_month   =  (yellow_rides_per_month['rides'] + green_rides_per_month['rides'])[,]
ubers_per_month    =  (uber_rides_per_month['rides'])[,]






taxis_per_day     = taxis_per_day/1000
ubers_per_day     = ubers_per_day/1000

taxis_per_week    =  taxis_per_week/1000
ubers_per_week    =  ubers_per_week/1000

taxis_per_month    =  taxis_per_month/1000000
ubers_per_month    =  ubers_per_month/1000000




plot(ubers_per_day, taxis_per_day,main = 'Scatterplot matrix: Taxis and Uber Rides Per Day', ylab = 'Taxis per day (thousands)',xlab = 'Ubers per day (thousands)')

plot(ubers_per_week, taxis_per_week,main = 'Scatterplot matrix: Taxis and Uber Rides Per Week', ylab = 'Taxis per week (thousands)',xlab = 'Ubers per week (thousands)')





##### Transform into Time Series ######

taxis_per_day     = ts(taxis_per_day)
ubers_per_day     = ts(ubers_per_day)

taxis_per_week    =  ts(taxis_per_week)
ubers_per_week    =  ts(ubers_per_week)

taxis_per_month    =  ts(taxis_per_month)
ubers_per_month    =  ts(ubers_per_month)










########       ACFs               #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(trans.taxis_per_month           , lag.max = 275 , main = "ACF of (Weekly Uber Rides)^2"             )
acf(diff(trans.taxis_per_month)     , lag.max = 275 , main = "ACF of differenced (Weekly Uber Rides)^2" )
acf(lag.sqrt.ubers_per_week       , lag.max = 275 , main = "ACF of lag differenced (Weekly Uber Rides)^2" )

########       PACFs             #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(trans.ubers_per_month           , lag.max = 275 , main = "PACF of (Weekly Uber Rides)^2"             )
acf(diff(trans.ubers_per_month)      , lag.max = 275 , main = "PACF of differenced (Weekly Uber Rides)^2" )
pacf(lag.sqrt.ubers_per_week       , lag.max = 275 , main = "PACF of lag differenced (Weekly Uber Rides)^2" )


























#===============================================#
######### Exploratory Data Analysis #############
#===============================================#

##=====================##
## First Plot the Data ##
##=====================##




plot.ts(taxis_per_month, col = 'blue', ylim= c(min(ubers_per_month),max(taxis_per_month)), ylab= "Rides Per Month (millions)",xlab= '')
lines(ubers_per_month)


 x_labels_every_seven   = data.frame(x_labels)[seq(from = 1, to = length(ubers_per_week), by = 6),]
 
 


 par (  mar=c(5 ,5 ,1 ,1) )
 plot.ts(ubers_per_week, col = 'blue', ylim= c(min(ubers_per_week),max(taxis_per_week)), xaxt='n',type = 'o', ylab= "Rides Per Week (thousands)",xlab= '',cex=.7)
 lines(taxis_per_week,col = c('goldenrod'),type = 'o', pch = 2,cex=.7)
 abline(v=seq(1,200,6),col="grey50",lwd = 0.3)
 box()
 axis(1, labels= x_labels_every_seven, at=seq(from = 1, by=6, to=length(ubers_per_week)) ,las = 2)
 legend(155, 500, legend=c('Ubers',"Taxis"), col=c("blue", "goldenrod"), lty=c(1,1),pch = c(1,2), cex=0.8)



#      ACF non-transformed data        #
par ( mfrow=c(4 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(taxis_per_month   , lag.max = 275 , main = "Monthly Taxi Rides"  )
pacf(taxis_per_month   , lag.max = 275 , main = "PACF of Monthly Taxi Rides"  )

#      PACF non-transformed data        #

# par ( mfrow=c(2 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(ubers_per_month   , lag.max = 275 , main = "Monthly Uber Rides"  )
pacf(ubers_per_month   , lag.max = 275 , main = "PACF of Monthly Uber Rides"  )




#===============================================#
## Variance Stabilization by log transformation##
#===============================================#

BoxCox.lambda(taxis_per_month)
BoxCox.lambda(ubers_per_month)

nsqrt.taxis_per_month = (taxis_per_month)^(-1/2)
sqrt.ubers_per_month = sqrt(ubers_per_month)


plot.ts(nsqrt.taxis_per_month)
plot.ts(sqrt.ubers_per_month)


##=========================================================##
##             Estimate and Eliminate the Trend            ##
##=========================================================##

#~~~~~~~~~~~~~~~~~~~~~    TAXIS   ~~~~~~~~~~~~~~~~~~~~~~~~~~#

#####          Diferenced Sqrt Data 1        ############
diff.nsqrt.taxis_per_month = diff(nsqrt.taxis_per_month)

#####  Seasonal Difference diff(Sqrt Data 1) ############

lag.nsqrt.taxis_per_month = diff(diff.nsqrt.taxis_per_month,12)


#####  Plot Differences ############

par ( mfrow =c(3 ,1), mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
plot(nsqrt.taxis_per_month       ,main="(Monthly Taxi Rides)^2")
plot(diff.nsqrt.taxis_per_month  ,main="Differenced (Monthly Taxi Rides)^2")
plot(lag.nsqrt.taxis_per_month   ,main="lag Differenced sqrt(Monthly Taxi Rides)")


########       ACFs               #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(nsqrt.taxis_per_month             , lag.max = 275 , main = "ACF of (Monthly Taxi Rides)^(-1/2)"             )
acf(diff.nsqrt.taxis_per_month        , lag.max = 275 , main = "ACF of differenced (Monthly Taxi Rides)^(-1/2)" )
acf(lag.nsqrt.taxis_per_month         , lag.max = 275 , main = "ACF of lag differenced (Monthly Taxi Rides)^(-1/2)" )

########       PACFs             #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
pacf(nsqrt.taxis_per_month           , lag.max = 275 , main = "PACF of (Monthly Rides)^(-1/2)"             )
pacf(diff.nsqrt.taxis_per_month      , lag.max = 275 , main = "PACF of differenced (Monthly Rides)^(-1/2)" )
pacf(lag.nsqrt.taxis_per_month       , lag.max = 275 , main = "PACF of lag differenced (Monthly Rides)^(-1/2)" )



#~~~~~~~~~~~~~~~~~~~~~    UBERS   ~~~~~~~~~~~~~~~~~~~~~~~~~~#

#####          Diferenced Sqrt Data 1        ############
diff.sqrt.ubers_per_month = diff(sqrt.ubers_per_month)

#####  Seasonal Difference diff(Sqrt Data 1) ############

lag.sqrt.ubers_per_month = diff(diff.sqrt.ubers_per_month,12)


#####  Plot Differences ############

par ( mfrow =c(3 ,1), mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
plot(sqrt.ubers_per_month       , main="(Weekly Uber Rides)^2")
plot(diff.sqrt.ubers_per_month  , main="Differenced (Weekly Uber Rides)^2")
plot(lag.sqrt.ubers_per_month   , main="lag Differenced sqrt(Weekly Uber Rides)")


########       ACFs               #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(sqrt.ubers_per_month           , lag.max = 275 , main = "ACF of sqrt(Month Uber Rides)"             )
acf(diff.sqrt.ubers_per_month      , lag.max = 275 , main = "ACF of differenced sqrt(Month Uber Rides)" )
acf(lag.sqrt.ubers_per_month       , lag.max = 275 , main = "ACF of lag differenced sqrt(Month Uber Rides)" )

########       PACFs             #########

par ( mfrow=c(3 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
pacf(sqrt.ubers_per_month           , lag.max = 275 , main = "PACF of sqrt(Month Uber Rides)"             )
pacf(diff.sqrt.ubers_per_month      , lag.max = 275 , main = "PACF of differenced sqrt(Month Uber Rides)" )
pacf(lag.sqrt.ubers_per_month       , lag.max = 275 , main = "PACF of lag differenced sqrt(Month Uber Rides)" )





# The seasonality might not be so apararent form simply looking at the graphs ##

# However it becomes a little more apparent when we split the data in years by weeks [1:52], [53:104], [105:156]
# and center them at zero by subtracting their mean

taxis_per_month_2015 = taxis_per_month[1:12]
taxis_per_month_2016 = taxis_per_month[13:24]
taxis_per_month_2017 = taxis_per_month[25:36]


taxis_per_month_2015 = ts(taxis_per_month_2015 - mean(taxis_per_month_2015))
taxis_per_month_2016 = ts(taxis_per_month_2016 - mean(taxis_per_month_2016))
taxis_per_month_2017 = ts(taxis_per_month_2017 - mean(taxis_per_month_2017))


plot(taxis_per_month_2015)
lines(taxis_per_month_2016, col = 'blue')
lines(taxis_per_month_2017, col = 'goldenrod')



ubers_per_month_2015 = ubers_per_month[1:12]
ubers_per_month_2016 = ubers_per_month[13:24]
ubers_per_month_2017 = ubers_per_month[25:36]


ubers_per_month_2015 = ts(ubers_per_month_2015 - mean(ubers_per_month_2015))
ubers_per_month_2016 = ts(ubers_per_month_2016 - mean(ubers_per_month_2016))
ubers_per_month_2017 = ts(ubers_per_month_2017 - mean(ubers_per_month_2017))


plot(ubers_per_month_2015)
lines(ubers_per_month_2016, col = 'blue')
lines(ubers_per_month_2017, col = 'goldenrod')




#Summary ACF PACF ##

########       Taxis               #########

par ( mfrow=c(4 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(diff.nsqrt.taxis_per_month    , lag.max = 275 , main = "Differenced (Monthly Taxi Rides)^(-1/2)" )
pacf(diff.nsqrt.taxis_per_month  , lag.max = 275 , main = "PACF of differenced (Monthly Taxi Rides)^(-1/2)" )


########       Ubers               #########

# par ( mfrow=c(2 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(diff.sqrt.ubers_per_month        , lag.max = 275 , main = "Differenced (Monthly Uber Rides)^(1/2)" )
pacf(diff.sqrt.ubers_per_month       , lag.max = 275 , main = "PACF of differenced (Monthly Uber Rides)^(1/2)" )











########       Taxis               #########

par ( mfrow=c(4 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(lag.nsqrt.taxis_per_month    , lag.max = 275 , main = "lag differenced (Monthly Taxi Rides)^(-1/2)" )
pacf(lag.nsqrt.taxis_per_month  , lag.max = 275 , main = "ACF of lag differenced sqrt(Monthly Rides)^(1/2)" )


########       Ubers               #########

# par ( mfrow=c(2 ,1) , mar=c(3 ,3 ,1 ,1) , mgp=c (1.6 ,.6 ,0) )
acf(lag.sqrt.ubers_per_month        , lag.max = 275 , main = "lag differenced (Monthly Uber Rides)^(1/2)" )
pacf(lag.sqrt.ubers_per_month       , lag.max = 275 , main = "PACF of lag differenced (Monthly Uber Rides)^2" )


##        Observations   & Candidate Models        ##


#there seems to be an interaction term for the values that are near the seasonality tend to increase.


#The analysis of the PACF of the differenced data

# The data appears to show signs of seasonality around the week 52. The seasonality doesn't seem to run long term, it's weak, for there are only significnt
# spikes in the ACF at lag ~ 52

# using s = 52

# For Ubers:
# We can see at seasonal lags:
# It appears that either,
#   (i)   ACF either tails off  and the PACF tails off: Candidate model = SARIMA(1,1,1) (p = 1 beaucuase one seasonal spike in PACF and q = 1 because 1 spike in ACF) 
#   (ii)  ACF cuts off at slag 1 and PACF tails off: : Candidate model  = SARIMA(0,1,1)
#   (iii) ACF tails off and PACF cuts off at  lag 1: : Candidate model  = SARIMA(1,1,0)

# Within seasons candidates :
# It appears that either,
#   (a)  ACF cuts off at lag 1 and the PACF tails off: Candidate model = ARIMA(0,1,1) (p = 1 beaucuase one seasonal spike in PACF and q = 1 because 1 spike in ACF) 
#   (b)  ACF tails off and PACF cuts off at lag 4    : Candidate model = ARIMA(4,1,0)
#   (c)  The within season is random noise           : Candidate model = ARIMA(0,1,0)


#Full candidate models:
#  (a) x (i)   =  ARIMA(0,1,1) x (1,1,1) s=52
#  (a) x (ii)  =  ARIMA(0,1,1) x (0,1,1) s=52
#  (a) x (iii) =  ARIMA(0,1,1) x (1,1,0) s=52

#  (b) x (i)   =  ARIMA(4,1,0) x (1,1,1) s=52
#  (b) x (ii)  =  ARIMA(4,1,0) x (0,1,1) s=52
#  (b) x (iii) =  ARIMA(4,1,0) x (1,1,0) s=52


#  (c) x (i)   =  ARIMA(0,1,0) x (1,1,1) s=52
#  (c) x (ii)  =  ARIMA(0,1,0) x (0,1,1) s=52
#  (c) x (iii) =  ARIMA(0,1,0) x (1,1,0) s=52




# For Taxis:
# We can see at seasonal lags:
# It appears that either,
#   (i)   ACF tails off  and the PACF cuts off at lag 1: Candidate model = SARIMA(1,1,0) 
#   (ii)  ACF cuts off at lag 1 and PACF tails off:    : Candidate model  = SARIMA(0,1,1)
#   (iii)  It appears to be random noise               : Candidate model  = SARIMA(0,1,0)

# Within seasons candidates :
# It appears that either,
#   (d)  The within season ith appears to be random noise           : Candidate model  = ARIMA(0,1,0)


#Full candidate models:
#  (a) x (i)   =  ARIMA(0,1,1) x (1,1,1) s=52
#  (a) x (ii)  =  ARIMA(0,1,1) x (0,1,1) s=52

#  (b) x (i)   =  ARIMA(4,1,0) x (1,1,1) s=52
#  (b) x (ii)  =  ARIMA(4,1,0) x (0,1,1) s=52


#  (c) x (i)   =  ARIMA(1,1,1) x (1,1,1) s=52
#  (c) x (ii)  =  ARIMA(1,1,1) x (0,1,1) s=52

#  (d) x (i)   =  ARIMA(0,1,0) x (1,1,1) s=52
#  (d) x (ii)  =  ARIMA(0,1,0) x (0,1,1) s=52


#Diagnostics Taxis

taxis.sarima.010.110 = sarima(nsqrt.taxis_per_month, 0, 1, 0, 1, 1, 0, 12) # Bueno!
taxis.sarima.010.110 = sarima(nsqrt.taxis_per_month, 0, 1, 0, 0, 1, 0, 12) # Bueno!
taxis.sarima.010.011 = sarima(nsqrt.taxis_per_month, 0, 1, 0, 0, 1, 1, 12) # Bueno!

#Diagnostics Ubers

ubers.sarima.011.111 = sarima(sqrt.ubers_per_month, 0, 1, 1, 1, 1, 1, 12) #Good!
ubers.sarima.011.111 = sarima(sqrt.ubers_per_month, 0, 1, 1, 0, 0, 0, 12) #Good
ubers.sarima.011.111 = sarima(sqrt.ubers_per_month, 1, 1, 0, 0, 0, 0, 12) #Good



























uber_monthly <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/monthly_uber.csv"        , header=TRUE)
lyft_monthly <- read.csv("/Users/root1/Documents/Fall 2018 Baruch/Time Series/PROJECT/Transportation/Processed/FHV/monthly_Lyft.csv"        , header=TRUE)




taxis_per_day   = yellow_rides_per_day['rides'] + green_rides_per_day['rides']

taxis_per_month = (yellow_rides_per_month['rides'] + green_rides_per_month['rides'])/1000

ubers_per_month  = uber_monthly['Total.Dispatched.Trips']/1000
ubers_per_month  = ubers_per_month[-43,]


plot(ubers_per_month,taxis_per_month[,])

plot(log(ubers_per_month),log(taxis_per_month[,]))

fit = lm(log(taxis_per_month[,])~log(ubers_per_month), na.action=NULL)

acf(residuals(fit),50)


fit = lm(taxis_per_month[,]~ubers_per_month, na.action=NULL)

acf(residuals(fit),50)


abline(fit)
plot(residuals(fit))







plot.ts(yellow_rides_per_day['rides'], main = 'Yellow Rides per Day')
plot.ts(yellow_rides_per_week['rides'], main = 'Yellow Rides per Week')
plot.ts(yellow_rides_per_month['rides'], main = 'Yellow Rides per Month')


BoxCox.lambda(ts(yellow_rides_per_week['rides']))

acf(diff(ts(yellow_rides_per_week['rides']^2)),300)

plot.ts(green_rides_per_day['rides'],main = 'Green Rides per Day')
plot.ts(green_rides_per_week['rides'],main = 'Green Rides per Week')
plot.ts(green_rides_per_month['rides'],main = 'Green Rides per Month')


plot.ts(uber_monthly['Total.Dispatched.Trips'],main = 'Uber Rides per Month')
plot.ts(lyft_monthly['Total.Dispatched.Trips'],main = 'Lyft Rides per Month')



uber_monthly[1:42,3]
total_rides = (uber_monthly['Total.Dispatched.Trips'])[-43,]+ yellow_rides_per_month['rides'] + green_rides_per_month['rides'] 

uber_ratio_rides = (uber_monthly['Total.Dispatched.Trips'])[-43,]/total_rides
plot.ts(uber_ratio_rides,main = 'Uber Ratio')

change_in_rides = rep(0,42)
for (i in 1:41 ){
  change_in_rides[i] = ((uber_monthly['Total.Dispatched.Trips'])[i+1,]-(uber_monthly['Total.Dispatched.Trips'])[i,])/(uber_monthly['Total.Dispatched.Trips'])[i,]
  print(uber_monthly['Total.Dispatched.Trips'][i+1,])
  print(uber_monthly['Total.Dispatched.Trips'][i,])
  print(change_in_rides[i])
  
}







plot.ts(change_in_rides ,main = 'Uber rides changes per Month')

taxis = ts(yellow_rides_per_month['rides'])


acf(diff(taxis),50)

pacf(diff(taxis),50)


change_in_rides = rep(0,nrow(yellow_rides_per_day['rides']))
for (i in 1:(nrow(yellow_rides_per_day['rides'])-1) ){
  change_in_rides[i] = ((yellow_rides_per_day['rides'])[i+1,]-(yellow_rides_per_day['rides'])[i,])/(yellow_rides_per_day['rides'])[i,]
  print(yellow_rides_per_day['rides'][i+1,])
  print(yellow_rides_per_day['rides'][i,])
  print(change_in_rides[i])
  
}



plot.ts(change_in_rides ,main = 'Yellow rides changes per day')




nrow(yellow_rides_per_day['rides'])



plot.ts(yellow_rides_per_month['rides'], ylim= c(min(lyft_monthly['Total.Dispatched.Trips']),max(uber_monthly['Total.Dispatched.Trips'])))
lines(uber_monthly['Total.Dispatched.Trips'], col = 'blue')
lines(lyft_monthly['Total.Dispatched.Trips'], col = 'goldenrod')


plot.ts(yellow_rides_per_month['total_amount'], main = 'Yellow Fares per month')

plot.ts(yellow_rides_per_month['rides'], main = 'Yellow Rides per Week')

BoxCox.lambda(yellow_rides_per_month['rides'])

yellow_day = yellow_rides_per_month['rides']

yellow_day = ts(yellow_day)
diff.yellow_day = diff(yellow_day)
plot(diff.yellow_day)
acf(diff.yellow_day,lag.max = 200)
pacf(diff.yellow_day,lag.max = 200)


uber_month = ts(uber_monthly['Total.Dispatched.Trips'])


trend= mean(cmort)

temp2 = tempr^2

fit()
fit2 = lm(ts(yellow_day)~time(yellow_day))
plot(ts(yellow_day))
abline(fit2)


pacf(diff(taxis),200)

sarima.for(taxis,6, 0, 1, 0 , 2 , 1 , 0 , 12)



fit = lm(cmort~tempr + temp2 + part, na.action=NULL)
summary(fit)

arima(yellow_day, order=c(1,0,1), xreg=cbind(uber_month[-43]))

arima(cmort, order=c(1,0,1), xreg=cbind(fit,tempr,temp2,part))

library(vars)
x = cbind(cmort, tempr, part)
summary(VAR(x, p=1, type='both'))


plot(fit2)
residuals(fit2)
acf(fit2$residuals, lag.max = 43)
pacf(fit2$residuals, lag.max = 43)

