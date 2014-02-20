rm(list=ls())
setwd("/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4")

## Section A
#First, I need to create the directories where I will write out the csv files and pdf plots.
TopDirectory <- scan("NetLogo.csv", skip=1, nlines=2, what=" ", sep="\n") #read the two rows of file information at the beginning of NetLogo file 
#Clean the name/date information before creating the top level directory
#Get rid of the commas after info
TopDirectory<- gsub(",","", TopDirectory)
#Get rid of the slashes in date
TopDirectory<- gsub("/", "-", TopDirectory)
#Get rid of the colons in time
TopDirectory<- gsub(":", ".", TopDirectory)
#Merge all info in the same vector
TopDirectory<- paste(TopDirectory, collapse="_")

#Create the top level directory
dir.create(file.path(TopDirectory))

#Create the sub-directories of Globals, Turtles, Plots
sapply(X=c("Globals", "Turtles", "Plots"), FUN=function(X){dir.create(file.path(TopDirectory,X))})

#Create the sub-directories under Plots
sapply(X=c("PositionPlot", "WinnersPlot", "PolarizationPlot", "IncumbentPercentagePlot"), FUN=function(X){dir.create(file.path(TopDirectory, "Plots", X))})

####Globals
Globals <- scan("NetLogo.csv", skip=8, nlines=2, what=" ", sep="\n") #read the two rows of global 
GlobNames <- strsplit(Globals[1], split=",") #store the first row as Global names and split the cells
GlobNames <- as.list(GlobNames[[1]]) #reach the items in first row and make a list from
length(GlobNames) #see the length of list to check if its the same with number of cells in csv file (84)
GlobVals.temp <- paste(Globals[2], sep=",") #merge into a temporary item to use gsub
GlobVals.temp<- gsub("\\[|\\]", "", GlobVals.temp) #remove the brackets
GlobVals <- strsplit(GlobVals.temp, split=",") #store the second row as Global values and split the cells
length(GlobVals[[1]]) #check before merging these two rows in a list of Globals together
class(GlobVals[[1]]) 
class(GlobNames[[1]]) #they are of the same class
Globs<- GlobNames #generate Globs to store both info in an item 
for (i in 1:length(GlobNames)) {
  Globs[[i]] <- append(GlobNames[[i]], GlobVals[[1]][i])
}
head(Globs) #see the first few items of Globs
Globs[[84]] #check one of the indices to make sure how to access
#write out R file
dump("Globs", file=file.path(TopDirectory, "Globals", "Globals.R"))

####Turtles
Turtles<- scan("NetLogo.csv", skip=12, nlines=4787, what=" ", sep=",") #scan the turtles data into 
Turts<- matrix(Turtles, nrow=4787, byrow=TRUE) #convert into matrix by row
str(Turts)
TurtNames<- Turts[1, ] #store the names seperately
TurtData<- data.frame(Turts[-1, ]) #rest is the dataframe of Turtles
colnames(TurtData)<- TurtNames #give the variable names to columns
head(TurtData)
index<- which(TurtNames=="my-voters-district")+1 #the last meaningful column+1
TurtData<- TurtData[,-c(index:length(TurtNames))] #remove the meaningless columns after my-voters-district variable
#Districts
TurtDistricts<- TurtData[TurtData$breed=="{breed districts}", ] #a subset of only breed districts
table(TurtDistricts$breed) #check if only districts
#Voters
TurtVoters<- TurtData[TurtData$breed=="{breed voters}", ] #a subset of only breed voters
table(TurtVoters$breed) #check if only voters
#Activists
TurtActivists<- TurtData[TurtData$breed=="{breed activists}", ] #a subset of only breed activists
table(TurtActivists$breed) #check if only activists
#Parties
TurtParties<- TurtData[TurtData$breed=="{breed parties}", ] #a subset of only breed parties
table(TurtParties$breed) #check if only parties
#Candidates
TurtCands<- TurtData[TurtData$breed=="{breed cands}", ] #a subset of only breed candidates
table(TurtCands$breed) #check if only candidates

