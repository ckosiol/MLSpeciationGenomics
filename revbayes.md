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

We define load the counts file, define the virtual population size similarly to a [PoMo](https://revbayes.github.io/tutorials/pomos/) and the number of branches on the phylogeny
```
data <- readCharacterDataDelimited("HLA_A_1.txt", stateLabels=58, type="NaturalNumbers", delimiter=" ", header=FALSE)
N <- 10
```
Next, we will specify the number of branches.

```
n_branches <- 4
```

Also variable to store moves and monitors for our analysis. You can add multiple kinds of moves into this variable and better explore the parameter space with MCMC, to avoid local minima and correlation between the moves. Monitors are for tracking MCMC analysis.

```
moves = VectorMoves()  
monitors = VectorMonitors()
```

### Setting up the model
PoMoBalance is defined with instantaneous-rate matrix, Q with population size N, allele frequencies pi, exchangeabilities rho (in the non-reversible case combined into mutations mu), and allele fitnesses phi. Frequencies must sum up to unity, thus, pi is initialised with Dirichlet distribution and the move is mvBetaSimplex


```
# allele frequencies
pi_prior <- [0.25,0.25,0.25,0.25]
pi ~ dnDirichlet(pi_prior)
moves.append( mvBetaSimplex(pi, weight=2) )
```
The rho and phi parameters must be positive real numbers and a natural choice for their prior distributions is the exponential distribution and the standard moves mvScale. Let’s add an adaptive variance multivariate-normal proposal move that uses MCMC samples to fit covariance matrix to parameters called mvAVMVN to sigma to avoid correlation between GC-bias and balancing selection coefficients
```
## Setup rho exchangeability rates.
for (i in 1:6){
  rho[i] ~ dnExponential(10.0)
  moves.append(mvScale(rho[i], weight = 3))
}

## Setup mu mutation rates. We have a rate for mutation between each pair of
# different bases, and one for each direction. Thus, we have 4P2 = 12 rates.
mu := [
  pi[2]*rho[1], pi[1]*rho[1],
  pi[3]*rho[2], pi[1]*rho[2],
  pi[4]*rho[3], pi[1]*rho[3],
  pi[3]*rho[4], pi[2]*rho[4],
  pi[4]*rho[5], pi[2]*rho[5],
  pi[4]*rho[6], pi[3]*rho[6]
]

# fitness coefficients
sigma ~ dnExponential(1.0)
moves.append(mvScale( sigma, weight=2 ))
moves.append(mvAVMVN(sigma) )

phi := [1.0,1.0+sigma,1.0+sigma,1.0]
```
The strength of balancing selection beta is also exponential. The preferred frequency B must be a discrete positive value between 0 and N. Here, we fix this to N/2 for our case since under our heterozygote advantage simulation, we expect balancing selection to drive the preferred frequency of each base to N/2.
```
## Setup beta balancing selection coefficients. These quantify the strength of
# balancing selection.
for (i in 1:6){
  beta[i] ~ dnExponential(1.0)
  moves.append(mvScale(beta[i], weight = 2))
  
}

for (i in 1:6){
  # N/2 = 5. We can't write N/2 directly since it causes the type of N to be
  # inferred as a float instead of an integer, which causes issues later on.
  # And for some reason there is no function to manually cast it back.
  B[i] <- 5
}
```
```
## Load in fixed tree. This tree has a fixed topology, but we will still later
# infer the branch lengths. You can infer tree topology if you wish, although
# this is probably best done with PoMoSelect. We need not do that here since our 
# tree topology is so simple (and known since we wrote the simulations) it can
# be built by hand.
tree <- readBranchLengthTrees("base_tree.nwk")[1]

## Setup the instantaneous rate matrix Q.
Q := fnPoMoBalance4N(N, mu, phi, beta, B)

## Setup branch lengths.
for (i in 1:n_branches) {
    bl[i] ~ dnExponential(10.0)
    moves.append(mvScale(bl[i], weight = 6))
}

## Combine the branch lengths and tree topology into a phylogram.
psi := treeAssembly(tree, bl)

## Merge the tree and rate matrix into a phylogenetic CTMC distribution.
sequences ~ dnPhyloCTMC(tree = psi, Q = Q, type = "NaturalNumbers")

# Clamp our data to the phyloCTMC distribution.
sequences.clamp(data)

## Assemble all nodes into a model.
mymodel = model(Q)
print("\nFinished building model")

## Setup output paths.
output_dir <- "output/" + outname + "/"
model_path <- output_dir + outname + ".log"
tree_path <- output_dir + outname + ".trees"

## Setup monitors.
monitors.append(mnModel(filename = model_path, printgen = 1))
monitors.append(mnFile(filename = tree_path, printgen = 1, psi))
monitors.append(mnScreen(printgen = 10))

## Run the MCMC.
print("\nRunning MCMC\n")

n_burnin = 5000
n_main = 25000
n_chains = 4

mcmc_handler = mcmc(mymodel, monitors, moves, nruns = n_chains, combine = "mixed")
mcmc_handler.burnin(generations = n_burnin, tuningInterval = 200)
mcmc_handler.run(generations = n_main)

print("\nFinished MCMC\n")

## Collate results and write final output.

trace = readTreeTrace(tree_path, treetype = "non-clock", burnin = 0.2)

tree_map_path = output_dir + outname + ".map.tree"
tree_mcc_path = output_dir + outname + ".mcc.tree"

mapTree(trace, file = tree_map_path)
mccTree(trace, file = tree_mcc_path)

print("\nDone...")

# Quit once finished.
q()

```
