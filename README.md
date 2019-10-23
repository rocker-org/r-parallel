# r-parallel

This is a Docker-based Linux container that consists of the base [R] installation, by extending the [rocker/r-base] container, together with several system libraries and R packages useful for parallel/asynchronous processing.


## Build

To build the container locally, do:

```sh
$ docker build . --tag rocker/r-parallel
Sending build context to Docker daemon  56.32kB
Step 1/17 : FROM rocker/r-base
latest: Pulling from rocker/r-base
28507814f909: Pull complete 
8205b68cfb04: Pull complete 
bbf1b2b5c36c: Pull complete 
6fc27852fced: Pull complete 
8cdff7e970c4: Pull complete 
e81d795a3e2b: Downloading ...
[...]

$ 
```

To pull it down from [Docker Hub](https://hub.docker.com/r/rocker/r-parallel/), do:

```sh
$ docker pull rocker/r-parallel
Using default tag: latest
latest: Pulling from rocker/r-parallel
[...]

$ 
```


## Usage

### Standalone

To launch R by itself, do:

```sh
$ docker run -ti rocker/r-parallel

R version 3.6.1 (2019-07-05) -- "Action of the Toes"
Copyright (C) 2019 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> y <- sapply(1:3, FUN = function(x) sqrt(x))
> y
[1] 1.000000 1.414214 1.732051

> library(parallel)
> y <- mclapply(1:3, FUN = function(x) sqrt(x))
> y <- Reduce(c, y)
> y
[1] 1.000000 1.414214 1.732051

> cl <- makeCluster(future::availableCores())
> y <- parSapply(cl, X = 1:3, FUN = function(x) sqrt(x))
> y
[1] 1.000000 1.414214 1.732051
> stopCluster(cl)

> library(future.apply)
> plan(multiprocess)
> y <- future_sapply(1:3, FUN = function(x) sqrt(x))
> y
[1] 1.000000 1.414214 1.732051

> library(foreach)
> doFuture::registerDoFuture()
> plan(multiprocess)
> y <- foreach(x = 1:3, .combine = c) %dopar% sqrt(x)
> y
[1] 1.000000 1.414214 1.732051

> quit("no")

$ 
```


### As R Background Workers

To launch a parallel cluster consisting of two R workers that are running in their own [Docker] container, _from the R installation installed on the host system_, do:

```r
$ R --quiet

> library(parallel)
> cl <- future::makeClusterPSOCK(rep("localhost", times = 2L), rscript = c(
    "docker", "run", "--net=host", "rocker/r-parallel", "Rscript"
  ))
> print(cl)
socket cluster with 2 nodes on host ‘localhost’

> y <- parSapply(cl, 1:3, function(x) sqrt(x))
> y
[1] 1.000000 1.414214 1.732051

> stopCluster(cl)
```

To do the same using [Singularity], do:

```r
> library(parallel)
> cl <- future::makeClusterPSOCK(rep("localhost", times = 2L), rscript = c(
    "singularity", "exec", "docker://rocker/r-parallel", "Rscript"
  ))
> print(cl)
socket cluster with 2 nodes on host ‘localhost’

> y <- parSapply(cl, 1:3, function(x) sqrt(x))
> y
[1] 1.000000 1.414214 1.732051

> stopCluster(cl)
```

[R]: https://www.r-project.org/
[Docker]: https://www.docker.com/
[Singularity]: https://www.sylabs.io/singularity/
[rocker/r-base]: https://hub.docker.com/r/rocker/r-base/

