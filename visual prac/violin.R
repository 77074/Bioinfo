library(ggplot2) # R语言中最常用的基于grid的可视化工具
library(RColorBrewer)
library(ggpubr)

df <- read.table("D:/Rcode/visual prac/box_plots_mtcars.txt",header = TRUE, sep='\t')
df$cyl <- as.factor(df$cyl)

ggplot(df, aes(x=cyl, y=mpg,fill=cyl)) +
  scale_fill_brewer(palette = "Blues")+
  geom_violin(trim=FALSE) +
  labs(title="Plot of mpg per cyl", x="Cyl", y = "Mpg") +
  geom_boxplot(width=0.1,fill = "white")+
  theme_classic()