#write out csv files
write.csv(TurtDistricts, file=file.path(TopDirectory, "Turtles" ,"Districts.csv"))
write.csv(TurtVoters, file=file.path(TopDirectory, "Turtles" ,"Voters.csv"))
write.csv(TurtActivists, file=file.path(TopDirectory, "Turtles" ,"Activists.csv"))
write.csv(TurtParties, file=file.path(TopDirectory, "Turtles" ,"Parties.csv"))
write.csv(TurtCands, file=file.path(TopDirectory, "Turtles" ,"Candidates.csv"))

####Plots
####Position Plot
#D1
PlotD1<- scan("NetLogo.csv", skip=8545, nlines=170, what=" ", sep=",") #scan D1 data 
PlotD1<- matrix(PlotD1, nrow=170, byrow=TRUE) #convert into matrix by row
str(PlotD1)
D1Names<- PlotD1[1, ] #store the names seperately
D1Names<- unique(D1Names)
str(D1Names) #there is an extra 5th name I don't know why but I will remove it
D1Names<- D1Names[-5]
D1Names<- paste(rep(c("Red","Blue", "RedActivists", "RedVoters", "BlueVoters", "BlueActivists"), each=4), "_", D1Names, sep="")  
D1Names
D1Data<- data.frame(PlotD1[-1, ]) #rest is the dataframe of D1
colnames(D1Data)<- D1Names #give the variable names to columns
str(D1Data)  #gives us 84 variables instead of 24
D1Data<- D1Data[ ,-c(25:84)] #eliminate the uninformative part

#D2
PlotD2<- scan("NetLogo.csv", skip=8729, nlines=170, what=" ", sep=",") #scan D2 data 
PlotD2<- matrix(PlotD2, nrow=170, byrow=TRUE) #convert into matrix by row
str(PlotD2)
D2Names<- PlotD2[1, ] #store the names seperately
D2Names<- unique(D2Names)
str(D2Names) #there is an extra 5th name I don't know why but I will remove it
D2Names<- D2Names[-5]
D2Names<- paste(rep(c("Red","Blue", "RedActivists", "RedVoters", "BlueVoters", "BlueActivists"), each=4), "_", D2Names, sep="")  
D2Names
D2Data<- data.frame(PlotD2[-1, ]) #rest is the dataframe of D1
colnames(D2Data)<- D2Names #give the variable names to columns 
str(D2Data)
D2Data<- D2Data[ ,-c(25:84)] #eliminate the uninformative part

#D3
PlotD3<- scan("NetLogo.csv", skip=8913, nlines=170, what=" ", sep=",") #scan D3 data 
PlotD3<- matrix(PlotD3, nrow=170, byrow=TRUE) #convert into matrix by row
str(PlotD3)
D3Names<- PlotD3[1, ] #store the names seperately
D3Names<- unique(D3Names)
str(D3Names) #there is an extra 5th name I don't know why but I will remove it
D3Names<- D3Names[-5]
D3Names<- paste(rep(c("Red","Blue", "RedActivists", "RedVoters", "BlueVoters", "BlueActivists"), each=4), "_", D3Names, sep="")  
D3Names
D3Data<- data.frame(PlotD3[-1, ]) #rest is the dataframe of D1
colnames(D3Data)<- D3Names #give the variable names to columns 
str(D3Data)
D3Data<- D3Data[ ,-c(25:84)] #eliminate the uninformative part

#write out csv files
write.csv(D1Data, file=file.path(TopDirectory, "Plots","PositionPlot" ,"D1.csv")) 
write.csv(D2Data, file=file.path(TopDirectory, "Plots","PositionPlot" ,"D2.csv")) 
write.csv(D3Data, file=file.path(TopDirectory, "Plots","PositionPlot" ,"D3.csv")) 

