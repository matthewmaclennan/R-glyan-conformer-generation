#Script for building glycans. Ideally, the option for building glycans based on IUPAC polysaccharide nomenclature would be useful, but 
#perhaps it would be easier to build glycan geometry files based on a matrix input with SMILES string modifications (sulfate, phosphate, 
#N-acetyl, etc...)
#The library represents a series of geometrically defined monosaccharides which the function will draw from in order to build the glycan 
#structure.
#
#STEP 1: Number each monomer in the glycan name string. Turn the glycan name into a vector of monomers.
########: Regex letters with noncapturing positive lookahead for alpha/beta/a/b/A/B characters
as.matrix(regmatches(glycan,gregexpr("[A-Za-z]+(?=[aAbB(alpha)(beta)])",glycan,perl=T))[[1]])
#analogous regex as above, but for a numbered linkage from monomer to amino acid or molecule "R".
as.matrix(regmatches(glycan,gregexpr("[A-Za-z]+(?=[aAbB(alpha)(beta)][0-9]-R)",glycan,perl=T))[[1]])
#STEP 2: regex out the connectors (alpha, beta, 1-4, etc...). Further split these into bond type (letter), first monomer position and 
#second monomer position.
glycanbuild<-function(glycanstring){
     
     glycanstring<-as.character(glycanstring)

     strsplit(glycanstring,"[abAB][0-9]-[0-9]")
     
     
}
