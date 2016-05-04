## ------------------------------------------------------------------------
#Read & check
library(Cer2016)
library(ape)

newick_filename <- "newick_file_five_species.txt"
if (file.exists(newick_filename)) {
  print(readLines(newick_filename))
  my.phylo <- read.tree(file = newick_filename)
  if (is.null(my.phylo)) {
    print("my.phylo is NULL??!")
  }
  my.phylo
  #write.tree(my.phylo)
  names(my.phylo)
} else {
  print("ERROR")
}

## ------------------------------------------------------------------------
#Plotting & colour
plot(my.phylo, edge.color = "blue")

## ------------------------------------------------------------------------
#Calculate total branch length
my.phylo$edge.length
total.length <- sum(my.phylo$edge.length)
total.length

## ------------------------------------------------------------------------
#calculate amount of subtrees
my.subtrees <- subtrees(my.phylo)
my.subtrees

## ------------------------------------------------------------------------
#calculate percentage of subtree [[2]] of total phylogeny
subtree.two <- sum(my.subtrees[[2]]$edge.length)
subtree.two

percentage.tree.two <- subtree.two/total.length
percentage.tree.two

## ------------------------------------------------------------------------
#Randomize tip labels, sample without replacement
sample(my.phylo$tip.label, rep=F)

## ------------------------------------------------------------------------
library(ape)
filename <- "newick_file_five_species_nexus.txt"
write.nexus(rcoal(10), file = filename)
print(file.exists(filename))

#plot(read.tree(text = "(B:3.00,(A:3.00,C:3.00,E:3.00):3.00,D:3.00);"))
my.nexus.phylo <- read.nexus(filename) 
plot(my.nexus.phylo)
write.nexus(my.phylo)

## ------------------------------------------------------------------------
#Read & check
library(ape)
my.phylo2 <- read.tree("newick_file_six_species.txt")
write.tree(my.phylo2)
names(my.phylo2)

#Plotting & colour
plot(my.phylo2, edge.color = "purple")

#Calculate total branch length
my.phylo2$edge.length
total.length2 <- sum(my.phylo2$edge.length)
total.length2

#calculate amount of subtrees
my.subtrees2 <- subtrees(my.phylo2)
my.subtrees2

#calculate percentage of subtree [[2]] of total phylogeny
subtree.two2 <- sum(my.subtrees2[[2]]$edge.length)
subtree.two2

percentage.tree.two2 <- subtree.two2/total.length
percentage.tree.two2

#Randomize tip labels, sample without replacement
sample(my.phylo$tip.label, rep=F)

## ------------------------------------------------------------------------
#Simulation of 5 coalescent trees with 10 species each & write it to working 
#directory
for (i in 1:5){

  #Make random coalescent tree with 10 taxa
  temp_random_tree <- rcoal(10)
  
  #Write random tree to working directory (each new file has new number)
  write.tree(temp_random_tree, paste(i, ".txt", sep = "")) 
}

## ------------------------------------------------------------------------


