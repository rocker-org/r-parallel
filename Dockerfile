## Emacs, make this -*- mode: sh; -*-
 
FROM rocker/r-base

MAINTAINER "Henrik Bengtsson" henrikb@braju.com

## System libraries
RUN apt-get update
RUN apt-get install -y libopenmpi-dev  # Rmpi
RUN apt-get install -y libzmq3-dev     # rzmq (via clustermq)

## Legacy (snow is deprecated)
RUN install.r snow
RUN install.r doSNOW 

## MPI
RUN install.r Rmpi

## Random Number Generation (RNG)
RUN install.r rlecuyer

## The foreach ecosystem
RUN install.r foreach doParallel doMC doRNG

## High-Performance Compute (HPC) environments
RUN install.r batchtools BatchJobs
RUN install.r clustermq

# RUN install.r Rmpi

## The future ecosystem
RUN install.r future
RUN install.r future.batchtools future.BatchJobs future.callr
RUN install.r doFuture
RUN install.r future.apply 
