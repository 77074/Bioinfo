library(ggplot2) # R语言中最常用的基于grid的可视化工具
library(RColorBrewer)
library(ggpubr)

df <- read.table("D:/Rcode/visual prac/box_plots_mtcars.txt",header = TRUE, sep='\t')
df1 <- df[, c("mpg", "cyl", "wt")]
mycomparisions <- list(c(4,6),c(4,8),c(6,8))

ggplot(df, aes(x=cyl, y=mpg, fill=factor(cyl))) +  # fill=cyl: 用颜色表示cyl一列的数值
  geom_boxplot()+
  labs(title="Plot of mpg per cyl",x="Cyl", y = "Mpg") +
  stat_boxplot(geom="errorbar",width=0.6,size=0.8)+ #误差线
  scale_fill_brewer(palette="Blues") +  # palette="Blues": 定义了一种数值到颜色的对应关系，数值越大蓝色的颜色越深
  theme_bw()+
  geom_point(color="blue",size=2.5)+
  geom_hline(yintercept = mean(df1$mpg),linetype = 2)+ #平均值线
  stat_compare_means()
















