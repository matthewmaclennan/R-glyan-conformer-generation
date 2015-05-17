#Script to transform a KEGG graph notation for glycan into a linear notation with parentheses.
#This code will be the first step toward generating SMILES strings or geometry files.
KEGG2string<-function(){
require(igraph)
#p is result of KEGG plot igraph function
pasty<-""
  for(i in 1:nrow(p[[3]])){
    pasty<-paste0(pasty,V(p[[1]])$labels[p[[3]][i,1]],"(",E(p[[1]])$labels[i],")",V(p[[1]])$labels[p[[3]][i,2]])
}

#Build a vector of the node nuumbers in order of rows in p[[3]]
#Ask for match at every [,2] query
#If match, then parentheses are inserted and [,1] value is removed from string
for(i in 1:nrow(p[[3]])){
  
}
