## ----message = FALSE-----------------------------------------------------
library(ape)
library(Cer2016)
library(ggplot2)
library(Hmisc)
library(nLTT)
library(ribir)
library(phangorn)

## ------------------------------------------------------------------------
dt <- 0.001

## ------------------------------------------------------------------------
filename <- "add_posterior_demo.RDa"

## ----message = FALSE-----------------------------------------------------
if (file.exists(filename)) {
  file.remove(filename)
}

