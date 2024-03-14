##一些修改列名和行名的函数，感觉以后都能用：
## colnames(rna_vm) = gsub('\\.','-',substr(colnames(rna),1,12)) 把样本名改好看一点
## rownames(z_rna) = sapply(rownames(z_rna), function(x) unlist(strsplit(x,'\\|'))[[1]])  把基因名提取前半截
## exp = expression[which(rownames(expression) != '?'),] 提取确定的基因
library("ggplot2")
library("ggpubr")
library("survival")
library("survminer")
library("limma")


rna = readRDS(file="D:/Rcode/clinical/rna.rds")
clinical_info = readRDS(file="D:/Rcode/clinical/clinical_info.rds")

# rna 包含16000名病人的500个基因的数据


n_index = which(substr(colnames(rna),14,14) == '1')
t_index = which(substr(colnames(rna),14,14) == '0')

#which 函数返回索引
#substr()函数返回字符串的第a~b个字符
#这段分别筛选了列名的第十四个字符分别为0,1的列索引，1代表normal,0代表test

library(limma)

##对原表达矩阵进行标准化处理
vm <- function(x)
  {
  cond <- factor(ifelse(seq(1,dim(x)[2],1)%in% t_index,1,0))
  d <- model.matrix(~1+cond)  ##含截距的设计矩阵，记录类型变量
  x <- t(apply(x,1,as.numeric)) ##apply 1：对行操作，2：对列操作，实际效果：将每一行设置为数字，再转置
  ex <- voom(x,d,plot=F)  ## voom：归一化，根据设计矩阵线性拟合，计算残差并估计离散程度，赋予响应权重
  return(ex$E)
  }

rna_vm = vm(rna)
colnames(rna_vm) = gsub('\\.','-',substr(colnames(rna),1,12))  #改一改列名，提取前12个字符，把.改成-

##scal 就是做一个简单的标准化,并确认组间差异
scal <- function(x,y){
  mean_n <- rowMeans(y)  # mean of normal,把所有normal组搓到一起计算平均值
  sd_n <- apply(y,1,sd)  # SD of normal，把所有Normal组凑到一起计算方差
  # z score as (value - mean normal)/SD normal  z score相当于做了一次直接的标准化
  res <- matrix(nrow=nrow(x), ncol=ncol(x))
  colnames(res) <- colnames(x)
  rownames(res) <- rownames(x)
  for(i in 1:dim(x)[1]){
    for(j in 1:dim(x)[2]){
      res[i,j] <- (x[i,j]-mean_n[i])/sd_n[i]
    }
  }
  return(res)
}

z_rna = scal(rna_vm[,t_index],rna_vm[,n_index])
##最巧妙的一步，正常组的数据承担了被标准化的角色，z_rna 记录的是test组相对normal组的z score
## z-rna放的是肿瘤组的“差异值”

rownames(z_rna) = sapply(rownames(z_rna), function(x) unlist(strsplit(x,'\\|'))[[1]])

ind_tum = which(unique(colnames(z_rna)) %in% rownames(clinical_info))
expression = z_rna[,ind_tum]
exp = expression[which(rownames(expression) != '?'),]
## 把意义不明的gene剔除
ind_clin = which(rownames(clinical_info) %in% colnames(exp))
clinical_info = clinical_info[ind_clin,]

## 取基因数据和临床数据的交集

################以上是数据预处理和名称调整环节
################达成的效果：获得了标准化的基因表达矩阵rna_vm，肿瘤相对正常组的差异矩阵z_rna
################取临床和基因数据交集得到了：clinical_info和exp
################以下是running代码



rna_event = t(apply(exp, 1, function(x) ifelse(abs(x) > 1.96, 1, 0)))
## ifelse 对向量进行递归操作！！
## 该行代码将显著差异标记为1，储存在一个二进制矩阵rna_event中，很贴切的名字uh!

rna_event2 = t(apply(exp, 1, function(x) ifelse(x > 1.96, 2, ifelse(x < -1.96, 1, 0 ))))
##很有趣的ifelse嵌套，但是反人类，跟linux一样史，储存三种事件：显著上调，显著下调，没变化
##将ifelse理解为二叉树的一个分叉就行

ind_gene = which(rownames(exp) == 'CCDC58')
## which 对向量使用时返回索引值，对矩阵使用时返回行,这里是返回了gene名为CCDC58的行数，因为rownames是个列表（vector之类的）

table(rna_event2[ind_gene,])
## 显示该基因的调控情况

survplotdata = cbind(clinical_info$new_death, clinical_info$death_event, rna_event[ind_gene,])
##包含死亡时间（如果没有死亡，则为最后跟进时间），死亡事件（0,1），基因调控情况
colnames(survplotdata) = c('new_death', 'death_event', 'CCDC58')
survplotdata = as.data.frame(survplotdata)

fit = survfit(Surv(new_death, death_event) ~ CCDC58, data = survplotdata)

ggsurvplot(fit,
           risk.table = TRUE,
           pval = TRUE,
           break.time.by = 500,
           ggtheme = theme_bw(),
           legend.title = "CCDC58 expression",
           legend.labs = c("Up-regulated ", "NotAltered"),
           risk.table.y.text.col = TRUE,
           risk.table.y.text = FALSE,
           risk.table.col = "strata",
           palette = c("blue", "red"))


