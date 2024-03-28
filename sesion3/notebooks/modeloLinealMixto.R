#install.packages("foreign")
#installed.packages("dplyr")
#install.packages("ggplot2")
#install.packages("nlme")
#install.packages("lme4")
install.packages("lmerTest")

library(foreign)
library(dplyr)
library(ggplot2)
library(lme4)
library(nlme)
library(lmerTest)


#
# FEV
#

fev1 <- read.dta("data/raw/fat.dta")
fev1 <- subset(fev1, id != 197) 

head(fev1,n=20)


# Edad vs. volumen espiratorio forzado
pdf("fig81.pdf")
ggplot(fev1, aes(x=age,y=logfev1,group=id,
                 color=id)) +
  geom_line()  +
  geom_point() +
  labs(x = "Edad (a?os)",y="Log(FEV)",size=18) +
  theme(legend.position="none")
dev.off()

# Logaritmo de la altura
fev1$loght  <- log(fev1$ht)           
fev1$logbht <- log(fev1$baseht)


# Edad vs. volumen espiratorio forzado
pdf("fig82.pdf")
ggplot(fev1, aes(x=loght,y=logfev1,group=id,
                 color=id)) +
  geom_line()  +
  geom_point() +
  labs(x = "Log (Altura)",y="Log(FEV)",size=18) +
  theme(legend.position="none")
dev.off()


# Depresi?n

depre = read.table("data/raw/depresion.txt",header = T)

head(depre)

summary.depre <- depre %>%
  group_by(treat,time)  %>%
  summarize(mean.y = mean(outcome,na.rm=T))

pdf("fig83.pdf")
ggplot(summary.depre, aes(x=time,y=mean.y,group=as.factor(treat),
                          color=as.factor(treat))) +
  geom_point() +
  labs(x = "Semanas",y=" Proporci?n de respuestas normales",size=18) +
  coord_cartesian(ylim = c(0, 1))  + 
  theme(legend.position = "top") +  
  scale_colour_discrete(breaks=c("0","1"),
                        labels=c("?standar","Nueva"),name="Tratamiento") 
dev.off()


# Modelos

model0 <- lm(logfev1 ~ age + loght + baseage + logbht,fev1)
summary(model0)

##############################################################
#
# Modelo mixto con intercepto aleatorio
#
#############################################################

pdf("fig84.pdf")
plot(c(1,10),c(1,10),type="l",lwd=2,xlab="X",ylab="Y")
abline(a=-0.5,b=1,lty=2)
text(6,4.5,labels=expression(paste(b[A]," = -0.5")))
abline(a=1,b=1,lty=3)
text(6,7,labels=expression(paste(b[B]," = 1")))
legend("topleft",legend=c("Poblacional","Persona A","Persona B"),
       lty=1:3,lwd=c(2,1,1))
dev.off()

model1<- lme(logfev1 ~ age + loght + baseage + logbht, 
             random= ~ 1 | id,fev1)
summary(model1)


fev1$fit1 <- predict(model1)
fev1$fit2 <- predict(model1,level=0)

pdf("fig85.pdf")
ggplot(fev1,aes(x=age,y=logfev1)) +
  geom_line(data=fev1[fev1$id==1,],aes(y=fit1)) +
  geom_line(data=fev1[fev1$id==2,],aes(y=fit1)) +
  geom_line(data=fev1[fev1$id==3,],aes(y=fit1)) +
  geom_line(data=fev1[fev1$id==4,],aes(y=fit1)) +
   labs(x = "Edad (a?os)",y=" Log(FEV)",size=1) +
   theme(legend.position="none")
dev.off()


hat       <- predict(model1)
new.dat.0 <- data.frame(age     = seq(min(fev1$age),max(fev1$age),length=10),
                        loght   = rep(mean(fev1$logbht),10),
                        baseage = rep(mean(fev1$baseage),10),
                        logbht  = rep(mean(fev1$logbht),10))

pdf("fig86.pdf")
ggplot(fev1,aes(x=age,y=hat)) +
  geom_point() +  
  geom_line(aes(y=predict(model1), group=id)) +
  geom_line(data=new.dat.0, aes(y=predict(model1,level=0, newdata=new.dat.0)),
            size=2,color=2) +
  labs(x = "Edad (a?os)",y="FEV (lt/seg)",size=18) +
  theme(legend.position="none")
dev.off()

#########################################################
#
# Modelo mixto con pendiente aleatoria
#
########################################################

pdf("fig87.pdf")
plot(c(0,15),c(0,15),type="l",lwd=2,xlab="X",ylab="Y")
abline(a=-0.5,b=0.3,lty=2)
text(9,2.5,labels=expression(paste(b[1][A]," = -0.5, ",b[2][A],"= -0.7")))
abline(a=1,b=1.5,lty=3)
text(6,11,labels=expression(paste(b[1][A]," = 1, ",b[2][A],"= 0.5")))
legend("topleft",legend=c("Poblacional","Persona A","Persona B"),
       lty=1:3,lwd=c(2,1,1))
dev.off()


model2 <- lme(logfev1 ~ age + loght + baseage + logbht,random= ~ age|id,fev1)
summary(model2)

# Variabilidad pendiente
pdf("fig88.pdf")
xval <- seq(0,0.05,length=100)
plot(xval,dnorm(xval,fixed.effects(model2)[2],as.numeric(VarCorr(model2)[2,2])),
     type="l",xlab="Efecto de la edad",ylab="Densidad")
