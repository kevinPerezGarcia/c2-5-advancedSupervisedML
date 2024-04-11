bupa<-read.table("../data/raw/bupa.txt",header=T,sep=",") 
# Declarar V7 como un factor
bupa[,7]<-as.factor(bupa[,7])

str(bupa)

# División de la base de datos
set.seed(200)
s=sample(1:345,100)
bupa.tr=bupa[-s,]
bupa.te=bupa[s,]

summary(bupa.tr)
summary(bupa.te)

library(mgcv)
library(pROC)

##################################################
# Random Forest
###################################################
library(randomForest)

bupa.rf <- randomForest( V7~ ., data = bupa.tr, 
                      mtry = 2, importance = TRUE,
                      do.trace = 10)
reg.log=glm(V7~ ., data = bupa.tr,family=binomial)
library(MASS)
reg.log.s=stepAIC(reg.log)


##################################################
# GAM
#################################################
library(gamlss)

bupa.gam = gam(V7
               ~s(V1)
               +s(V2)
               +s(V3)
               +s(V4)
               +s(V5)
               +s(V6),
               data=bupa.tr,
               family=binomial)

bupa.gam

summary(bupa.gam)

plot(bupa.gam)
plot(bupa.gam,ylim=c(-10,10))

#############################
# gamlss
#############################
library(gamlss)

bupa.gamlss = gamlss(V7~pb(V1)+pb(V2)+pb(V3)+pb(V4)+pb(V5)+pb(V6),
data=bupa.tr,family=BI)

bupa.gamlss

summary(bupa.gamlss)

drop1(bupa.gamlss)

term.plot(bupa.gamlss, pages=1, ask=FALSE)

wp(bupa.gamlss)

#######################################

bupa.gamlss.s=stepGAIC(bupa.gamlss,k=log(245))

wp(bupa.gamlss.s)

term.plot(bupa.gamlss.s, pages=1, ask=FALSE)

drop1(bupa.gamlss.s)

wp(bupa.gamlss)

##################################################

bupa.gamlss.1=gamlss(V7~V1+pb(V2)+pb(V3)+V4+pb(V5),
                     data=bupa.tr,family=BI)

wp(bupa.gamlss.1)

term.plot(bupa.gamlss.1, pages=1, ask=FALSE)

drop1(bupa.gamlss.1)

summary(bupa.gamlss.1)

AIC(bupa.gamlss,bupa.gamlss.1)



################################################
# Predicciones sobre el conjunto de entrenamiento

yprob<-predict(reg.log.s,type="response")
fit.roc<-roc(bupa.tr$V7, yprob)
fit.roc
plot(fit.roc)

yprob<-predict(bupa.rf, bupa.tr[,-7], type="prob")[,2]
fit.roc.rf<-roc(bupa.tr$V7, yprob)
fit.roc.rf
plot(fit.roc.rf,add=TRUE,col=2)


yprob<-predict(bupa.gam,bupa.tr,type="response")
fit.roc.gam<-roc(bupa.tr$V7, yprob)
fit.roc.gam
plot(fit.roc.gam,add=TRUE,col=4)

##############################################
# Predicciones sobre el conjunto de prueba

yprob<-predict(reg.log.s,newdata=bupa.te[,-7],type="response")
fit.roc<-roc(bupa.te$V7, yprob)
fit.roc
plot(fit.roc)

yprob<-predict(bupa.rf,newdata=bupa.te[,-7], type="prob")[,2]
fit.roc.rf<-roc(bupa.te$V7, yprob)
fit.roc.rf
plot(fit.roc.rf,add=TRUE,col=2)


yprob<-predict(bupa.gam,newdata=bupa.te[,-7],type="response")
fit.roc.gam<-roc(bupa.te$V7, yprob)
fit.roc.gam
plot(fit.roc.gam,add=TRUE,col=4)

yprob<-predict(bupa.gamlss,newdata=bupa.te[,-7],type="response")
fit.roc.gamlss<-roc(bupa.te$V7, yprob)
fit.roc.gamlss
plot(fit.roc.gamlss,add=TRUE,col=3)


