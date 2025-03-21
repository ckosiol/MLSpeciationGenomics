## **Session 3**
## Bayesian polymorphism-aware phylogenetic inference

In this session, we will perform Bayesian phylogenetic inference with the polymorphism-aware phylogenetic models. We will learn about the virtual PoMos and how we can account for nucleotide usage bias likely present in our data sets while inferring phylogenetic trees. 

* [&#8600; Theoretical_part](/assets/session3/session_3.pdf)

In this tutorial, we will infer the evolutionary history of 12 great apes populations. The data was taken from [Prado-Martinez (2013)](https://www.nature.com/articles/nature12228), and in this tutorial, we will be using a toy example of only 1000 sites. 

First of all, create a folder called **Session_3** and download the following files into it.

* [&#8600;```weighted_sampled_method.cpp```](/assets/session3/weighted_sampled_method.cpp)
* [&#8600;```counts_to_pomo_states_converter.R```](/assets/session3/counts_to_pomo_states_converter.R)
* [&#8600;```great_apes_1000.cf```](/assets/session3/great_apes_1000.cf)
* [&#8600;```great_apes_pomotwo.Rev```](/assets/session3/great_apes_pomotwo.Rev)
* [&#8600;```great_apes_pomothree.Rev```](/assets/session3/great_apes_pomothree.Rev)

Inside this folder, create two more: one called **data** and another called **output**.

### Loading the data

The first step in this tutorial is to convert the allelic counts into PoMo states. We will be using the sampled-weighted strategy to correct for sampling errors. The script ```weighted_sampled_method.cpp``` is implemented in **C++**, and we will run it using the **Rcpp** package in **R**.  Open the ```counts_to_pomo_states_converter.R``` file and make the appropriate changes to obtain your PoMo alignments suited for PoMoTwo and PoMoThree. As we will be using the virtual PoMos Two and Three, the virtual population sizes are 2 and 3.

```r
count_file <- "count_file.txt"     # count file
n_alleles  <- 4                    # the four nucleotide bases A, C, G and T
N          <- 10                   # virtual population size

alignment <- counts_to_pomo_states_converter(count_file,n_alleles,N)
```

Place the produced alignments inside the **data** folder. Your files should resemble these ones:
* [&#8600;```great_apes_pomotwo_naturalnumbers.txt```](/assets/session3/great_apes_pomotwo_naturalnumbers.txt)
* [&#8600;```great_apes_pomothree_naturalnumbers.txt```](/assets/session3/great_apes_pomothree_naturalnumbers.txt)


Open the terminal and place it on your working directory **Session_3**. Make sure your **RevBayes** executable (i.e., ```./rb``` or ```./rb-mpi```) is inside the **Session_3** folder. Run **RevBayes** by typing ```./rb``` (or ```./rb-mpi```) in the console. Open the ```great_apes_pomothree.Rev``` file using an appropriate text editor. First load in the PoMo alignment using the ```readCharacterDataDelimited``` function. This function requires you to input the number of expected states: 10 for PoMoTwo and 16 for PoMoThree.

```
data <- readCharacterDataDelimited("data/great_apes_pomothree_naturalnumbers.txt", stateLabels=16, type="NaturalNumbers", delimiter=" ", headers=FALSE)
```

Information about the alignment can be obtained by typing ```data```. 

```
>data
NaturalNumbers character matrix with 12 taxa and 1000 characters
================================================================
Origination:                   
Number of taxa:                12
Number of included taxa:       12
Number of characters:          1000
Number of included characters: 1000
Datatype:                      NaturalNumbers
```

Next, we will specify some useful variables based on our dataset: these include, the number of taxa, taxa names and number of branches. We will need that information for setting up our model in subsequent steps.

```
n_taxa     <- data.ntaxa()
n_branches <- 2*n_taxa-3
taxa       <- data.taxa()
```

Additionally, we set up a variable that holds all the moves and monitors for our analysis. Recall that moves are algorithms used to propose new parameter values during the MCMC simulation. Monitors print the values of model parameters to the screen and/or log files during the MCMC analysis.

```
moves    = VectorMoves()  
monitors = VectorMonitors()
```

### Setting up the model

Estimating an unrooted tree under the virtual PoMos requires specifying two main components: 
* the PoMo model, which in our case is PoMoTwo or PoMoThree;
* the tree topology and branch lengths.

A given PoMo model is defined by its corresponding instantaneous-rate matrix, ```Q```. PoMoTwo and PoMoThree have three free parameters in common: the population size ```N```, the allele frequencies ```pi```, and the exchangeabilities ```rho```. PoMoThree additionally includes the allele fitnesses ```phi```, as it accounts for selection. In this tutorial, we want our model to capture the action of GC-bias gene conversion. For that, we define the ```gamma```, which represents the GC-bias rate. The allele fitnesses ```phi``` of G and C will thus be represented by ```gamma```, while those of A and T by 1.0.

```N``` is taken as a fixed value, and we set it to 10 to simplify the analyses. We could have fixed this value to 10 000 for the great apes or even consider it following a particular distribution. 

```
# population size
N <- 10
```

Since ```pi```, ```rho```, and ```gamma``` are stochastic variables, we need to specify a move to propose updates to them. A good move on variables drawn from a Dirichlet distribution (i.e., ```pi```) is the ```mvBetaSimplex```. This move randomly takes an element from the allele frequencies vector ```pi```, proposes a new value for it drawn from a Beta distribution, and then rescales all values to sum to 1 again. The weight option inside the moves specifies how often the move will be applied either on average per iteration or relative to all other moves. 


```
# allele frequencies
pi_prior <- [1,1,1,1]
pi ~ dnDirichlet(pi_prior)
moves.append( mvBetaSimplex(pi, weight=2) )
```

The ```rho``` and ```gamma``` parameters must be a positive real number, and a natural choice as the prior distribution is the exponential one. Again, we need to specify a move for these stochastic variables, and a simple scaling move ```mvScale``` typically works. Notice that ```phi``` is deterministic node that depends on the GC-bias rate ```gamma```.
```
# exchangeabilities
for (i in 1:6){
  rho[i] ~ dnExponential(10.0)
  moves.append(mvScale( rho[i], weight=2 ))
}

# fitness coefficients
gamma ~ dnExponential(1.0)
moves.append(mvScale( gamma, weight=2 ))
phi := [1.0,gamma,gamma,1.0]
```

The functions ```fnReversiblePoMoTwo4N``` and ```fnReversiblePoMoThree4N``` will create an instantaneous-rate matrix.

```
# rate matrix
Q := fnReversiblePoMoThree4N(N,pi,rho,phi)
```

The tree topology and branch lengths are stochastic nodes in our phylogenetic model. We will assume that all possible labeled, unrooted tree topologies have equal probability. In the case a unrooted tree topology, we use a nearest-neighbor interchange move ```mvNNI``` (a subtree-prune and regrafting move ```mvSPR``` could also be used).

```
# topology
topology ~ dnUniformTopology(taxa)
moves.append( mvNNI(topology, weight=2*n_taxa) )
```

Next, we have to create a stochastic node representing the length of each of the ```2*n_taxa−3``` branches in our tree. We can do this using a for loop. In this loop, we can create each of the branch-length nodes and assign each move.

```
# branch lengths
for (i in 1:n_branches) {
   branch_lengths[i] ~ dnExponential(10.0)
   moves.append( mvScale(branch_lengths[i]) )
}
```

Finally, we combine the tree topology and branch lengths. We do this using the ```treeAssembly``` function, which applies the value of the ith member of the ```branch_lengths``` vector to the branch leading to the ith node in the topology. Thus, the psi variable is a deterministic node:

```
psi := treeAssembly(topology, branch_lengths)
```

We have fully specified all of the parameters of our phylogenetic model:
* the tree with branch lengths ```phi```;
* the PoMo instantaneous-rate matrix ```Q```;
* the type of character data: i.e., ```NaturalNumbers```.

Collectively, these parameters comprise a distribution called the phylogenetic continuous-time Markov chain, and we use the ```dnPhyloCTMC``` function to create this node. This distribution requires several input arguments:
```
sequences ~ dnPhyloCTMC(psi,Q=Q,type="NaturalNumbers")
```

Once the ```PhyloCTMC``` model has been created, we can attach our sequence data to the tip nodes in the tree. Although we assume that our sequence data are random variables, they are realizations of our phylogenetic model. For inference purposes, we assume that the sequence data are *clamped* to their observed values.

```
sequences.clamp(data)
```

When this function is called, **RevBayes** sets each of the stochastic nodes representing the tree's tips to the corresponding nucleotide sequence in the alignment. This essentially tells the program that we have observed data for the sequences at the tips.

Finally, we wrap the entire model in a single object. To do this, we only need to give the ```model``` function a single node.
```
pomo_model = model(pi)
```

### Setting, running, and summarizing the MCMC simulation

For our MCMC analysis, we need to set up a vector of monitors to record the states of our Markov chain. First, we will initialize the model monitor using the ```mnModel``` function. This creates a new monitor variable that will output the states for all model parameters when passed into an MCMC function. We will sample every 10th iterate, and the resulting file can be found in the **output** folder.

```
monitors.append( mnModel(filename="output/great_apes_pomothree.log", printgen=10) )
```

The ```mnFile``` monitor will record the states for only the parameters passed in as arguments. We use this monitor to specify the output for our sampled trees and branch lengths. Again, we sample every 10th iterate.

```
monitors.append( mnFile(filename="output/great_apes_pomothree.trees", printgen=10, psi) )
```

Finally, create a screen monitor that will report the states of specified variables to the screen with ```mnScreen```. This monitor mostly helps us to see the progress of the MCMC run.

```
monitors.append( mnScreen(printgen=10) )
```

With a fully specified model, a set of monitors, and a set of moves, we can now set up the MCMC algorithm that will sample parameter values in proportion to their posterior probability. The ```mcmc``` function will create our MCMC object. Furthermore, we will perform two independent MCMC runs to ensure proper convergence and mixing.

```
pomo_mcmc = mcmc(pomo_model, monitors, moves, nruns=2, combine="mixed")
```

Now, run the MCMC. 

```
pomo_mcmc.run( generations=10000 )
```

When the analysis is complete, you will have the monitored files in your output directory. Programs like **Tracer** allow evaluating convergence and mixing. Look at the file called ```output/great_apes_pomothree.log``` in **Tracer**. There you see the posterior distribution of the continuous parameters. If your analyses are taking too long to finish, you can use the following output files:
* [&#8600;```great_apes_pomotwo.log```](/assets/session3/great_apes_pomotwo.log)
* [&#8600;```great_apes_pomothree.log```](/assets/session3/great_apes_pomothree.log)

Apart from the continuous parameters, we need to summarize the trees sampled from the posterior distribution. RevBayes can summarize the sampled trees by reading in the tree-trace file:

```
trace = readTreeTrace("output/great_apes_pomothree.trees", treetype="non-clock", burnin= 0.2)
```

The ```mapTree``` function will summarize the tree samples and write the maximum a posteriori (MAP) tree to the specified file. The MAP tree can be found in the **output** folder. 

```
mapTree(trace, file="output/great_apes_pomothree_MAP.tree" )
```

Look at the file called ```output/great_apes_pomothree_MAP.tree``` in FigTree. If your analyses are taking too long to finish, you can use the following output MAP trees:
* [&#8600;```great_apes_pomotwo_MAP.tree```](/assets/session3/great_apes_pomotwo_MAP.tree)
* [&#8600;```great_apes_pomothree_MAP.tree```](/assets/session3/great_apes_pomothree_MAP.tree)

### Some questions

1. Is there any evidence of GC-bias in these great apes sequences?
2. Compare the MAP trees of PoMoTwo and PoMoThree. What are the main differences between them?