dev.off()

# Variabilidad intercepto
pdf("fig89.pdf")
xval <- seq(-0.6,0,length=100)
plot(xval,dnorm(xval,fixed.effects(model2)[1],as.numeric(VarCorr(model2)[1,2])),
     type="l",xlab="Intercepto",ylab="Densidad")
dev.off()

# Aleatorios vs. no aleatorio

summary(model2)$tTable
summary(model0)$coef

# Comparaci?n de modelos

model1a <- lmer(logfev1 ~ age + loght + baseage + logbht + (1|id),data=fev1)
model2a <- lmer(logfev1 ~ age + loght + baseage + logbht + (1+age |id),data=fev1)
anova(model1a,model2a)

model3a <- lmer(logfev1 ~ age + loght + baseage + logbht + (1+age +loght|id),data=fev1)
model3a
anova(model2a,model3a)

fev1$fit3 <- predict(model3a)

pdf("fig810.pdf")
ggplot(fev1,aes(x=age,y=logfev1)) +
  geom_line(data=fev1[fev1$id==1,],aes(y=fit3)) +
  geom_line(data=fev1[fev1$id==2,],aes(y=fit3)) +
  geom_line(data=fev1[fev1$id==3,],aes(y=fit3)) +
  geom_line(data=fev1[fev1$id==4,],aes(y=fit3)) +
  labs(x = "Edad (a?os)",y=" Log(FEV)",size=1) +
  theme(legend.position="none")
dev.off()


######################################################
#
# Body fat
#
######################################################

fat <- read.dta(file.choose())

# Datos
head(fat,n=12)

pdf("fig811.pdf")
ggplot(fat, aes(x=time,y=pbf,group=id,
                 color=id)) +
  geom_line()  +
  geom_point() +
  labs(x = "Tiempo relativo a mestruaci?n (a?os)",y="% de grasa corporal",size=18) +
  theme(legend.position="none")
dev.off()

# Curva suave
pdf("fig812.pdf")
ggplot(fat, aes(x=time,y=pbf)) +
  geom_point() +
  geom_smooth(method = "loess", size = 1.5) +
  geom_vline(xintercept = 0) +
  labs(x = "Tiempo relativo a mestruaci?n (a?os)",y="% de grasa corporal",size=18) +
  theme(legend.position="none")
dev.off()

# Construcci?n de variables
fat$time0   <- fat$time*I(fat$time>=0)
model1b     <- lmer(pbf ~ time + time0 + (1+ time + time0 | id),fat)
summary(model1b)

# BLUP
hat <- predict(model1b)

ggplot(fat,aes(x=time,y=hat,group=id,color=id)) +
  geom_point() +  
  geom_line()  +
  geom_vline(xintercept = 0) +
  labs(x = "Tiempo relativo a mestruaci?n (a?os)",y="% de grasa corporal",size=18) +
  theme(legend.position="none")

new.dat.0 <- data.frame(time  = seq(min(fat$time),0,length=10),time0 = rep(0,10))
new.dat.1 <- data.frame(time  = seq(0,max(fat$time),length=10),
                         time0 = seq(0,max(fat$time),length=10))
                      
ggplot(fat,aes(x=time,y=hat)) +
  geom_point() +  
  geom_line(aes(y=predict(model1b), group=id)) +
  geom_line(data=new.dat.0, aes(y=predict(model1b,level=0, newdata=new.dat.0)),size=2) +
  geom_line(data=new.dat.1, aes(y=predict(model1b,level=0, newdata=new.dat.1)),size=2) +
  geom_vline(xintercept = 0) +
  labs(x = "Tiempo relativo a mestruaci?n (a?os)",y="% de grasa corporal",size=18) +
  theme(legend.position="none")


####################################################################
#
# Residuales
#
#####################################################################


pdf("fig813.pdf")
hist(residuals(model1b,type="response"),xlab="Residual",prob=TRUE,
     ylab="Densidad",main="")
lines(density(residuals(model1b,type="response")))
dev.off()

# Residuos estandarizados y \mu_ij

pdf("fig814.pdf")
ggplot(data.frame(eta=predict(model1b,type="link"),
                  pearson=residuals(model1b,type="pearson")),
       aes(x=eta,y=pearson)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  geom_smooth(method = "loess", size = 1.5) +
  labs(x = expression(hat(mu)),y="Residuales",size=18) 
dev.off()

# Residuales vs. covariables

pdf("fig815.pdf")
ggplot(data.frame(x1=fat$time,pearson=residuals(model1b,type="pearson")),
       aes(x=x1,y=pearson)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  geom_smooth(method = "loess", size = 1.5) +
  labs(x = "Tiempo",y="Residuales",size=18) 
dev.off()


#
# Modelos lineales generalizados
#

model4 = glmer(outcome ~ severity + treat*time + (1|case), data=depre, 
               family=binomial(link="logit"))
summary(model4)



#
# GEE
#

##
## Depresi?n
##

model5 = geem(outcome ~ severity + treat*time, id=case, data=depre, 
              family=binomial(link="logit"), corstr="independence" )
summary(model5)

model6 = geem(outcome ~ severity + treat*time, id=case, data=depre, 
              family=binomial(link="logit"), corstr="exchangeable" )
summary(model6)


