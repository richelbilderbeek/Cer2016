---
title: "Analyse gamma's"
author: "Richel Bilderbeek, Femke Thon"
date: "2016-05-27"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Analyse gamma's}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

Loading this package


```r
library(Cer2016)
library(ggplot2)
```

## Collecting gamma's from all files


```r
csv_filename_species_trees <- "collected_gammas_species_trees.csv"
csv_filename_posterior     <- "collected_gammas_posterior.csv"
zip_filename_posterior     <- "collected_gammas_posterior.csv.zip"
csv_filename_parameters    <- "collected_parameters.csv"
zip_filename_comparison    <- "femke.csv.zip"
csv_filename_comparison    <- "femke.csv"
create_fresh <- FALSE # Set this to TRUE and for a >60 mins calculation
if (create_fresh) {
  folder <- "/home/p230198/Peregrine"
  all_parameter_filenames <- paste(
    folder, list.files(folder, pattern = "\\.RDa"), sep = "/"
  )
  df <- collect_files_gammas(all_parameter_filenames, verbose = TRUE)
  write.csv(
    x = df$species_tree_gamma_stats,
    file = csv_filename_species_trees,
    row.names = TRUE
  )
  write.csv(
    x = df$posterior_gamma_stats,
    file = csv_filename_posterior,
    row.names = TRUE
  )
}
if (!file.exists(csv_filename_posterior)) {
  utils::unzip(zip_filename_posterior)
}
if (!file.exists(csv_filename_comparison)) {
  utils::unzip(zip_filename_comparison)
}
testit::assert(file.exists(csv_filename_species_trees))
testit::assert(file.exists(csv_filename_posterior))
testit::assert(file.exists(csv_filename_parameters))
testit::assert(file.exists(csv_filename_comparison))
```

Note that the comma-seperated file is only created when absent,
as this is a long step.

Loading it from file:


```r
df_species_trees <- read.csv(
 file = csv_filename_species_trees, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

df_posterior <- read.csv(
 file = csv_filename_posterior, 
 header = TRUE, 
 stringsAsFactors = FALSE, 
 row.names = 1
)

df_parameters <- read.csv(
  file = csv_filename_parameters, 
  header = TRUE, 
  stringsAsFactors = FALSE, 
  row.names = 1
)

df_comparison <- read.csv(
  file = csv_filename_comparison,
  header = TRUE,
  stringsAsFactors = FALSE,
  row.names = 1
)
```

Analysis here:


```r
class(df_comparison)
```

```
## [1] "data.frame"
```

```r
class(df_parameters)
```

```
## [1] "data.frame"
```

```r
# Add a column called 'filenames' to the parameter files
df_parameters$filenames <- rownames(df_parameters)

names(df_comparison)
```

```
## [1] "filenames"    "species_tree" "gamma_stat.x" "alignment"   
## [5] "beast_run"    "gamma_stat.y" "diff"
```

```r
names(df_parameters)
```

```
##  [1] "rng_seed"                                 
##  [2] "species_initiation_rate_good_species"     
##  [3] "species_initiation_rate_incipient_species"
##  [4] "speciation_completion_rate"               
##  [5] "extinction_rate_good_species"             
##  [6] "extinction_rate_incipient_species"        
##  [7] "age"                                      
##  [8] "n_species_trees_samples"                  
##  [9] "mutation_rate"                            
## [10] "n_alignments"                             
## [11] "sequence_length"                          
## [12] "mcmc_chainlength"                         
## [13] "n_beast_runs"                             
## [14] "version"                                  
## [15] "filenames"
```

```r
df_big <- merge(x = df_parameters, y = df_comparison, by = "filenames", all = TRUE)

names(df_big)
```

