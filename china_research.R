filename <- "/Users/kendalllo/Documents/temp/201410day/20141031day_SortByTicker.csv"
t <- read.csv(filename)
t["MidPrice"] <- (t["BidPrice1"] + t["AskPrice1"])/2
instr <- unique(t["InstrumentID"])
#colnames(t)



# Autocorrelation
result = data.frame()
for (i in 1:nrow(instr[1])) {
  x <- instr[i,1]
  print(x)
  t2 <- t[t[,"InstrumentID"] == x,]
  t2["MidR"] <- c(0,diff(log(t2["MidPrice"])[,1])) 
  curPacf <- pacf(t2["MidR"],plot=FALSE, na.action=na.pass)$acf[1:20]
  result <- rbind(result, curPacf)  
}
result