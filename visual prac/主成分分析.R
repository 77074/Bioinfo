library(ggplot2)

data <- iris
dt <- as.matrix(scale(data[,1:4])) #仅保留数字行并进行标准化，同时转化为矩阵类型

Cov <- cor(dt)  #计算协方差矩阵
Fea <- eigen(Cov)   #计算特征值，特征向量矩阵，生成的是一个字典

D <- Fea$values  #提取特征值，即主成分方差（好神奇）,特征值大于1代表大概率主成分
S <- sqrt(D)     #换算成标准差

proportion_D <- D/sum(D)  #计算方差贡献率
cumulative_proportion <- cumsum(proportion_D) #计算累进方差贡献率，累进大于80大概率主成分

par(mar=c(6,6,2,2))
plot(Fea$values,type="b",   
     xlab = "主成分编号",
     ylab = "特征值，即主成分方差"

)

#一般来说，提取主成分方差由上述三个方法其中一两个即可，不需要完全使用

Vec <- as.matrix(Fea$vectors)
PC <- dt %*% Vec        #特征向量矩阵乘以原矩阵
colnames(PC) <- c("PC1","PC2","PC3","PC4")

df <- data.frame(PC,iris$Species)

ggplot(df,aes(x=PC1,y=PC2,color=iris.Species))+ #注意访问数据框时可以使用.
  stat_ellipse(aes(fill=iris.Species),
  type ="norm", geom ="polygon",alpha=0.2,color=NA)+
  geom_point()


