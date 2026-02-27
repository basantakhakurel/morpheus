# A covarion model for phylogenetic estimation using discrete morphological datasets

Authors: Basanta Khakurel and Sebastian Höhna

# Summary of the study

In this manuscript, we present an original study exploring the usage of covarion model in discrete morphological datasets for phylogenetic tree estimation.

This compressed file archive contains all the data and scripts used for the simulation-related and empirical phylogenetic analyses in RevBayes.

## Funding Sources

This work was supported by the European Union (ERC, MacDrive, GA 101043187).
Views and opinions expressed are however those of the authors only and do not necessarily reflect those of the European Union or the European Research Council Executive Agency. Neither the European Union nor the granting authority can be held responsible for them.

# Data Availability and File Structure.

## Files hosted on Dryad:

`command_line_intructions.txt`: This file contains instructions to reproduce individual analysis from the manuscript.

## Empirical Data Source

The empirical data tested in this manuscript are not hosted in this repository.
The must be downloaded from their original source on Data Dryad:
> Lloyd, Graeme; Wright, April (2020). Data from: Bayesian analyses in phylogenetic palaeontology: interpreting the posterior sample [Dataset]. Dryad. https://doi.org/10.5061/dryad.zs7h44j4w

The original source studies are listed in the electronic supplementary materials on Zenodo (`Supplementary_Information.pdf`).

## Files hosted on Zenodo:

- `Supplementary_Information.pdf`: Includes introductory figures for the Covariomorph model, references to the original studies, and Supplmentary Figures S1-S11 and Table S1 (detailing model representations, validation results, relative runtimes, parameter estimates, and more).

- `scripts.zip` folder: Contains the scripts used for phylogenetic analyses using the soured data files described above.
Please refer to our analysis pipeline (`command_line_instructions.txt`) for proper use of the following scripts:

  * `RevScripts` folder: contains scripts for use with RevBayes
    * `Marginal_Likelihood.Rev`: script to run the marginal likelihood estimation in RevBayes.
    * `mcmc.Rev`: script containing the analysis settings and Markov chain Monte Carlo (MCMC) for covariomorph model in RevBayes
    * `model_Covariomorph.Rev`: general model settings for the covariomorph model
    * `model_Tree.Rev`: script containing the setting for prior on the topology
    * `simulate_Covariomorph.Rev`: script to simulate datasets under the covariomorph model
  * `RScripts` folder: contains the scripts to summarize the output from RevBayes and scripts to plot the results.
    * `convert_state_labels.r`: script to convert the state labels for the simulated data from virtual states to observed states
    * `figure3_simulations_sd_vs_sr.r`: script to generate Figure 3 from the manuscript. This script plots the standard deviation against the switching rate for simulation results.
    * `figure4_empirical_sd_vs_sr.r`: script to generate Figure 4 from the manuscript. This script plots the standard deviation against the switching rate for empirical results.
    * `figure5_posterior_rays_sharks.r`: script to generate Figure 5 from the manuscript. This script plots the posterior distribution of the analyzed datasets.
    * `figure6_cpp_rays_sharks.r`: script to generate Figure 6 from the manuscript. This script calculates the posterior probabilities of the clades and plots them.
    * `summarize_empirical_covariomorph.r`: script to obtain results from the empirical analysis using the covariomorph model
    * `summarize_simulations.r`: script to obtain results from the simulated analyses.

# Analysis pipeline

We assume you have RevBayes installed and it can be used with `rb` in command line.
Note that you can use the MPI version of RevBayes (`rb-mpi`) instead.

To view examples of command line instructions for the scripts please refer to the `command_line_instructions.txt` file.

## Working Directory Settings

To run the analyses successfully, you must assemble the data and scripts on your local machine:
1. Download the empirical data from the Lloyd and Wright (2020) Dryad repository linked above.
2. Download and extract the scripts.zip folder from the Zenodo repository.
3. Place both the empirical data files and the extracted script directories into the same root folder on your local machine.

Before running the commands listed in `command_line_instructions.txt`, ensure you have set your working directories in both RevBayes and R to this root folder so the scripts can locate the relative paths.
Alternatively, you can navigate to the root folder via command line.

## Software Versions:

* RevBayes version 1.2.6
* R version 4.2.3
