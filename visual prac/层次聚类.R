library(clue)
library(ggplot2)
library(factoextra)

df0 <- scale(USArrests)

oudist <- dist(df0,method="euclidean") #计算欧氏距离
##目前不太清楚分几类

##使用热图瞅一眼
# heatmap(as.matrix(oudist)) #看上去n=3或4

##试试elbow法
#fviz_nbclust(df0,hcut,method="wss") #看上去 n=4

hcut_df <- hclust(oudist,method="ward.D2")

fviz_dend(hcut_df,k=4,
          cex = .5,
          k_colors = c("#2E9FDF","#00AFBB","#E7B800","#FC4E07"),
          color_labels_by_k = TRUE,
          rect = TRUE
)




