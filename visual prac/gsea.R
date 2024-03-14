library(data.table)
library(fgsea)
library(ggplot2)

data(examplePathways)
data(exampleRanks)

#Ranks 是待分析基因序列，可以理解为：
# G1 G2 G3 ……
# 10 20 30 （fold)

#Pathways 是代谢通路的集合，就是一堆基因和他们的影响因子

fgseaRes <- fgsea(pathways = examplePathways,
                  stats = exampleRanks,
                  eps = 0.0,
                  minSize = 15,
                  maxSize = 500
  
)

## fgseaRes 是一个数据框，包含每个通路的富集得分，显著性，leading edge等

fgseaRes_ordered <- fgseaRes[order(pval),]
Max_Es_Path <- head(fgseaRes_ordered,1)$pathway #这么做避免了被标题行(名称，变量类型）干扰
plotEnrichment(examplePathways[[Max_Es_Path]],
               exampleRanks) + 
  labs(title=Max_Es_Path)
#这串代码是提取了最显著的通路的ES图

topPathwaysUp <- fgseaRes[ES > 0][head(order(pval), n=10), pathway] 
#第一个框：筛选上调 第二个框：以显著水平排序，提取前十行，只显示代谢通路列
#所以实际效果为： 提取最显著的十个上调代谢通路*名称*
topPathwaysDown <- fgseaRes[ES < 0][head(order(pval), n=10), pathway]
topPathways <- c(topPathwaysUp, rev(topPathwaysDown))
#反着来单纯是为了让人从下往上看下调通路
plotGseaTable(examplePathways[topPathways], exampleRanks, fgseaRes, gseaParam=0.5)
#几个参数：指定代谢通路信息（包含所有基因组合），基因集合（待分析的），分析结果