#Plot of average positions for each dimension
pdf(file.path(TopDirectory,"Plots","PositionPlot","Positions.pdf"))
par(mfrow=c(1,3))
#D1 averages
RedCand1  <- mean(as.numeric(as.character(D1Data$Red_y)), na.rm=TRUE)
BlueCand1 <- mean(as.numeric(as.character(D1Data$Blue_y)), na.rm=TRUE)
RedVoter1 <- mean(as.numeric(as.character(D1Data$RedVoters_y)), na.rm=TRUE)
BlueVoter1<- mean(as.numeric(as.character(D1Data$BlueVoters_y)), na.rm=TRUE)
RedAct1   <- mean(as.numeric(as.character(D1Data$RedActivists_y)), na.rm=TRUE)
BlueAct1  <- mean(as.numeric(as.character(D1Data$BlueActivists_y)), na.rm=TRUE)
D1.mat<- matrix(c(RedCand1, BlueCand1, RedVoter1, BlueVoter1, RedAct1, BlueAct1), byrow=FALSE, nrow=2)
rownames(D1.mat)<- c("Red", "Blue")
colnames(D1.mat)<- c("Candidates", "Voters", "Activists")
dotchart(D1.mat,
         xlim=c(-8,8), # The limits for the x-axis
         xlab="Positions",
         main="Positioning on D1",
         pch = 19, color=rep(c("red", "blue"),3)) 

#D2
RedCand2  <- mean(as.numeric(as.character(D2Data$Red_y)), na.rm=TRUE)
BlueCand2 <- mean(as.numeric(as.character(D2Data$Blue_y)), na.rm=TRUE)
RedVoter2 <- mean(as.numeric(as.character(D2Data$RedVoters_y)), na.rm=TRUE)
BlueVoter2<- mean(as.numeric(as.character(D2Data$BlueVoters_y)), na.rm=TRUE)
RedAct2   <- mean(as.numeric(as.character(D2Data$RedActivists_y)), na.rm=TRUE)
BlueAct2  <- mean(as.numeric(as.character(D2Data$BlueActivists_y)), na.rm=TRUE)
D2.mat<- matrix(c(RedCand2, BlueCand2, RedVoter2, BlueVoter2, RedAct2, BlueAct2), byrow=FALSE, nrow=2)
rownames(D2.mat)<- c("Red", "Blue")
colnames(D2.mat)<- c("Candidates", "Voters", "Activists")
dotchart(D2.mat,
         xlim=c(-13.5,12.1), # The limits for the x-axis
         xlab="Positions",
         main="Positioning on D2",
         pch = 19, color=rep(c("red", "blue"),3)) 

#D3
RedCand3  <- mean(as.numeric(as.character(D3Data$Red_y)), na.rm=TRUE)
BlueCand3 <- mean(as.numeric(as.character(D3Data$Blue_y)), na.rm=TRUE)
RedVoter3 <- mean(as.numeric(as.character(D3Data$RedVoters_y)), na.rm=TRUE)
BlueVoter3<- mean(as.numeric(as.character(D3Data$BlueVoters_y)), na.rm=TRUE)
RedAct3   <- mean(as.numeric(as.character(D3Data$RedActivists_y)), na.rm=TRUE)
BlueAct3  <- mean(as.numeric(as.character(D3Data$BlueActivists_y)), na.rm=TRUE)
D3.mat<- matrix(c(RedCand3, BlueCand3, RedVoter3, BlueVoter3, RedAct3, BlueAct3), byrow=FALSE, nrow=2)
rownames(D3.mat)<- c("Red", "Blue")
colnames(D3.mat)<- c("Candidates", "Voters", "Activists")
dotchart(D3.mat,
         xlim=c(-8,8), # The limits for the x-axis
         xlab="Positions",
         main="Positioning on D3",
         pch = 19, color=rep(c("red", "blue"),3)) 
dev.off()

