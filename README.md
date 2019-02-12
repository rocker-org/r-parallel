# r-parallel

A Docker container with a base [R] installation together with several parallel/asynchronous R packages pre-installed.  It extends the [rocker/r-base] container.


## Usage

To build the container locally, do:

```sh
$ docker build . --tag henrikbengtsson/r-parallel
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

To pull it down from Docker Hub, do:

```sh
$ docker pull henrikbengtsson/r-parallel
Using default tag: latest
latest: Pulling from henrikbengtsson/r-parallel
[...]

$ 
```


To launch R in the container, do:

```sh
$ docker run -ti henrikbengtsson/r-parallel

R version 3.5.1 (2018-07-02) -- "Feather Spray"
Copyright (C) 2018 The R Foundation for Statistical Computing
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
> y <- foreach(x = 1:3, .combine = c) %dopar% sqrt(x)
> y
[1] 1.000000 1.414214 1.732051

> quit("no")

$ 
```


[R]: https://www.r-project.org/
[rocker/r-base]: https://hub.docker.com/r/rocker/r-base/
