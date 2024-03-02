library(ggplot2)
library(RColorBrewer)
library(ggpubr)

x_value = c("A","A","A","A","A","A","B","B","B","B","B","B")
y_value = c(9,7,6,2,3,4,1,2,3,7,9,8)
x_subvalue = c("SR","SR","SR","R","R","R","SR","SR","SR","R","R","R")

df = data.frame(x_value,y_value,x_subvalue)
df$x_subvalue <- factor(df$x_subvalue)
df$x_value <- factor(df$x_value)

ggplot(df,aes(x=x_subvalue,y=y_value,fill=factor(x_subvalue)))+
  geom_boxplot()+
  scale_fill_brewer(palette="Blues")+
  stat_boxplot(geom="errorbar",width=0.6,size=0.8)+
  stat_compare_means(comparisons = list(c("R","SR")),method = "t.test")+
  facet_wrap(~x_value)+
  geom_point()



  