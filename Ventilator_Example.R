rm(list=ls())

# This is an example of the NV problem formulation using ventilator context 

demand <- c(50,100,150,200,250,300,350)
#demand = rpois(200,10)
demand

summary(demand)
mean(demand)
sd <- sqrt(var(demand))
sd

# Visualizing this probability distribution function
library(fitdistrplus)
pois_fit <- fitdist(demand, 'pois')
# Fitting Poisson distribution to data returns a parameter very close to lambda
pois_fit

# you can see what is stored in pois_fit by using the command below
# names(pois_fit)

# Plot empirical and theoretical distributions
plot(pois_fit)

cu<-3
co<-4
cr<-3/(4+3)
cr
demandf <-data.frame(demand)
mycdf <-ecdf(demandf$demand)
plot(mycdf,
     xlab = "Ventilator Demand",
     ylab = "eCDF",
     main = "Empirical CDF of Meal Preparation")
abline(h = cr, col = 'red')
abline(v=10, col="purple", lty = 2)

# Range of q
qRange <- c(50,100,150,200,250,300,350)
qRange

# In what range of values of cu is your decision robust?
fun.ecdf <- ecdf(demand)
myecdf <- unique(fun.ecdf(sort(demand)))
myecdf

demand.freq <- table(demand)
demand.prob <- demand.freq/length(demand) 
prob <- as.vector(demand.prob)
qRange
prob
discretedemand <- qRange

# Define function 'pi_Dsim(w,qRange)' which returns the expected cost for a range of q under a given w
pi <- rep(NA, length(qRange))
pi_sim <- function(cu,qRange){
  for(q in qRange){
    pi[which(q==qRange)] <- sum(cu*pmax(discretedemand - q,0)*prob+co*pmax(q-discretedemand,0)*prob)
    # A small trick: with a large sample size, sum(x)/length(x) runs much faster than mean(x). The reason is that 'sum' and 'length' are primitive functions in R.
  }
  return(pi)
}

pi_cu <- pi_sim(cu,qRange)
indmincu <- which.min(pi_cu)
qopt <- qRange[indmincu]

# Plot hospital's cost under each q
plot(qRange,pi_cu,'l', xlab = 'q', ylab = 'Cost($)') 
title("Meal Catering Cost")

# Create a data frame so you can visualize

costdf <- data.frame(qRange,pi_cu)

# Suppose you wanted to know what would happen if cu was 25000

pi_25k <- pi_sim(8,qRange)
indmmin25k <- which.min(pi_25k)
qopt <- qRange[indmmin25k]

# Plot catering's cost under each q
plot(qRange,pi_25k,'l', xlab = 'q', ylab = 'Cost($)') 
title("Meal Catering Cost")

costdf <- data.frame(qRange,pi_cu,pi_25k)

# Notice that the optimal order quantity did not change. When will it change?
# Let us try cu = 65000

pi_65k <- pi_sim(4,qRange)
indmin65k <- which.min(pi_65k)
qopt <- qRange[indmin65k]
qopt

# Plot hospital's cost under each q
plot(qRange,pi_65k,'l', xlab = 'q', ylab = 'Cost($)') 
title("Meal Catering Cost")

costdf <- data.frame(qRange,pi_cu,pi_25k,pi_65k)