```
##  [1] "filenames"                                
##  [2] "rng_seed"                                 
##  [3] "species_initiation_rate_good_species"     
##  [4] "species_initiation_rate_incipient_species"
##  [5] "speciation_completion_rate"               
##  [6] "extinction_rate_good_species"             
##  [7] "extinction_rate_incipient_species"        
##  [8] "age"                                      
##  [9] "n_species_trees_samples"                  
## [10] "mutation_rate"                            
## [11] "n_alignments"                             
## [12] "sequence_length"                          
## [13] "mcmc_chainlength"                         
## [14] "n_beast_runs"                             
## [15] "version"                                  
## [16] "species_tree"                             
## [17] "gamma_stat.x"                             
## [18] "alignment"                                
## [19] "beast_run"                                
## [20] "gamma_stat.y"                             
## [21] "diff"
```

```r
knitr::kable(head(df_big))
```



filenames                rng_seed   species_initiation_rate_good_species   species_initiation_rate_incipient_species   speciation_completion_rate   extinction_rate_good_species   extinction_rate_incipient_species   age   n_species_trees_samples   mutation_rate   n_alignments   sequence_length   mcmc_chainlength   n_beast_runs   version   species_tree   gamma_stat.x   alignment   beast_run   gamma_stat.y         diff
----------------------  ---------  -------------------------------------  ------------------------------------------  ---------------------------  -----------------------------  ----------------------------------  ----  ------------------------  --------------  -------------  ----------------  -----------------  -------------  --------  -------------  -------------  ----------  ----------  -------------  -----------
article_0_0_0_0_0.RDa          NA                                     NA                                          NA                           NA                             NA                                  NA    NA                        NA              NA             NA                NA                 NA             NA        NA             NA             NA          NA          NA             NA           NA
article_0_0_0_0_1.RDa          NA                                     NA                                          NA                           NA                             NA                                  NA    NA                        NA              NA             NA                NA                 NA             NA        NA             NA             NA          NA          NA             NA           NA
article_0_0_0_0_2.RDa           1                                    0.1                                         0.1                          0.1                              0                                   0    15                         2             0.1              2             1e+05              1e+06              2       0.1              1      0.1567163           1           1      0.2362042   -0.0794879
article_0_0_0_0_2.RDa           1                                    0.1                                         0.1                          0.1                              0                                   0    15                         2             0.1              2             1e+05              1e+06              2       0.1              1      0.1567163           1           1      0.1918544   -0.0351382
article_0_0_0_0_2.RDa           1                                    0.1                                         0.1                          0.1                              0                                   0    15                         2             0.1              2             1e+05              1e+06              2       0.1              1      0.1567163           1           1      0.2238795   -0.0671632
article_0_0_0_0_2.RDa           1                                    0.1                                         0.1                          0.1                              0                                   0    15                         2             0.1              2             1e+05              1e+06              2       0.1              1      0.1567163           1           1      0.2063103   -0.0495940

```r
df_big$speciation_completion_rate <- as.factor(df_big$speciation_completion_rate)

df_extreme <- df_big[
  !is.na(df_big$speciation_completion_rate)
  & (df_big$speciation_completion_rate == 0.1 |       
     df_big$speciation_completion_rate == 1e+06),
  ]


ggplot(df_big, aes(x = diff, colour = speciation_completion_rate)) + 
  geom_density() +
  xlim(c(-2, 2))
```

```
## Warning: Removed 16653 rows containing non-finite values (stat_density).
```

![](C:\Users\Stultum\AppData\Local\Temp\Rtmp8AXvom\preview-b84667127f5.dir\analyse_gammas_richel_files/figure-html/unnamed-chunk-2-1.png)

```r
ggplot(df_extreme, aes(x = diff, colour = speciation_completion_rate)) + 
  geom_density() +
  xlim(c(-2, 2))
```

```
## Warning: Removed 7805 rows containing non-finite values (stat_density).
```

![](C:\Users\Stultum\AppData\Local\Temp\Rtmp8AXvom\preview-b84667127f5.dir\analyse_gammas_richel_files/figure-html/unnamed-chunk-2-2.png)


