#!/bin/bash
cd inst/extdata

## Downloading

if [ ! -e gamma_diff.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/gamma_diff.csv.zip
else
  echo "File already downloaded"
fi

if [ ! -e collected_gammas_posterior.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_gammas_posterior.csv.zip
else
  echo "File already downloaded"
fi

if [ ! -e collected_gammas_species_trees.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_gammas_species_trees.csv.zip
else
  echo "File already downloaded"
fi

if [ ! -e collected_nltts_posterior.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_nltts_posterior.csv.zip
else
  echo "File already downloaded"
fi

if [ ! -e collected_n_taxa.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_n_taxa.csv.zip
else
  echo "File already downloaded"
fi

if [ ! -e collected_nltts_species_trees.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_nltts_species_trees.csv.zip
else
  echo "File already downloaded"
fi


if [ ! -e collected_parameters.csv.zip ]
then
  echo "Downloading file"
  wget http://richelbilderbeek.nl/Cer2016/collected_parameters.csv.zip
else
  echo "File already downloaded"
fi


## Unzipping


if [ ! -e gamma_diff.csv ]
then
  echo "Unzipping file"
  unzip gamma_diff.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_gammas_posterior.csv ]
then
  echo "Unzipping file"
  unzip collected_gammas_posterior.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_gammas_species_trees.csv ]
then
  echo "Unzipping file"
  unzip collected_gammas_species_trees.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_nltts_posterior.csv ]
then
  echo "Unzipping file"
  unzip collected_nltts_posterior.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_n_taxa.csv ]
then
  echo "Unzipping file"
  unzip collected_n_taxa.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_nltts_species_trees.csv ]
then
  echo "Unzipping file"
  unzip collected_nltts_species_trees.csv.zip
else
  echo "File already unzipped"
fi

if [ ! -e collected_parameters.csv ]
then
  echo "Unzipping file"
  unzip collected_parameters.csv.zip
else
  echo "File already unzipped"
fi

