# Contributed Talks

### Placing ancient DNA sequences into reference phylogenies

**Bianca De Sanctis** [1,2], Rui Martiniano [2,3] and Richard Durbin [3,4]

[1] Department of Zoology, University of Cambridge, Cambridge CB2 3EJ, UK, [2] Department of Genetics, University of Cambridge, Cambridge CB2 3EJ, UK, [3] School of Biological and Environmental Sciences, Liverpool John Moores University, Liverpool L3 3AF, UK, [4] Wellcome Sanger Institute, Cambridge CB10 1SA, UK

During the last decade, large volumes of ancient DNA (aDNA) data have been generated as part of whole-genome shotgun and target capture sequencing studies. This includes sequences from non-recombining loci such as the mitochondrial or Y chromosomes. However, given the highly degraded nature of aDNA data, post-mortem deamination and often low genomic coverage, combining ancient and modern samples for phylogenetic analyses remains difficult. Here, we develop a workflow to place ancient DNA samples into reference phylogenetic trees, using either a parsimony (""best-path"") or likelihood-based approach. We illustrate this method on woolly mammoth mitochondrial reads from a sedimentary DNA dataset from 73 sites across the Arctic, covering the last 50,000 years. A total of 104 samples were placed on the tree at some level, indicating continuity of some clades longer than previously known, and suggesting a previously unseen subclade. This study illuminates the population dynamics and evolution of woolly mammoths, and shows that we can obtain species-specific phylogenetic information from fragmented, damaged, and low-quality ancient environmental DNA reads.


### **Dating Alphaproteobacteria evolution with eukaryotic fossils**

**Sishuo Wang** [1], Haiwei Luo [1]

[1] The Chinese University of Hong Kong

Elucidating the timescale of evolution of bacteria is key to testing hypotheses on their co-evolution with eukaryotic hosts, which, however, is largely limited by the scarcity of bacterial fossils. Here, we incorporate eukaryotic fossils to date the divergence times of Alphaproteobacteria, based on the endosymbiosis theory that mitochondria evolved from an alphaproteobacterial lineage. We estimate that Alphaproteobacteria arose ~1900 million years (Ma) ago, followed by rapid divergence of their major clades. We show that the origin of Rickettsiales, an order of obligate intracellular bacteria whose hosts are mostly animals, predates the emergence of animals for ~700 Ma but coincides with that of eukaryotes. This, together with reconstruction of ancestral hosts, strongly suggests that early Rickettsiales lineages had established previously underappreciated interactions with unicellular eukaryotes. Our mitochondria-based approach displays higher precision and robustness to uncertainties compared with the traditional strategy using cyanobacterial fossils, and suggests that previous applications using divergence times of the modern hosts of symbiotic bacteria to date the bacterial tree of life may need to be revisited.


### **ILS-Aware Analyses of Retroelement Insertions in the Anomaly Zone**

**Erin Molloy** [1], John Gatesy [2], Mark Springer [3]

[1] University of California, Los Angeles; [2] American Museum of Natural History; [3] University of California, Riverside

