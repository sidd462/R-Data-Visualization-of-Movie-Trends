#https://www.superdatascience.com/pages/rcourse
#getwd()
setwd()
#getwd()

df<-read.csv('*****',stringsAsFactors = T)
head(df)
nrow(df)
colnames(df)
summary(df)
str(df)

colnames(df)<-c('Film','Genre','CriticRating','AudienceRating','BugetMillions','Year')
head(df)
tail(df)
str(df)
summary(df)

movies<-df
rm(df)
head(movies)

summary(movies)
movies$Year<-factor(movies$Year)#important as year is categorical
summary(movies)

#------------------------------- Aesthetics

library(ggplot2)

#add geometry
ggplot(data=movies,aes(x=movies$CriticRating,y=movies$AudienceRating))+geom_point()

#add colour
ggplot(data=movies,aes(x=movies$CriticRating,y=movies$AudienceRating,colour=Genre))+geom_point()

#add size
ggplot(data=movies,aes(x=movies$CriticRating,y=movies$AudienceRating,colour=Genre,size=movies$BugetMillions))+geom_point()

#geom types
ggplot(data=movies,aes(x=movies$CriticRating,y=movies$AudienceRating,colour=Genre,size=movies$BugetMillions))+geom_point()+geom_area()

#------------------------------- plotting with layer
p<-ggplot(data=movies,aes(x=movies$CriticRating,y=movies$AudienceRating,colour=Genre,size=movies$BugetMillions))


p+geom_area(size=1)
p+geom_boxplot()+geom_line(linetype="dashed", color="blue", size=1.2,alpha=0.2)


p + geom_line()+geom_point()

#------------------------------- overiding aesthetics
q<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,
                          colour=Genre,size=BugetMillions))

q+geom_point()

#overiding
q+geom_point(aes(size=CriticRating))
q+geom_point(aes(colour=BugetMillions))

q+geom_point(aes(x=BugetMillions))+ xlab('budget millions')


q+geom_line(size=1)+geom_point()#no need for aes as mapping vs setting

#-----------------------------------mapping vs setting

r<-ggplot(data = movies,aes(x=CriticRating,y=AudienceRating))
r+geom_point()

#add color
#1 Mapping (what we have done so far)
r+geom_point(aes(colour=Genre))

#2 setting
r+geom_point(colour='DarkGreen')

#ERROR
r+geom_point(aes(colour='DarkGreen'))#it takes DarkGreen as a entity

#1.Mapping
r+geom_point(aes(size=BugetMillions))

#2 Setting
r+geom_point(size=8)

#ERROR
r+geom_point(aes(size=10))

#----------------------------------- Histograms and probability density charts

s<-ggplot(data=movies,aes(x=BugetMillions))
s+geom_histogram(binwidth = 10)

#add color
s+geom_histogram(binwidth = 10,aes(fill=Genre))
#add a border
s+geom_histogram(binwidth = 10,aes(fill=Genre),colour='Black')

#density Chart
s+geom_density()+ylab('probability density')
s+geom_density(aes(fill=Genre))+ylab('probability density')
s+geom_density(aes(fill=Genre),position = 'stack')+ylab('probability density')

#----------------------------------- Starting layer tips
t<-ggplot(data=movies,aes(x=AudienceRating))
t+geom_histogram(binwidth = 10,fill='white',colour='blue')

#another way and quite powerful way as you can you another dataset for x or y

t<-ggplot(data = movies)
t+geom_histogram(binwidth = 10,aes(x=AudienceRating),fill="blue",colour='black',size=1.5)

#>>

#----- staticstical Transformation
u<- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))

u+geom_point()+geom_smooth(fill=NA)

#box plots

u<-ggplot(data=movies,aes(x=Genre,y=AudienceRating,colour=Genre))
u+geom_boxplot()
u+geom_boxplot(size=1.2)


u+geom_boxplot(size=1.2) + geom_point()


u+geom_boxplot(size=1.2) + geom_jitter()

u+geom_jitter() + geom_boxplot(size=1.2) 

u+geom_jitter() + geom_boxplot(size=1.2,alpha=0.6) 

#---------------------- using facets

v<- ggplot(data=movies,aes(x=BugetMillions))
v+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")

#facets

v+geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black") + 
  facet_grid(Genre~.,scales='free')

w<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,colour=Genre))
w+geom_point(size=3)

w+geom_point(size=3)+facet_grid(Genre~.)

w+geom_point(size=3)+facet_grid(.~Year) #vertical

w+geom_point(size=3)+facet_grid(Genre~Year) #matrix

w+geom_point(aes(size=(BugetMillions)))+geom_smooth()+facet_grid(Genre~Year) #matrix


# limits
# zoom

m<- ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,size=BugetMillions,colour=Genre))
m+geom_point()

m+geom_point()+xlim(50,100)+ylim(50,100)


# wont work well always

n<-ggplot(data=movies,aes(x=BugetMillions))
n+geom_histogram(binwidth = 10,aes(fill=Genre),colour='black')

n+geom_histogram(binwidth = 10,aes(fill=Genre),colour='black')+xlim(50,100)+ylim(0,50) #cutting out the data

#instead zoom
n+geom_histogram(binwidth = 10,aes(fill=Genre),colour='black')+coord_cartesian(ylim =c(0,50)) #better way of zooming into a graph

w+geom_point(aes(size=(BugetMillions)))+geom_smooth()+facet_grid(Genre~Year) 

w+geom_point(aes(size=(BugetMillions)))+geom_smooth()+facet_grid(Genre~Year)+coord_cartesian(ylim = c(0,100)) 


#------------ Theme
o<-ggplot(data=movies,aes(x=BugetMillions))

o+geom_histogram(binwidth = 10,aes(fill=Genre),colour='black')

h<-o+geom_histogram(binwidth = 10,aes(fill=Genre),colour='black')

# labels
h+xlab('money axis') + ylab('Number of movies')

# label formating

h+xlab('money axis') + ylab('Number of movies')+theme(axis.title.x = element_text(colour='lightgreen',size=20),
                                                      axis.title.y = element_text(colour='lightgreen',size=20),
                                                                                  axis.text.x=element_text(size=20),
                                                                                  axis.text.y=element_text(size=20))

?theme

#legend formating theme
h+ggtitle('Movies Budget Distribution')+xlab('money axis') + ylab('Number of movies')+theme(axis.title.x = element_text(colour='lightgreen',size=20),
                                                      axis.title.y = element_text(colour='lightgreen',size=20),
                                                      axis.text.x=element_text(size=20),
                                                      axis.text.y=element_text(size=20),
                                                      legend.title = element_text(size=10),
                                                      legend.text = element_text(size=10),
                                                      legend.position = c(1,1),
                                                      legend.justification = c(1,1),
                                                      plot.title = element_text(colour ="red",
                                                                                size=20,
                                                                                family='courier',
                                                                                hjust = 0.5))#center alignment


