# A covarion model for phylogenetic estimation using discrete morphological datasets

authors: Basanta Khakurel and Sebastian Höhna

# Summary of the study

In this manuscript, we present an original study exploring the usage of covarion model in discrete morphological datasets for phylogenetic tree estimation.

This compressed file archive contains all the data and scripts used for the simulation-related and empirical phylogenetic analyses in RevBayes.

## Funding Sources

This work was supported by the European Union (ERC, MacDrive, GA 101043187).
Views and opinions expressed are however those of the authors only and do not necessarily reflect those of the European Union or the European Research Council Executive Agency. Neither the European Union nor the granting authority can be held responsible for them.

# Description of data files and file structure.

## Files hosted on Dryad:

`command_line_intructions.txt`: this file contains instructions to reproduce individual analysis from the manuscript

`empirical_data.zip` folder: contains 164 empirical matrices that are used to test the covariomorph model in this study. The source studies are cited in the electronic supplementary materials (`Supplementary_Information.pdf`).

## Files hosted on Zenodo:

`Supplementary_Information.pdf`: this file includes:

* Introductory figures and sections for the Covariomorph model.
* References to the original studies from which empirical datasets are obtained
* Results not included in the main manuscript. The following supplementary figures and tables can be found in the electronic supplementary material:
- Figure S1: Graphical representation of the Covariomorph model.
- Figure S2: Results of the validation analysis for the model implementation.
- Figure S3: Expansion of virtual states from observed states.
- Figure S4: Relative runtimes of Mk, Mk+ACRV, and Covariomorph model.
- Figure S5: Rate categories from a discretized lognormal distribution.
- Figure S6: Clade posterior probabilities for different true models using simulated datasets.
- Figure S7: Size and parameter estimates of the empirical datasets
- Figure S8: Marginal likelihood estimates of Rays and Sharks dataset with varying number of covariomorph rate categories
- Figure S9: Robinson-Foulds difference between the Maximum a posteriori tree from the Mk model and covariomorph model with varying rate categories
- Figure S10: Differences between trees sampled by different models for the Rays dataset
- Figure S11: Differences between trees sampled by different models for the Sharks dataset

- Table S1: Bayes factor for covariomorph model varying number of rate categories.



`scripts.zip` folder: contains the scripts used for phylogenetic analyses using the soured data files described above.
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

To view examples of command line instructions for the scripts please refer to the file `command_line_instructions.txt`

## Working Directory Settings

To run the analyses successfully, download both `empirical_data` and `scripts` directories into the same root folder on your local machine.

Before running the commands listed in `command_line_instructions.txt`, ensure you have set your working directories in both RevBayes and R to this root folder so the scripts can locate the relative paths.
Alternatively, you can navigate to the root folder via command line.

## Software Versions:

* RevBayes version 1.2.6
* R version 4.2.3
