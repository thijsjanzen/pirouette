#!/bin/bash
# Script to install pirouette and its dependencies
# on the Peregrine computer cluster
# 
# Usage:
#
# * To install master:
#
# sbatch install_pirouette
#
# * To install a branch, e.g. develop:
#
# sbatch install_pirouette develop
#
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=install_pirouette
#SBATCH --output=install_pirouette.log
branch=$1
if [ "$#" -ne 1 ]; then
  branch=master
fi

module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
module load ImageMagick

Rscript -e 'devtools::install_bioc("ggtree")'
Rscript -e 'devtools::install_github("KlausVigo/phangorn")'
Rscript -e 'devtools::install_github("richelbilderbeek/nLTT")'
Rscript -e 'devtools::install_github("ropensci/beautier")'
Rscript -e 'devtools::install_github("ropensci/beastier")'
Rscript -e 'devtools::install_github("ropensci/tracerer")'
Rscript -e 'devtools::install_github("ropensci/mauricer")'
Rscript -e 'devtools::install_github("ropensci/babette")'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e "devtools::install_github(\"richelbilderbeek/pirouette\", ref = \"$branch\")" 
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'