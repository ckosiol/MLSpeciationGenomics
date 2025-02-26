## Install RevBayes

### Compile on Linux

Follow the installation steps [here](https://revbayes.github.io/compile-linux). 

### Compile on Mac OS X

Follow the installation steps [here](https://revbayes.github.io/compile-osx). 

### Compile on Windows

Follow the installation steps [here](https://revbayes.github.io/compile-windows). However, we will not be using the standard revbayes branch for this workshop, but the one that has the PoMo models. Clone the ```dev_PoMo``` repository instead of the master one. This is done by substituting the following step  

```
 git clone https://github.com/revbayes/revbayes.git revbayes
```

by this one:

```
git clone --branch development https://github.com/revbayes/revbayes.git revbayes
```

