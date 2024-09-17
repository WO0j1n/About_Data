data()

plot(faithful, col = 'blue', xlab = 'eruptions', ylab = 'waiting')

head(faithful, 10)
tail(faithful, 10)

faithful[1,]
faithful[2,]
faithful[,1]
faithful[,2]

faithful$eruptions
faithful$waiting