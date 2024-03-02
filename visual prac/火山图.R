library(ggplot2)
library(RColorBrewer)



df3 <- read.table("D:/Rcode/visual prac/volcano_plots.txt",header = TRUE,sep="")
df3$threshold <- as.factor(ifelse(df3$padj < 0.05 & abs(df3$log2FoldChange) >=1,
                                  ifelse(df3$log2FoldChange > 1 ,'Up','Down'),'Not'))

ggplot(df3,aes(x=log2FoldChange,y=-log10(padj)),fill=threshold)+
  geom_point(aes(color=threshold),size=1)+
  scale_color_manual(values=c("blue","grey","red"))+
  xlim(c(-3,3))+
  geom_vline(xintercept=c(-1,1),lty=4,col="grey",lwd=0.6)+
  geom_hline(yintercept = -log10(0.05),lty=4,col="grey",lwd=0.6)


  
