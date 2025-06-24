## Install RevBayes

### Compile on Linux

Follow the installation steps [here](https://revbayes.github.io/compile-linux). 

### Compile on Mac OS X

Follow the installation steps [here](https://revbayes.github.io/compile-osx). 

### Compile on Windows

Follow the installation steps [here](https://revbayes.github.io/compile-windows). 
</br>

However, we will not be using the standard revbayes branch for this workshop, but the one that has the PoMo models. Clone the ```dev_PoMo``` repository instead of the master one. This is done by substituting the following step  

```
 git clone https://github.com/revbayes/revbayes.git revbayes
```

by this one:

```
git clone --branch development https://github.com/revbayes/revbayes.git revbayes
```

Then change to the PoMoBalance branch by typing:

```
git checkout dev_PoMo_bs_master
```

### Data

We will be using the HLA-A gene from the DeepPhylo workshop. For a trans-species example see the tutorial on the [RevBayes' webpage] (https://revbayes.github.io/tutorials/pomobalance/)

PoMo state-space includes fixed and polymorphic states. However, sampled fixed sites might not be necessarily fixed in the original population. We might just have been unlucky and only sampled individuals with the same allele from a locus that is polymorphic. It is typically the case that the real genetic diversity is undersampled in population genetic studies. The fewer the number of sampled individuals or the rarer are the alleles in the original population (i.e., singletons, doubletons), the more likely are we to observe fake fixed sites in the sequence alignment. The sampled-weighted method helps us to correct for such bias by attributing to each of the allelic counts an appropriate PoMo state (0-based coding). For a population size of 3 virtual individuals, we expect 16 states (coded 0-15), while for a population of 2 virtual individuals, we expected 10 states (coded 0-9).

The script weighted_sampled_method.cpp is implemented in C++, and we will run it using the Rcpp package in R. Open the counts_to_pomo_states_converter.R file and make the appropriate changes to obtain your PoMo alignments suited for PoMoBalance.

```
name <- "HLA_A_1"                       # name of the count file
count_file <- paste0("../data/", name, ".cf")       # path to the count file
n_alleles  <- 4                                     # the four nucleotide bases A, C, G and T
N          <- 10                                    # virtual population size

alignment <- counts_to_pomo_states_converter(count_file,n_alleles,N) # Create the alignment

writeLines(alignment,paste0("../data/", name, ".txt"))               # write the PoMo alignment
```

We place the produced alignments inside the data folder. The output files follow the NaturalNumbers character type of RevBayes and can easily read by it.
HLA_A_1.Rev file using an appropriate text editor so you can follow what each command is doing. Then run RevBayes:

```
./rb HLA_A_1.Rev
```
Note, you may use ./rb or the parallel version ./rb-mpi to speed up the calculations.

### Going through the commands of the script in more detail

We define the virtual population size and load the counts file similarly to a [PoMo](https://revbayes.github.io/tutorials/pomos/)
```
n_branches <- 4
N <- 10
```


