library(mice)
anscombe[sample(1:nrow(anscombe),2),1] <- NA

##直接删除法
head(anscombe,11)

omit_ans <- na.omit(anscombe)
head(omit_ans)

##mice插值法：
#感觉不大常用，pass
