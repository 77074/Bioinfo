library(ggplot2)
library(RColorBrewer)
library(ggpubr)
library(plyr) #a new package

df <- read.table("D:/Rcode/visual prac/histogram_plots.txt",header = TRUE,sep="")
mu <- ddply(df, "sex", summarise, grp.mean=mean(weight))#summarise是汇总函数，下一个参数是列名和生成方式
df$sex <- factor(df$sex) #注意这里weight不可以作为因子

ggplot(df,aes(x=weight,color=sex,fill=sex))+
  geom_histogram(binwidth=1,aes(y=..density..),position="identity",alpha=0.5)+ 
  #做成透明的,注意aes的使用，不然没法引入密度曲线
  geom_density(alpha=0.2)+
  geom_vline(data=mu,aes(xintercept=grp.mean,color=sex), linetype="dashed", size=0.5)+
  #加一条平均线，注意aes
  scale_color_manual(values = c("#0073C2FF", "#EFC000FF"))+
  scale_fill_manual(values = c("#0073C2FF", "#EFC000FF"))+
  theme_classic()
  

