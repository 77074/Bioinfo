library(gplots)
library(ggplot2)
library(RColorBrewer)
library(ggpubr)
library(plyr)
dm <- read.table("D:/Rcode/visual prac/heatmaps.txt",header = TRUE,sep="")
dm_m <- as.matrix(dm[,-1])
rownames(dm_m) <- dm$Gene_name#****非常关键的一次数据转换，没有这一步就全完了！

cr <- colorRampPalette(c("blue","white","red"))
heatmap.2(dm_m,
          scale="row",# 注意数据集是横着来的
          key=T, keysize=1.1, # 设置色饼的大小
          cexCol=0.9,cexRow=0.8, #莫名其妙的参数设置
          col=cr(1000),  # 色彩参数1000等分
          ColSideColors=c(rep(c("blue","red"),5)), # 本数据集有10个样本，所以5,5重复
          density.info="none",trace="none", #去掉对角线
          #dendrogram='none', #if you want to remove dendrogram 
          Colv = T,Rowv = T) #clusters by both row and col