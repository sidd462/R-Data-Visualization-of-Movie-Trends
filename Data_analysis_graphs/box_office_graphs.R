getwd()
setwd("/Users/siddharth/Desktop/R/datasets")
mov <- read.csv("Section6-Homework-Data.csv")

#Data Exploration
head(mov) #top rows
colnames(mov) #column summaries
summary(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library(ggplot2)

#{Offtopic} This Is A Cool Insight:
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
#Notice? No movies are released on a Monday. Ever.

#Genres and Studios that we are interested in
#We will start with the Genre filter and use the Logical 'OR'
#operator to select multiple Genres:
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Now let's do the same for the Studio filter:
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio== "WB") | (mov$Studio== "Fox") | (mov$Studio== "Universal") | (mov$Studio== "Sony") | (mov$Studio== "Paramount Pictures")
  
#Apply the row filters to the dataframe
mov2 <- mov[filt & filt2,]

#Prepare the plot's data and aes layers
#Note we did not rename the columns. 
#Use str() or summary() to fin out the correct column names
str(mov2)
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p + geom_jitter(aes(colour=IMDb.Rating))+ geom_boxplot(alpha=0.7) 

p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p + geom_jitter(aes(size=Budget...mill.,colour=IMDb.Rating))+ geom_boxplot(alpha=0.7) 

p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p + geom_jitter(aes(size=Budget...mill.,colour=Studio))+ geom_boxplot(alpha=0.7) 

p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))
p + geom_jitter(aes(size=Budget...mill.,colour=Studio))+ geom_boxplot(alpha=0.7,outlier.colour = NA) 

q<-p + geom_jitter(aes(size=Budget...mill.,colour=Studio))+ geom_boxplot(alpha=0.7,outlier.colour = NA) 


q<-q+
  xlab('Genre')+
  ylab('Gross % US')+
  ggtitle('Domestic Gross % by Genre')
q

#theme

q<-q+
  theme(
    axis.title.x = element_text(colour = "grey",size = 20), 
    axis.title.y = element_text(colour = "grey",size = 20),
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),
    #legend.title = element_text(size=10),
    #legend.text = element_text(size=10),
    #legend.position = c(1,1),
    #legend.justification = c(1,1),
    plot.title = element_text(colour ="red",
                              size=20,
                              family='courier',
                              hjust = 0.5),#center alignment
    text=element_text(family = 'courier')#applies text formatting to whole chart instead of individual elements/layers
    )


q


#Final touch. 
#However this is how you can change individual legend titles:
q$labels$size = "Budget $M"
q