A major shortcoming of concatenation methods for species tree estimation is their failure to account for incomplete lineage sorting (ILS). Coalescent methods explicitly address this problem but make various assumptions that, if violated, can result in worse performance than concatenation. Given the challenges of analyzing DNA sequences, retroelement insertions have emerged as powerful markers for species tree estimation. In this talk, we show that two recently proposed methods, SDPquartets and ASTRAL_BP, are statistically consistent estimators of the species tree under the multispecies coalescent model, with retroelement insertions following a neutral infinite sites model of mutation. We then evaluate the empirical performance of ASTRAL_BP and SDPquartets on retroelement data sets simulated from several model species trees in the anomaly zone. Our results show that ASTRAL_BP and SDPquartets always recover the correct species tree topology on data sets with large numbers of retroelement insertions. Dollo parsimony performed almost as well as ASTRAL_BP and SDPquartets. These three methods outperformed MDC, unordered parsimony, polymorphism parsimony, and Camin-Sokal parsimony. Lastly, we provide an efficient approach for estimating branch lengths in coalescent units with ASTRAL_BP, assuming the expected number of new retroelement insertions per generation is constant across the species tree. For more information, check out our preprint on [bioRxiv](https://www.biorxiv.org/content/10.1101/2020.09.29.319038v1).


### **On the terminal branch length distribution and its application in the singleton density score**

**Benjamin Wölfl** [1,2]

[1] University of Vienna Institute of Mathematics, [2] Vienna Graduate School of Population Genetics

I combine efficient backward-time and forward-time simulations of simple to complex evolutionary scenarios in order to describe the terminal branch length distribution of the emerging coalescence trees across all trait contributing loci. In particular, I am interested in the behavior of the distribution under polygenic adaptation. Generally, there is no analytical expression for this distribution which raises the importance of this computational insight. In the next step, this scenario-dependent distribution is used in order to conduct a better performance test of the singleton density score (SDS) in inferring selection. In this way, I want to focus our attention on the characteristics of this distribution, in particular when we are not facing a simple recent hard sweep.




### **Dissecting genomic determinants of positive selection with an evolution-guided regression model**

**Yi-Fei Huang** [1]	

[1] Pennsylvania State University

In evolutionary genomics, it is fundamentally important to understand how characteristics of genomic sequences, such as the expression level of a gene, determine the rate of adaptive evolution. While numerous statistical methods, such as the McDonald-Kreitman test, are available to examine the association between genomic features and positive selection, we currently lack a statistical approach to disentangle the direct effects of genomic features from the indirect effects mediated by confounding factors. To address this problem, we present a novel statistical model, the MK regression, which augments the McDonald-Kreitman test with a generalized linear model. Analogous to the classic multiple regression model, the MK regression can analyze multiple genomic features simultaneously to distinguish between direct and indirect effects on positive selection. Using the MK regression, we identify numerous genomic features responsible for positive selection in chimpanzees, including local mutation rate, residue exposure level, gene expression level, tissue specificity, and metabolic genes. In particular, we show that highly expressed genes have a higher rate of adaptation than their weakly expressed counterparts, even though a higher expression level may impose stronger negative selection on protein sequences. Also, we observe that metabolic genes tend to have a higher rate of adaptation than their non-metabolic counterparts, possibly due to recent changes in diet in primate evolution. Overall, the MK regression is a powerful approach to elucidate the genomic basis of adaptation.

### **Convergence assessment in Phylogenetics**

**Luiza Fabreti** [1,2] and Sebastian Höhna [1,2]

[1] GeoBio-Center Ludwig-Maximilians-Universität München, [2] Department of Earth and Environmental Sciences, Paleontology & Geobiology, Ludwig-Maximilians-Universität
München

Convergence assessment in Bayesian phylogenetic analysis aims to guarantee that the samples from the MCMC were taken from the stationary distribution. In practice, this is done by checking the output from such analysis for signs of lack of convergence. Phylogenetic trees present a special challenge given their discrete nature. Current methods to assess convergence, both in the statistical and in the phylogenetic field, lack clear thresholds and guidelines for the user. We propose a new method that evaluates two major characteristics of the MCMC output: precision
and reproducibility. For a given precision on the mean estimate, we derive a theory based threshold for the Effective Sample Size (ESS) of 625. Based on this ESS, we derive further criteria to evaluate the continuous and discrete parameters for reproducibility across chains. The criteria for reproducibility are applied to the individual chains, to calculate the most appropriate burn-in.
We implemented these methods in an easy-to-use R package called Convenience. The package includes a fully automated analysis with clear stated results to facilitate the convergence assessment in the phylogenetic framework. Further features of the package enable usage on cluster computers and iteratively.
"
### **sMap: Evolution of independent, dependent and conditioned discrete characters in a Bayesian framework**

**Giorgio Bianchini** [1], Patricia Sánchez-Baracaldo [1]

[1] School of Geographical Sciences, University of Bristol, Bristol, UK

Trait evolution analyses enable the comparison of characters amongst different species — a useful technique when inferring ancestral phenotypes based on a phylogeny of living taxa. The evolution of discrete characters can be mapped on the branches of a phylogenetic tree using stochastic mapping. I would like to present sMap, a new program to perform stochastic mapping analyses.
Key features characterising sMap are: a wide variety of models and prior distributions; the ability to use a posterior distribution of trees and to compute marginal likelihoods to perform model selection analyses; and the implementation of three kinds of characters: ‘independent’ characters, which do not interact with each other; ‘dependent’ characters, which co-evolve at the same time; and ‘conditioned’ characters, whose state is determined by the state of other characters.
Conditioned characters, in particular, are a completely novel feature; they make it possible to model the effects on a single complex phenotype of the interaction of multiple simple characters.
sMap can produce robust results and answer new kinds of questions. It is freely available and distributed under a GPL licence, in a command-line and Graphical User Interface version; a detailed user manual with examples and tutorials is also provided.
The wide variety of algorithms implemented in sMap enables accurate analyses of the evolution of discrete characters. As a multiplatform and open-source project, sMap can be used on a variety of systems and situations, such as academic research and teaching.


### **The corrected Synonymous Dinucleotide Usage: a novel framework for quantifying genomic dinucleotide representation**

**Spyros Lytras** [1], Joseph Hughes [1]

[1] MRC-University of Glasgow Centre for Virus Research, Scotland, UK

Distinct patterns of dinucleotide representation, such as CpG and UpA suppression, are characteristic of certain viral genomes. Recent research has uncovered vertebrate immune mechanisms that select against specific dinucleotides in targeted viruses. This evidence highlights the importance of systematically examining the dinucleotide composition of viral genomes. We have developed a novel metric, called corrected synonymous dinucleotide usage (SDUc), for quantifying dinucleotide representation in coding sequences. Our method compares the observed abundance of a given dinucleotide combination to that expected based on the sequence’s single nucleotide composition, while also accounting for amino acid composition. We present a Python3 package, DinuQ, for calculating SDUc and other relevant metrics for exploring dinucleotide and codon biases. The package allows for various parameterisations of the SDUc metric and a method for determining error around the results. We apply our method on a set of Sarbecoviruses to show that the phylogenetic clade SARS-CoV-2 belongs to is associated with an adaptive reduction in the CpG composition of their genomes. We further show how CpG composition is clearly reflective of recombination patterns in these coronaviruses.

### **Generalizing Bayesian phylogenetics to infer shared evolutionary events**

**Jamie R. Oaks** [1] and Perry L. Wood Jr. [1]

[1] Department of Biological Sciences & Museum of Natural History, Auburn University, Auburn, Alabama 36849

Over the past two decades, much progress has been made in developing phylogenetic methods for estimating rooted, time-proportional trees. However, all of these methods assume that processes of diversification affect evolutionary lineages independently; i.e., divergence times are independent conditional on the topology. This assumption is likely violated in nature by processes that cause multiple lineages to diverge. Such processes are potentially common in biogeography, epidemiology, and genome evolution. We introduce a general Bayesian framework to relax the assumption of independent divergences during phylogenetic inference and test hypotheses about processes of diversification that affect multiple evolutionary lineages. Using simulations, we find that the new method accurately infers shared divergence events when they occur, and performs as well as current methods when divergences are independent. We apply our new approach to genomic data from geckos from the Philippines to test the hypothesis that interglacial rises in sea level caused bursts of speciation across the islands.


### **Ordering the events in the ancient tree of life with edge length ratio distributions.**

**Andrew J. Roger** [1], Ed Susko [1], Dandan Zhao [1], Laura Eme [2], Mike Steel [3] and Dan Gaston [4]

[1] Centre for Comparative Genomics and Evolutionary Bioinformatics, Dalhousie University, Halifax, Nova Scotia, Canada, B3H 4R2, [2] CNRS - Université Paris-Sud 
Unité Ecologie Systématique Evolution, Bâtiment 360 91405 Orsay Cedex, France, [3] Biomathematics Research Centre, University of Canterbury, Christchurch, New Zealand 8041, [4]  Department of Pathology, Nova Scotia Health Authority and Dalhousie University, Halifax, Nova Scotia, Canada B3H 4R2

Two recent high profile studies have attempted to use edge (branch) length ratios from large sets of phylogenetic trees to determine the relative ages of genes of different origins in the evolution of eukaryotic cells. This approach can be straightforwardly justified if substitution rates are constant over the tree for a given protein. However, such strict molecular clock assumptions are not expected to hold on the billion-year timescale. I will discuss an alternative set of conditions under which comparisons of edge length distributions from multiple groups of phylogenies of proteins with different origins can be validly used to discern the order of their origins. Then I will show that functional divergence in proteins adapting to new cellular roles during the prokaryote-eukaryote transition has differentially affected edge length distributions of genes of different origins, complicating attempts to order the events that occurred during eukaryogenesis.


### **Inferring divergence times using a stepwise Bayesian approach**

**Allison Yi Hsiang** [1,2] and Sebastian Höhna [1,2]

[1] GeoBio-Center LMU, Ludwig-Maximilians-Universität München, Richard-Wagner-Str. 10, 80333 Munich, Germany, [2] Department of Earth and Environmental Sciences, Paleontology & Geobiology, Ludwig-Maximilians-Universität München, Richard-Wagner-Str. 10, 80333 Munich, Germany

The ability to robustly and efficiently infer divergence times is needed to understand the history, timing, and tempo of evolutionary events. Most divergence time trees are inferred in full Bayesian frameworks, where the topology and node ages are estimated simultaneously (i.e., in a joint approach). While this is the ideal approach given current methods, jointly inferring all of these parameters can be computationally prohibitive as datasets increase in size (both in terms of number of taxa and number of sites). Furthermore, the joint approach limits the sequence evolution and/or clock models that can be applied, as users must use the same software for both. Here, we present a stepwise approach to inferring divergence times under a Bayesian framework, as implemented in the probabilistic graphical model environment RevBayes. In this approach, a sample of unrooted trees is generated first. We then perform importance sampling on the distribution of trees produced in step 1, and use this as data input for the second step, where the clock model parameters are estimated to infer the node ages of the divergence time tree. The advantages of this approach lie in improved computational efficiency (as the time-consuming step of calculating the likelihood of the sequence data is skipped in the second step) and in allowing users the freedom to choose different software packages for each of the steps. In theory, and shown by our toy examples, the joint inference and stepwise inference produce identical posterior distributions (i.e., not more dissimilar than would be expected due to stochasticity).