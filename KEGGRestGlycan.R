#extract node-edge data from glycan info to make graphs in igraph package
glycanmatch<-regmatches(getURL("http://rest.kegg.jp/get/gl:G00003"),
gregexpr("NODE.*EDGE.*///",getURL("http://rest.kegg.jp/get/gl:G00003")))[[1]]
#remove "\n" and display neatly
as.matrix(strsplit(glycanmatch,"\n")[[1]])
#Find "NODE" and "EDGE" labels
grep("NODE|EDGE",as.matrix(strsplit(glycanmatch,"\n")[[1]]))
