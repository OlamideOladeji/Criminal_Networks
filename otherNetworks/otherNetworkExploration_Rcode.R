setwd("/Users/Ola/Documents/R/Pset5")
rm(list=ls())
cooffending <- read.csv("Anonymous.csv")

#Q5.1A - how many data points, or cases? 
#1280459 observations of 15 variables


#5.1B - how many different offenders are there? 
length(unique(cooffending$NoUnique))
#539593 unique offenders

#5.1C - how many different crime events are there? 
#How many different crime events are there, per year, each year from 2003-2010? 
#what is the difference between "crime events" and "data points or cases" in QA and QC?
length(unique(cooffending$SeqE))
#1164836 different crime events
crime<-rep(c(0),8)
casebyyear <- 0
for(i in 2003:2010){
  casebyyear <- cooffending$SeqE[cooffending$annee==i]
  crime[i-2002] <- length(unique(casebyyear))
}

sum(crime)
annualcrime <- data.frame(crime,row.names = c(2003:2010))

#5.1D - which crime(s) involved the greatest number of offenders? List the crimes, the number of offenders involved, and where it happened? 
crimes<-data.frame(table(cooffending$SeqE))
#Crime Event: 156 offenders were involved in the crime number 27849.
#figure out this command
cooffending$MUN(cooffending$SeqE==27849)
#Municipality: 66023

#5.2A
#Build co-offender matrix (sparse)
#cooffending <- cooffending[!(duplicated(cooffending))]
cooffending <- unique(cooffending)
library(Matrix)


#remove the isolated notes after from igraph
A <- sparseMatrix(i = cooffending$NoUnique, 
                  j = cooffending$SeqE, 
                  x = rep(1,length(cooffending$NoUnique)))
C <- A%*%t(A)
#diag(C) <- 0 #make diagonal elements of cooffending matrix 0
library(igraph)

graph_C <- graph_from_adjacency_matrix(C, diag=FALSE, weighted=TRUE, mode="undirected")%>%
  set_vertex_attr("label", value=c(1:670536))

#vertex_attr(graph_C, "label")
#get.vertex.attribute(graph_C, "label", index=V(graph_C)[24])
deg<-degree(graph_C)
d<-which(deg<1) #filtering out those with degree < 1 
#size = 549377 elements
graph_C_filt<-delete_vertices(graph_C, d)
vertex_attr(graph_C_filt, "label")
vcount(graph_C_filt)
#121159 nodes

#the commands above basically do what we tried to here, but more effectively and accurately
#C_filtered <- C[-c(d),] 
#C_filtered <- C_filtered[,-c(d)] #we filtered out the nodes with degree < 2 
#graph_C_filt <- graph_from_adjacency_matrix(C_filtered)
#nrow(C_filtered)
#121159 nodes?

length(d) 
#549377 number of solo offenders 


ecount(graph_C_filt)
#178413

#5.2B - come back to fixing x-axis labeling 
library(ggplot2)
degdee<-degree_distribution(graph_C_filt)
barplot(degdee, main = "Degree Distribution")
length(degdee) #228 is the length

#5.2C - number of connected components in network? 
large <- components(graph_C_filt)
#36098 connected components 

#5.2D - how many nodes does the largest connected component have? 
a=large$csize
largest<-max(large$csize) 
which(a==largest) 
#19924 nodes for the largest connected component 

#Q5.3A - isolate now just on the 19924 people & find five nodes with highest degree
dg <- decompose.graph(graph_C_filt)
length(dg)
largest_subgraph <- dg[[1]]
degnew<-degree(largest_subgraph)
sort(degnew, decreasing=TRUE)
#227 202 196 180 177 -- these are the five highest degrees
#C_fake <- A%*%t(A) #go back to original matrix to see which deg's align with what node
#diag(C_fake) <- 0 
#graph_C_fake <- graph_from_adjacency_matrix(C_fake)
#deg_fake<-degree(graph_C_fake)
#sort(deg_fake, decreasing=TRUE) #same deg at the top of original matrix as with filtered one

d_1<-which(degnew==227) 
d_2<-which(degnew==202) 
d_3<-which(degnew==196) 
d_4<-which(degnew==180) 
d_5<-which(degnew==177) 

get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[618]) #112701
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[d_2]) #450815
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[d_3]) #332188
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[d_4]) #94201
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[d_5]) #395620
degdee2<-degree_distribution(largest_subgraph)
barplot(degdee2, main = "Degree Distribution of Largest Connected Component")
hist(degdee2, main="Degree Distribution of Largest Connected Component", breaks=569)

#Q5.3B
bet<-betweenness(largest_subgraph)
asdf_subgraph<-sort(bet, decreasing=TRUE)
#32245319.8 28561881.9 25466866.8 18903383.9 16773611.7 16685910.7 - these are the top five
bet_fake<-betweenness(graph_C_fake)
asdf=sort(bet_fake, decreasing=TRUE) #check to see if the same between. measures come up in original matrix

b_1<-which(bet==asdf_subgraph[1]) #581980
b_2<-which(bet==asdf_subgraph[2]) #560300
b_3<-which(bet==asdf_subgraph[3]) #494459
b_4<-which(bet==asdf_subgraph[4]) #573726
b_5<-which(bet==asdf_subgraph[5]) #
b_6<-which(bet==asdf_subgraph[6]) #

