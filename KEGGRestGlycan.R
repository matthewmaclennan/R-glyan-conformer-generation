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
