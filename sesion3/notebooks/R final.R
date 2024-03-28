# Parte intuitiva y visual
library(foreign)
Panel <-read.dta("http://dss.princeton.edu/training/Panel101.dta")
Panel
summary(Panel)
coplot(y ~ year|country, type="l", data=Panel) # Lines
coplot(y ~ year|country, type="b", data=Panel) # Points and lines

library(car)
scatterplot(y~year|country, boxplots=FALSE, smooth=TRUE, reg.line=FALSE, data=Panel)

library(gplots)
plotmeans(y ~ country, main="Heterogeineity across countries", data=Panel)
plotmeans(y ~ year, main="Heterogeineity across years", data=Panel)

# Corriendo una regresion lineal simple

ols<-lm(y ~ x1, data=Panel)
summary(ols)
plot(Panel$x1, Panel$y, pch=19, xlab="x1", ylab="y")
abline(lm(Panel$y~Panel$x1),lwd=3, col="red")

# Regresión con variables dummy

fixed.dum <-lm(y ~ x1 + factor(country) -1, data=Panel)
summary(fixed.dum)

yhat<-fixed.dum$fitted
library(car)
scatterplot(yhat~Panel$x1|Panel$country, boxplots=FALSE, xlab="x1", ylab="yhat",smooth=FALSE)
abline(lm(Panel$y~Panel$x1),lwd=3, col="red")

# Regresion con data panel, modelo de efectos fijo

library(plm)
fixed <-plm(y ~ x1, data=Panel, index=c("country", "year"), model="within")
summary(fixed)

# Regresion con data panel, modelo de efectos aleatorio

random <-plm(y ~ x1, data=Panel, index=c("country", "year"), model="random")
summary(random)