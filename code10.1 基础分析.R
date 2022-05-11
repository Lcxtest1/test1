# 设置工作目录
setwd("H:/R大作业")

# 统计车龄与售出额####
info <- read.csv("H:/R大作业/train.csv")  # 导入数据
summary(info)
head(info)
hotinfo<- data.frame(table(info[,1])) 
hotli<- data.frame(table(info[,2]))
View(hotinfo)
View(hotli)
colnames(hotinfo) <- c("Car_name", "sale") # 修改列名
colnames(hotli) <- c("year", "Num")
# 导出不同车龄与销售额之间的关系
write.csv(hotinfo, "H:/R大作业/hotinfo.csv", row.names = FALSE)
write.csv(hotli, "H:/R大作业/hotli.csv", row.names = FALSE)
# 每日用餐人数折线图
#sale$date <- as.POSIXct(sale$date)  # 将date字段转换时间格式，在本例中前面已有as.Date，不必要
#R语言的基础包中提供了两种类型的时间数据，一类是Date日期数据，它不包括时间和时区信息，
#另一类是POSIXct/POSIXlt类型数据，其中包括了日期、时间和时区信息。
#日期data，存储的是天；时间POSIXct 存储的是秒，POSIXlt 打散，年月日不同
plot(hotinfo$Car_name,hotinfo$sale,
     col = "orange",type="b",xlab = "车龄",ylab = "销售量")
png(file = "rainfall.png")
plot(hotli$year, hotli$Num, col = "orange", type="b", 
     xlab = "车龄", ylab = "销售量")

# 求出每种车型的热销度
sales_formula <- (hotinfo$sale - min(hotinfo$sale)) /
  (max(hotinfo$sale) - min(hotinfo$sale))
hotinfo$Percent <- round(sales_formula, 3)  # 保留3位小数

# 查看热销度最高和最低的菜品
hotinfo[which(hotinfo$Percent == max(hotinfo$Percent)), ]
hotinfo[which(hotinfo$Percent == min(hotinfo$Percent)), ]

# 画出热销度最高的前10个菜品的条形图
# 按热销度进行排序
hotinfo <- hotinfo[order(hotinfo$Percent, decreasing = TRUE), ]
barplot(hotinfo[1:10, 3],names.arg = hotinfo$Car_name[1:10], 
        xlab = "品牌名称", ylab = "热销度", col = "blue",
        main="热销度前10的二手车品牌",border="white",yaxt = "n")
write.csv(hotinfo, "H:/R大作业//hotinfo.csv", row.names = FALSE)  # 导出数据