#####Winners Plot
Winners<- scan("NetLogo.csv", skip=9139, nlines=170, what=" ", sep=",") #winners data 
Winners<- matrix(Winners, nrow=170, byrow=TRUE) #convert into matrix by row
str(Winners)
WinNames<- Winners[1, ] #store the names seperately
WinNames<- unique(WinNames)
str(WinNames) #there is an extra 5th name I don't know why but I will remove it
WinNames<- WinNames[-5]
WinNames<- paste(rep(c("Blue", "Fifty", "Red"), each=4), "_", WinNames, sep="")  
WinNames
Winners<- data.frame(Winners[-1, ]) #rest is the dataframe of winners
colnames(Winners)<- WinNames #give the variable names to columns 
str(Winners)
Winners<- Winners[ ,-c(13:length(Winners))] #eliminate the uninformative part

#write out csv file
write.csv(Winners, file=file.path(TopDirectory,"Plots","WinnersPlot","Winner.csv")) 

#Winners percentages
time<- Winners$Blue_x #time period
RedWin<- Winners$Red_y #win % of red cands
BlueWin<- Winners$Blue_y #win % of blue cands
#converting factors
time<- as.numeric(as.character(time)) 
BlueWin<- as.numeric(as.character(BlueWin))
time<- as.numeric(as.character(time))

#Winners plot
pdf(file.path(TopDirectory,"Plots","WinnersPlot","Winner.pdf"))
par(mfrow=c(1,1))
plot(NULL, type="l", xlim=c(min(time), max(time)), ylim=c(20,70), xlab= "Time Period", ylab="Percent", main="What % of Candidates Won")
lines(time, RedWin, lty=1, col="red")
lines(time, BlueWin, lty=1, col="blue")
dev.off()

#####Polarization Plot
Polar<- scan("NetLogo.csv", skip=9320, nlines=170, what=" ", sep=",") #polarization data 
Polar<- matrix(Polar, nrow=170, byrow=TRUE) #convert into matrix by row
str(Polar)
PolarNames<- Polar[1, ] #store the names seperately
PolarNames<- unique(PolarNames)
str(PolarNames) #there is an extra 5th name I don't know why but I will remove it
PolarNames<- PolarNames[-5]
PolarNames<- paste(rep(c("Total", "Voters", "Activists"), each=4), "_", PolarNames, sep="")  
PolarNames
Polar<- data.frame(Polar[-1, ]) #rest is the dataframe of polarization data
colnames(Polar)<- PolarNames #give the variable names to columns 
str(Polar)
Polar<- Polar[ ,-c(13:length(Polar))] #eliminate the uninformative part

#write out csv file
write.csv(Polar, file=file.path(TopDirectory, "Plots","PolarizationPlot" ,"Polarization.csv")) 

#converting factors
CandPol<- as.numeric(as.character(Polar$Total_y)) #total refers to candidates
VotersPol<- as.numeric(as.character(Polar$Voters_y))
ActPol<- as.numeric(as.character(Polar$Activists_y))
time<- as.numeric(as.character(Polar$Total_x))

#polarization plot
PolarPlot<- c(CandPol,VotersPol,ActPol)
PolarPlot<- as.data.frame(matrix(PolarPlot, ncol=1))
colnames(PolarPlot)<- c("pol")
PolarPlot$type<- as.factor(c(rep("Candidates", length(CandPol)), rep("Voters", length(VotersPol)), rep("Activists", length(ActPol))))
PolarPlot$time<- c(rep(time, 3))
#I will divide time periods into 2 to see a more meaningful graph of change in polarization in time rather than in each period. It is possible to increase the number of time periods.
PolarPlot$time[PolarPlot$time<80]<- 1
PolarPlot$time[PolarPlot$time>=80]<- 2
head(PolarPlot)
tail(PolarPlot)

#Polarization plot
pdf(file.path(TopDirectory,"Plots","PolarizationPlot","PolarizationPlot.pdf"))
par(mfrow=c(1,1))
boxplot(PolarPlot$pol~ PolarPlot$type+PolarPlot$time, xlab="Past vs. Recent", ylab="Polarization level", main="Change in Polarization", ylim=c(0,9), col=c(rep("orange",3), rep("purple", 3)))
legend("topright",
       legend=c("Past", "Recent"), 
       lty=c(1,1),
       pch=22,
       col=c("orange", "purple"),
       title=" ")
