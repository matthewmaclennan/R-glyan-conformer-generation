#extract node-edge data from glycan info to make graphs in igraph package
glycanmatch<-regmatches(getURL("http://rest.kegg.jp/get/gl:G00003"),
gregexpr("NODE.*EDGE.*///",getURL("http://rest.kegg.jp/get/gl:G00003")))[[1]]
#remove "\n" and display neatly
match<-as.matrix(strsplit(glycanmatch,"\n")[[1]])
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
edgelist<-matrix(as.numeric(unlist(apply(EDGES,1,function(x) strsplit(x,":[AaBb][0-9]{,2}|:[0-9]+")))),ncol=2,byrow=T)
#actual edge labels (alpha/beta and conectivity)
edgelabels<-as.matrix(ldply(strsplit(apply(EDGES,1,function(x) paste0(x,collapse="-")),"[0-9]+:"),
  function(x) paste0(x,collapse="")))
plot(graph.edgelist(edgelist))
#position string
posstring<-paste0(unlist(lapply(strsplit(strsplit(glycanmatch,"\n")[[1]][(e+1):(length(strsplit(glycanmatch,"\n")[[1]])-1)]," +"),
function(x) x[-c(1,2)])),collapse="")
