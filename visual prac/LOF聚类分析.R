library(DMwR2)
library(ggplot2)

score <- lofactor(USArrests,k=10)
df <- data.frame(score)

ggplot(df,aes(x=score))+
  geom_density()+
  scale_x_continuous(limits=c(0.8,1.8))+
  theme_classic()

order(score,decreasing=TRUE)[1:6] #取6个离群值样本号
