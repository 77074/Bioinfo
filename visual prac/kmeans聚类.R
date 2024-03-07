library(clue)
library(ggplot2)
library(factoextra)

df <- scale(USArrests) ##数据标准化！非常重要！在聚类分析，主成分分析都要用

#res <- get_clust_tendency(df,40,graph = TRUE)
#res$hopkins_stat ##hopkins统计量 >0.5代表聚类明显

fviz_nbclust(df,kmeans,method="wss") #计算SSE判断聚点趋势，取n=4

km_result <- kmeans(df,4,nstart=25)
df_clu <- cbind(USArrests,cluster=km_result$cluster)
#table(df_clu$cluster) #计算聚点数目

#可视化！
#ellipse 轮廓  repel:防堆叠
#star.plot 连线
#只有Kmeans 才需要data 参数
fviz_cluster(km_result,data=df,
             palette = c("#2E9FDF","#00AFBB","#E7B800","#FC4E07"),
             ellipse.type = "euclid",
             star.plot = TRUE,
             repel = TRUE
)

