## ------------------------------------------------------------------------
#Read & check
library(Cer2016)
library(ape)

newick_filename <- "newick_file_five_species.txt"
if (file.exists(newick_filename)) {
  print(readLines(newick_filename))
  my_phylo <- read.tree(file = newick_filename)
  if (is.null(my_phylo)) {
    print("my_phylo is NULL??!")
  }
  my_phylo
  #write.tree(my.phylo)
  names(my_phylo)
} else {
  print("ERROR")
}

## ------------------------------------------------------------------------
#Plotting & colour
plot(my_phylo, edge.color = "blue")

## ------------------------------------------------------------------------
#Calculate total branch length
my_phylo$edge.length
total_length <- sum(my_phylo$edge.length)
total_length

## ------------------------------------------------------------------------
#calculate amount of subtrees
my_subtrees <- subtrees(my_phylo)
my_subtrees

## ------------------------------------------------------------------------
#calculate percentage of subtree [[2]] of total phylogeny
subtree_two <- sum(my_subtrees[[2]]$edge.length)
subtree_two

percentage_tree_two <- subtree_two/total_length
percentage_tree_two

## ------------------------------------------------------------------------
#Randomize tip labels, sample without replacement
sample(my_phylo$tip.label, rep=F)

## ------------------------------------------------------------------------
library(ape)
nexus_filename <- "newick_file_five_species_nexus.txt"
write.nexus(rcoal(10), file = nexus_filename)
print(file.exists(nexus_filename))

#plot(read.tree(text = "(B:3.00,(A:3.00,C:3.00,E:3.00):3.00,D:3.00);"))
my_nexus_phylo <- read.nexus(nexus_filename) 
plot(my_nexus_phylo)
write.nexus(my_nexus_phylo)

## ------------------------------------------------------------------------
#Read & check
library(ape)
my_phylo2 <- read.tree("newick_file_six_species.txt")
write.tree(my_phylo2)
names(my_phylo2)

#Plotting & colour
plot(my_phylo2, edge.color = "purple")

#Calculate total branch length
my_phylo2$edge.length
total_length2 <- sum(my_phylo2$edge.length)
total_length2

#calculate amount of subtrees
my_subtrees2 <- subtrees(my_phylo2)
my_subtrees2

#calculate percentage of subtree [[2]] of total phylogeny
subtree_two2 <- sum(my_subtrees2[[2]]$edge.length)
subtree_two2

percentage_tree_two2 <- subtree_two2/total_length2
percentage_tree_two2

#Randomize tip labels, sample without replacement
sample(my_phylo$tip.label, rep=F)

## ------------------------------------------------------------------------
library(ape)

#Simulation of 5 coalescent trees with 10 species each & write it to working 
#directory
for (i in 1:5){

  #Make random coalescent tree with 10 taxa
  temp_random_tree <- rcoal(10)
  
  #Write random tree to working directory (each new file has new number)
  write.tree(temp_random_tree, paste(i, ".txt", sep = "")) 
}

## ------------------------------------------------------------------------
library(ape)

setwd("C:/Users/Aline/New")
getwd()

for (i in 1:5){
  temp_random_tree <- rcoal(10)
  write.tree(temp_random_tree, paste(i, ".txt", sep = "")) 
}

list.files(getwd())

