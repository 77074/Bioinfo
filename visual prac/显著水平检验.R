library(ggplot2) # R语言中最常用的基于grid的可视化工具
library(RColorBrewer)
library(ggpubr)


ggboxplot(ToothGrowth,x="dose",y="len",color="dose")+
  stat_compare_means(method="anova",label.y=40)+
  stat_compare_means(label ="p.signif",method = "t.test",ref.group = ".all.") # signif 去掉数值，.all.与总体进行比较
