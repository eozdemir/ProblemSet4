rm(list=ls())
setwd("/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4")

## Section A

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
dump(Globs, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Globals.R")

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
write.csv(TurtDistricts, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Districts.csv")
write.csv(TurtVoters, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Voters.csv")
write.csv(TurtActivists, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Activists.csv")
write.csv(TurtParties, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Parties.csv")
write.csv(TurtCands, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/Candidates.csv")

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
write.csv(D1Data, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/D1.csv") 
write.csv(D2Data, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/D2.csv") 
write.csv(D3Data, file="/Users/elifozdemir/Desktop/WashU 1.2/R Programming/Problem Sets/ProblemSet4/D3.csv") 

#Plot of average positions for each dimension
pdf("Positions.pdf")
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
plot(NULL, xlim=c(0,4), ylim=c(-13.5,12.1), axes=T, ylab="Positions", xlab="Index", main="Positioning on Dimension 2")
points(RedCand2, col="red", pch=19)
points(BlueCand2, col="blue", pch=19)
points(2, RedVoter2, col="red", pch=23)
points(2, BlueVoter2, col="blue", pch=23)
points(3, RedAct2, col="red", pch=22)
points(3, BlueAct2, col="blue", pch=22)

#D3
RedCand3  <- mean(as.numeric(as.character(D3Data$Red_y)), na.rm=TRUE)
BlueCand3 <- mean(as.numeric(as.character(D3Data$Blue_y)), na.rm=TRUE)
RedVoter3 <- mean(as.numeric(as.character(D3Data$RedVoters_y)), na.rm=TRUE)
BlueVoter3<- mean(as.numeric(as.character(D3Data$BlueVoters_y)), na.rm=TRUE)
RedAct3   <- mean(as.numeric(as.character(D3Data$RedActivists_y)), na.rm=TRUE)
BlueAct3  <- mean(as.numeric(as.character(D3Data$BlueActivists_y)), na.rm=TRUE)
plot(NULL, xlim=c(0,4), ylim=c(-8,8), axes=T, ylab="Positions", xlab="Index", main="Positioning on Dimension 3")
points(RedCand3, col="red", pch=19)
points(BlueCand3, col="blue", pch=19)
points(2, RedVoter3, col="red", pch=23)
points(2, BlueVoter3, col="blue", pch=23)
points(3, RedAct3, col="red", pch=22)
points(3, BlueAct3, col="blue", pch=22)
legend()
dev.off()

#####Winners Plot
