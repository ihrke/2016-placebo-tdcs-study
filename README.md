# Placebo Intervention Enhances Reward Learning in Healthy Individuals

[![DOI](https://zenodo.org/badge/19634/ihrke/2016-placebo-tdcs-study.svg)](https://zenodo.org/badge/latestdoi/19634/ihrke/2016-placebo-tdcs-study)

This repository contains data and analyses for the paper "Placebo Intervention Enhances Reward Learning in Healthy Individuals".

If you want to use this data/analysis in a research publication,
please cite [our paper](http://www.nature.com/articles/srep41028).


Turi, Z., Mittner, M., Paulus, W. & Antal, A. (2017).
Placebo Intervention Enhances Reward Learning in Healthy Individuals. Scientific Reports. 7: 41028. doi:10.1038/srep41028

~~~{bibtex}
@article{Turi_placebo2016,
  author={Turi, Z. and Mittner, M. and Paulus, W. and Antal, A.},
  title={Placebo Intervention Enhances Reward Learning in Healthy Individuals},
  year=2017,
  journal={Scientific Reports},
  volume=7,
  number=41028,
  doi=10.1038/srep41028
}
~~~

## Requirements

Analysis are coded in [R](http://r-project.org) and [stan](http://mc-stan.org). Quite a lot R-packages and the [Stan](http://mc-stan.org) are required. It is easiest to set up the
R-packages using [conda](https://www.continuum.io/downloads).  We
provide an `environment.yml` file which allows to set up R with all
needed packages with very few commands.

1. download `anaconda` or `miniconda`

 e.g. on linux:
 ~~~{bash}
 wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
 bash Miniconda-latest-Linux-x86_64.sh
 conda update conda
 conda install anaconda-client anaconda-build conda-build
 ~~~

2. clone this repository
 ~~~{bash}
 git clone
 https://github.com/ihrke/2016-placebo-tdcs-study
 cd 2016-2016-placebo-tdcs-study
 ~~~

3. re-create the environment used for creating these analyses:
 ~~~{bash}
 conda env create
 ~~~

If you are not willing to do this, you will have to look at the
[environment.yml](./environment.yml) file to check all
dependencies.

## Setup

This repository uses the
[ProjectTemplate](http://projecttemplate.net/) directory layout. It
also provides an `environment.yml` which allows to set up R with all
needed packages with very few commands.

## Data

Raw data is located in `data/raw` and is provided in `.csv` format.

The `.R` scripts located in `data` load the raw files into `R`
workspace under the name of the `R`-file (without the `.R` extension).

*NOTE*: there are also pre-processed exports of all the variables discussed next; those are located under [data/export](data/export).


The data is structured as follows (refer to [the paper](http://www.nature.com/articles/srep41028) for
details).

### Subjectively reportex anticipation/expectations

stored in variable `antexp`

~~~
> summary(antexp)

      PID        AAntDirection   AAntAmount     AExpDirection   AExpAmount
 Min.   : 1.00   -1: 2         Min.   :-30.00   0   :15       Min.   :-15.000
 1st Qu.: 8.00   0 :10         1st Qu.:  0.00   1   :12       1st Qu.:  0.000
 Median :15.00   1 :17         Median : 10.00   -1  : 1       Median :  0.000
 Mean   :15.34                 Mean   : 13.58   NA's: 1       Mean   :  9.125
 3rd Qu.:23.00                 3rd Qu.: 30.00                 3rd Qu.: 15.625
 Max.   :30.00                 Max.   : 60.00                 Max.   : 60.000
                                                              NA's   :1
 BAntDirection   BAntAmount     BExpDirection   BExpAmount
 -1: 4         Min.   :-20.00   -1: 8         Min.   :-30.0000
 0 :10         1st Qu.:  0.00   0 :15         1st Qu.: -5.0000
 1 :15         Median : 10.00   1 : 6         Median :  0.0000
               Mean   : 10.62                 Mean   : -0.1724
               3rd Qu.: 15.00                 3rd Qu.:  0.0000
               Max.   : 60.00                 Max.   : 60.0000
               NA's   :1
~~~

### Subjectively reported arousal

stored in variable `arousal`

~~~
> summary(arousal)
Participant   BL_before         BL_after        A_before         A_after
1      : 1   Min.   : 4.000   Min.   : 3.00   Min.   : 2.000   Min.   :3.000
2      : 1   1st Qu.: 6.000   1st Qu.: 5.00   1st Qu.: 7.000   1st Qu.:5.000
3      : 1   Median : 8.000   Median : 7.00   Median : 7.000   Median :5.500
4      : 1   Mean   : 7.241   Mean   : 6.31   Mean   : 6.897   Mean   :6.071
5      : 1   3rd Qu.: 8.000   3rd Qu.: 8.00   3rd Qu.: 8.000   3rd Qu.:8.000
6      : 1   Max.   :10.000   Max.   :10.00   Max.   :10.000   Max.   :9.000
(Other):23                                                     NA's   :1
  B_before         B_after
Min.   : 4.000   Min.   :3.000
1st Qu.: 6.000   1st Qu.:5.000
Median : 7.000   Median :6.000
Mean   : 7.034   Mean   :6.036
3rd Qu.: 8.000   3rd Qu.:7.000
Max.   :10.000   Max.   :9.000
                NA's   :1
~~~

### Data from Reinforcement learning task (learning phase)

data from the three different sessions are stored in three variables

- `learn.N` - baseline
- `learn.A` - low-uncertainty condition 
- `learn.B` - high-uncertainty condition

and there is also a single data.frame `learn` combining the three where the factor `condition` specifies the condition

~~~
> summary(learn.N)
  Participant        pair   condition      ACC                RT
 P01    : 360   Min.   :1   N:10440   Min.   :-1.0000   Min.   :0.01671
 P02    : 360   1st Qu.:1             1st Qu.: 0.0000   1st Qu.:0.69982
 P03    : 360   Median :2             Median : 1.0000   Median :0.88307
 P04    : 360   Mean   :2             Mean   : 0.7006   Mean   :0.90199
 P05    : 360   3rd Qu.:3             3rd Qu.: 1.0000   3rd Qu.:1.08305
 P06    : 360   Max.   :3             Max.   : 1.0000   Max.   :1.68286
 (Other):8280                                           NA's   :165
     reward
 Min.   :0.0000
 1st Qu.:0.0000
 Median :1.0000
 Mean   :0.5875
 3rd Qu.:1.0000
 Max.   :1.0000
~~~

Variables are coded as follows:

- `Participant` - number of the participant (consistent across the three conditions)
- `pair`  - pair number (1,2,3) with (60/40, 70/30 or 80/20 % coherence)
- `condition` - one of N, A, B
- `ACC` - accuracy: 1 correct, 0 incorrect, -1 no response
- `RT` - reaction time in s
- `reward` - 1: reward was received, 0: no reward

### Data from Reinforcement learning task (transfer phase)

data from the three different sessions are stored in three variables

- `transfer.N` - baseline
- `transfer.A` - low uncertainty condition
- `transfer.B` - high uncertainty condition

and there is also a single data.frame `transfer` combining the three where the factor `condition` specifies the condition

~~~
> summary(transfer.N)
  Participant         RT          symb1   symb2    choice
 P01    : 180   Min.   :0.01675   A:870   A:870   A   :1258
 P02    : 180   1st Qu.:0.68321   B:870   B:870   B   : 457
 P03    : 180   Median :0.86648   C:870   C:870   C   :1268
 P04    : 180   Mean   :0.89940   D:870   D:870   D   : 565
 P05    : 180   3rd Qu.:1.08307   E:870   E:870   E   :1004
 P06    : 180   Max.   :1.68285   F:870   F:870   F   : 600
 (Other):4140   NA's   :68                        NA's:  68
~~~

Variables are coded as follows:

- `Participant` - number of the participant (consistent across the three conditions)
- `RT` - reaction time in s
- `symb1`, `symb2` - the two presented symbols (one of A,B,C,D,E,F)
- `choice` - which symbol was picked or `NA` in case of no response


## Analyses

All analyses are located in `src/`. To run the scripts, you need to
have the `ProjecTemplate` package and various other packages
installed.

The first two lines in each file
~~~{R}
library(ProjectTemplate)
load.project()
~~~
convert the raw data into a more convenient format by

1. running the `data/<dataset>.R` file
2. running the preprocessing scripts in `munge`
3. loading the convenience functions in `lib`
