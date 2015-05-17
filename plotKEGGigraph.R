plotKEGGigraph<-function(URL){
#extract node-edge data from glycan info to make graphs in igraph package
glycanmatch<-regmatches(getURL(URL),
gregexpr("NODE.*EDGE.*///",getURL(URL)))[[1]]
#Find "NODE" and "EDGE" labels
n<-grep("NODE",strsplit(glycanmatch,"\n")[[1]])
e<-grep("EDGE",strsplit(glycanmatch,"\n")[[1]])
#NODES matrix
NODES<-as.matrix(ldply(strsplit(strsplit(glycanmatch,"\n")[[1]][(n+1):(e-1)]," +"),
  function(x) x[-1]))[,-1]
#EDGES matrix
EDGES<-as.matrix(ldply(strsplit(strsplit(glycanmatch,"\n")[[1]][(e+1):(length(strsplit(glycanmatch,"\n")[[1]])-1)]," +"),
  function(x) x[-1]))[,-1]
#actual nodes connectivity list in order (edgelist ready for igraph)
edgenodelist<-matrix(as.numeric(unlist(apply(EDGES,1,function(x) strsplit(x,":[AaBb][0-9]{,2}|:[0-9]+")))),ncol=2,byrow=T)
#actual edge labels (alpha/beta and conectivity)
edgelabels<-as.matrix(ldply(strsplit(apply(EDGES,1,function(x) paste0(x,collapse="-")),
"[0-9]*:|^[0-9](?=-)|(?<=-)[0-9]$",perl=T),function(x) paste0(x,collapse="")))
#Create igraph object
edgelist.ig<-graph.edgelist(edgenodelist)
#Insert labels into edgelist
E(edgelist.ig)$labels<-edgelabels
V(edgelist.ig)$labels<-NODES[,1]
V(edgelist.ig)$x<-as.numeric(NODES[,2])
V(edgelist.ig)$y<-as.numeric(NODES[,3])
plot(edgelist.ig,edge.label=E(edgelist.ig)$labels,vertex.label=V(edgelist.ig)$labels)
#plot does not have angles programmed into it yet.
matches<-as.matrix(strsplit(glycanmatch,"\n")[[1]])
list(edgelist.ig,matches,edgenodelist,NODES,EDGES)
}