get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_1]) #560300
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_2]) #581980
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_3]) #494459
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_4]) #457352
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_5]) #593471
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[b_6]) #573726

barplot(bet, main="Betweenness Centrality of Largest Connected Component", ylab="Betweenness Values", xlab="Node")
hist(bet, main="Betweeness Centrality of Largest Connected Component", breaks=100, xlab="Betweenness Centrality Values")

#Q5.3C
eig<-eigen_centrality(largest_subgraph)
eig_sub<-sort(eig$vector, decreasing=TRUE)
#1.000000e+00 1.000000e+00 9.890262e-01 9.889840e-01 9.888417e-01 9.888417e-01

e<-eig$vector

c_1<-which(e==eig_sub[1]) 
c_2<-c_1[2]
c_1<-c_1[1]
c_3<-which(eig$vector==eig_sub[3]) 
c_4<-which(eig$vector==eig_sub[4]) 
c_5<-which(eig$vector==eig_sub[5]) 
c_6<-which(eig$vector==eig_sub[6])

get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_1]) #174156
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_2]) #222404
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_3]) #111811
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_4]) #250291
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_5]) #185496
get.vertex.attribute(largest_subgraph, "label", index=V(largest_subgraph)[c_6]) #289878



barplot(eig$vector, main="Eigenvector Centrality of Largest Connected Component", ylab="Eigenvector Centrality Values", xlab="Node")
hist(eig$vector, main="Eigenvector Centrality of Largest Connected Component", breaks=100,  xlab="Eigen Centrality Values")

#5.3E
den<-edge_density(largest_subgraph)   #0.0003556455
diam<-diameter(largest_subgraph)   #178
clust<-transitivity(largest_subgraph) # 0.9460152
avpath<-average.path.length(largest_subgraph) #18.10779


#5.4A


young<-subset(cooffending, cooffending$Adultes>0 & cooffending$Jeunes>0)  #17305 by 15 datafram
cooffending$age<-cooffending$annee-cooffending$Naissance
young_2<-subset(cooffending, cooffending$age<18)  #99705 by 16 variab
young_v2<-sum(cooffending$Jeunes)
young_adult<-unique(young$SeqE)
#12000 
adult<-unique(young$NoUnique)
#13035 

young <- unique(young)



#remove the isolated notes after from igraph
Ayoung <- sparseMatrix(i = young$NoUnique, 
                  j = young$SeqE, 
                  x = rep(1,length(young$NoUnique)))
Saeyoung <- Ayoung%*%t(Ayoung)
#diag(C) <- 0 #make diagonal elements of cooffending matrix 0
library(igraph)

#find a list of indices in original matrix that are not in 

dima = dim(young)
lengthyoung=dima[1]
graph_Saeyoung <- graph_from_adjacency_matrix(Saeyoung, diag=FALSE, weighted=TRUE, mode="undirected")#%>%
  #set_vertex_attr("label", value=young$NoUnique)



#vertex_attr(graph_C, "label")
#get.vertex.attribute(graph_C, "label", index=V(graph_C)[24])
deg3<-degree(graph_Saeyoung)
d3<-which(deg3<1) #filtering out those with degree < 1 
#size = 549377 elements
graph_Sae<-delete_vertices(graph_Saeyoung, d3)
vertex_attr(graph_Sae, "label")
vcount(graph_Sae)

degnewSae = degree(graph_Sae)
sort(degnewSae, decreasing=TRUE)
degdeeSae<-degree_distribution(graph_Sae)
barplot(degdeeSae, main = "Degree Distribution of Network for Crimes involving both Youth and Adults", ylab = 'Fraction of vertices with degree k',xlab = 'node k')
length(degdeeSae) #228 is the length

betSae<-betweenness(graph_Sae)
asdfSae<-sort(betSae, decreasing=TRUE)

barplot(betSae, main="Betweenness Centrality of Network for Crimes involving both Youth and Adults", ylab="Betweenness Values", xlab="Node")
hist(betSae, main="Betweeness Centrality of Network for Crimes involving both Youth and Adults", breaks=200, xlab="Betweenness Centrality Values")

eigSae<-eigen_centrality(graph_Sae)
eig_subSae<-sort(eigSae$vector, decreasing=TRUE)


barplot(eigSae$vector, main="Eigenvector Centrality of Network for Crimes involving both Youth and Adults", ylab="Eigenvector Centrality Values", xlab="Node")
hist(eigSae$vector, main="Eigenvector Centrality of Network for Crimes involving both Youth and Adults", breaks=100,  xlab="Eigen Centrality Values")

#5.3E
den2<-edge_density(graph_Sae)   #0.0003556455
diam2<-diameter(graph_Sae)   #178
clust2<-transitivity(graph_Sae) # 0.9460152
avpath2<-average.path.length(graph_Sae) #18.10779


greater10=length(which(degnewSae>=10))  # people who have greater than 10. 

#32245319.8 28561881.9 25466866.8 18903383.9 16773611.7 16685910.7 - these are the top five


data$age<-date$