dev.off()

######Incumbent Plot
Incumbent<- scan("NetLogo.csv", skip=9499, nlines=170, what=" ", sep=",") #incumbent data 
Incumbent<- matrix(Incumbent, nrow=170, byrow=TRUE) #convert into matrix by row
str(Incumbent)
IncNames<- Incumbent[1, ] #store the names seperately
IncNames<- unique(IncNames)
str(IncNames) #there is an extra 5th name I don't know why but I will remove it
IncNames<- IncNames[-5]  
IncNames
Incumbent<- data.frame(Incumbent[-1, ]) #rest is the dataframe of incumbents
colnames(Incumbent)<- IncNames #give the variable names to columns 
str(Incumbent)
Incumbent<- Incumbent[ ,-c(5:length(Incumbent))] #eliminate the uninformative part

#write out csv file
write.csv(Incumbent, file=file.path(TopDirectory, "Plots","IncumbentPercentagePlot" ,"IncumbentsWin.csv")) 

#Incumbent percentages
time<- Incumbent$x #time period
IncWin<- Incumbent$y #win % of incumbents

#converting factors
time<- as.numeric(as.character(time)) 
IncWin<- as.numeric(as.character(IncWin))

#Incumbent plot
pdf(file.path(TopDirectory, "Plots","IncumbentPercentagePlot","IncumbentWins.pdf"))
par(mfrow=c(1,1))
plot(NULL, type="l", xlim=c(10, max(time)), ylim=c(40,70), xlab= "Time Period", ylab="Percent", main="What % of Incumbents Won")
lines(time, IncWin, lty=1, col="purple")
dev.off()


#####JMR Chapter 4
###Question 3
squareCubeFun<- function(n){
  number<- 1:n #vector of the given number
  square<- number^2 #vector of the given number's squares
  cube<- number^3 #vector of the given number's cubes
  matrix<- cbind(number, square, cube) #put them together
  #the question asks us to output this table
  write.table(matrix, file="SquareCubeTable.txt")
  return(matrix)
}
squareCubeFun(7) #lets try 7 as it was given in the example to see it works

###Question 4
mTableFun<- function(){
  mtable<- matrix(rep(0, 81), nrow=9) #generate the mtable full of 0s
  for(i in 1:9){
    mtable[i, ]<- i*(1:9) #multiply 1:9 with itself by this for loop
  }
  show(mtable) #code recommended in the question
  #the question asks us to output this table
  write.table(mtable, file="MultiplicationTable.txt") 
}
mTableFun() #see it works

#####JMR Chapter 7
###Question 3
install.packages("lattice")
library(lattice)
#population generated
pop <- data.frame(m = rnorm(100, 160, 20), f = rnorm(100, 160, 20))
#function for creating next generation
next.gen <- function(pop) {
  pop$m <- sample(pop$m)
  pop$m <- apply(pop, 1, mean)
  pop$f <- pop$m
  return(pop)
}

#generate 9 generations data
maleHeightData<- NULL
for(i in 1:9){
  maleHeight<- data.frame(next.gen(pop)[,1], rep(i,100)) #draws a sample every time in the loop and assigns a generation to it
  maleHeightData<- rbind(maleHeightData, maleHeight) #collects all 9 generations in a dataframe
}
colnames(maleHeightData)<- c("height", "generation") #for height and generation
#histogram as in the chapter
histogram(~ height | generation, data=maleHeightData, xlab="male height", main="Distribuion of Male Height over Generations")

###Question 4
install.packages("spuRs")
library(spuRs)
data(treeg)
head(treeg)
xyplot(height.ft~age|tree.ID, data=treeg, type="l", xlab="age(years)", ylab="height(feet)")

##ps: The lattice library doesn't seem to work on my computer, gives error. So I just wrote the code for last 2 plots from what I found from the JMR examples but I don't know if they work/not.
