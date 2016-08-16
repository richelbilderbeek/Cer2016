# Cer2016

[![Build Status](https://travis-ci.org/richelbilderbeek/Cer2016.svg?branch=master)](https://travis-ci.org/richelbilderbeek/Cer2016)
[![codecov.io](https://codecov.io/github/richelbilderbeek/Cer2016/coverage.svg?branch=master)](https://codecov.io/github/richelbilderbeek/Cer2016?branch=master)
[![gplv3](http://www.gnu.org/graphics/gplv3-88x31.png)](http://www.gnu.org/licenses/gpl.html)

Community Ecology Research course 2016.

## Installing `Cer2016`

The `Cer2016` package is absent on CRAN.

An easy way is to install it from GitHub. Within R, do:

```
devtools::install_github("richelbilderbeek/Cer2016")
```

## Using `Cer2016` as a package dependency

If your package uses `Cer2016`, add the following to the `DESCRIPTION` its `Remotes` section:

```
Remotes:
  richelbilderbeek/Cer2016
```

## Update the package source on Peregrine

```
module load git; git pull
```

## Copy files from Peregrine to local computer

```
scp p230198@peregrine.hpc.rug.nl:/home/p230198/GitHubs/Cer2016/scripts/*.* ~/Peregrine
```

## Re-install the package on Peregrine

```
cd scripts; sbatch install_this_r_package.sh
```

Note that this is done automatically when running the pipeline.

## Workflow

On Peregrine, from the `Cer2016` root folder:

```
cd scripts
./run.sh
```

It will send an email when finished.

## How to create the test examples?

 * Run the function `do_test_simulations`

## How to install

To install this repository, you will need to:

 * Clone this repository
 * Install packages
 * Install BEAST2

Steps are shown below.

### Clone this repository

From the GNU/Linux terminal, or using Windows Git Bash:

```
git clone https://github.com/richelbilderbeek/Cer2016
```

This will create a folder called `Cer2016`. 

You may also need to do this, for GNU/Linux:

```
sudo apt-get install libcurl4-openssl-dev
```

### Install packages

You will need some packages, which are listed in `install_r_packages.R`.

In Linux, you can install all of these with:

```
sudo install_r_packages.sh
```

### Install BEAST2

You will need to install BEAST2. 

You can do this from [the BEAST2 GitHub](https://github.com/CompEvol/beast2).

In Linux, you can install it with:

```
./install_beast2.sh
```

## Resources

 * [My 2015-11-23 TRES presentation](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek20151123TresMeeting/20151123TresMeeting.pdf)
 * [My 2016-02-03 TECE presentation](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek20160203TeceMeeting/20160203TeceMeeting.pdf)
 * [My 2016 TRES presentation about BEAST2](https://github.com/richelbilderbeek/Science/blob/master/Bilderbeek2016Beast/Bilderbeek2016Beast.pdf)
 * [My R repository](https://github.com/richelbilderbeek/R), especially the `Phylogeny` and `Peregrine` folders may be of help
 * [Prolonging the Past Counteracts the Pull of the Present: Protracted Speciation Can Explain Observed Slowdowns in Diversification. Rampal S. Etienne, James Rosindell. 2012](http://sysbio.oxfordjournals.org/content/61/2/204)
 * Nee, Sean, Robert M. May, and Paul H. Harvey. "The reconstructed evolutionary process." Philosophical Transactions of the Royal Society of London B: Biological Sciences 344.1309 (1994): 305-311.
 * [R coding standard](https://github.com/richelbilderbeek/R-CodingStandard)
 * [Pro Git](https://git-scm.com/book/en/v2)
 * Tidy Data, Hadley Wickham
 * R packages, Hadley Wickham
 * Advanced R, Hadley Wickham
