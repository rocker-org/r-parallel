## Emacs, make this -*- mode: sh; -*-
 
FROM rocker/r-base

MAINTAINER "Henrik Bengtsson" henrikb@braju.com

## System libraries
RUN apt-get update
RUN apt-get install -y libopenmpi-dev  # Rmpi
RUN apt-get install -y libzmq3-dev     # rzmq (via clustermq)


## ------------------------------------------------------
## Core Parallel R Packages
## ------------------------------------------------------
## Legacy (snow is deprecated)
RUN install.r snow
RUN install.r doSNOW 

## MPI
## RUN install.r Rmpi

## Random Number Generation (RNG)
RUN install.r rlecuyer

## The future ecosystem
RUN install.r future

## The foreach ecosystem
RUN install.r foreach
RUN install.r doParallel
RUN install.r doFuture
RUN install.r doMC


## ------------------------------------------------------
## Other Parallel R Packages
## (lighter ones first - heavier later)
## ------------------------------------------------------
## The future ecosystem
RUN install.r future.apply
RUN install.r future.callr

## High-Performance Compute (HPC) environments
RUN install.r BatchJobs future.BatchJobs
RUN install.r batchtools future.batchtools
RUN install.r clustermq
