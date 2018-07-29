# r-base-parallel

A Docker container with a base [R] installation together with several parallel/asynchronous R packages pre-installed.  It extends the [rocker/r-base] container.


## Usage

To build the container locally, do:

```sh
$ make build
docker build . --tag henrikbengtsson/r-base-parallel
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

To launch R in the container, do:

```sh
$ make run
docker run -ti henrikbengtsson/r-base-parallel

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

> library(future)
> plan(multiprocess)
> Sys.getpid()
[1] 1
> f <- future(Sys.getpid())
> value(f)
[1] 13
> 
```


[R]: https://www.r-project.org/
[rocker/r-base]: https://hub.docker.com/r/rocker/r-base/
