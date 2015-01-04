library(astsa)
source("d:/dev/r/w64_qserver/qserver.R")

# Connect to KDB
h<-open_connection("127.0.0.1",7777,"") 

# Get HSI and HHI data from KDB table
x1 <- execute(h,"select from HHI30")
x2 <- execute(h,"select from HSI30")

# Use contMid for now
x1 <- x1$contMid
x2 <- x2$contMid

r1 <- diff(log(x1))
r2 <- diff(log(x2))
X <- data.frame(HHI=x1,HSI=x2)

plot(r1,r2)

#Equilibrium m=1.4
#Try any b, say 6566

m <- 1.4
b <- 6566
r <- x2 - (b + m*x1)
N <- length(r)
plot(r)

# Found time-dependent component (?)
model_t <- lm(r ~ c(0:N))
m2 <- model_t$coeff[2]
b2 <- model_t$coeff[1]
r2 <- r - (b2 + m2*c(0:N))
plot(r2)


