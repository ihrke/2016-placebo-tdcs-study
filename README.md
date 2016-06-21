# Placebo Intervention Enhances Reward Learning in Healthy Individuals

[![DOI](https://zenodo.org/)](https://zenodo.org/)

This repository contains data and analyses for the paper "Placebo Intervention Enhances Reward Learning in Healthy Individuals".

If you want to use this data/analysis in a research publication,
please cite our paper.


Turi, Z., Mittner, M., Paulus, W. & Antal, A. (submitted).
Placebo Intervention Enhances Reward Learning in Healthy Individuals.

~~~{bibtex}
@article{Turi_placebo2016,
  author={},
  title={Placebo Intervention Enhances Reward Learning in Healthy Individuals},
  year=2016,
  journal={}
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
 https://github.com/ihrke/2016-executive-functions-manual-dexterity.git
 cd 2016-executive-functions-manual-dexterity
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

Raw data is located in `data/raw` and is provided in `.csv` and `.sav`
(IBM SPSS) format. Data in those files was manually collected from the
different sources.

The `.R` scripts located in `data` load the two raw files into `R`
workspace under the name of the `R`-file (without the `.R` extension).

The data is structured as follows (refer to [the paper]() for
details).

### Cognitive results

stored in variable `cognitive`

~~~
> summary(cognitive)

    Studieår         MMSE            BDI        Tallspenn_forlengs Tallspenn_baklengs    Stroop_W         Stroop_C
 Min.   : 7.0   Min.   :25.00   Min.   : 0.00   Min.   : 5.000     Min.   : 3.000     Min.   : 68.00   Min.   :39.00
 1st Qu.:13.0   1st Qu.:28.25   1st Qu.: 1.25   1st Qu.: 6.000     1st Qu.: 5.000     1st Qu.: 90.25   1st Qu.:63.25
 Median :16.0   Median :29.00   Median : 3.50   Median : 8.000     Median : 6.000     Median : 99.00   Median :68.00
 Mean   :14.7   Mean   :28.80   Mean   : 4.30   Mean   : 7.767     Mean   : 6.133     Mean   : 98.23   Mean   :67.73
 3rd Qu.:17.0   3rd Qu.:30.00   3rd Qu.: 6.75   3rd Qu.: 9.000     3rd Qu.: 7.000     3rd Qu.:103.00   3rd Qu.:74.50
 Max.   :20.0   Max.   :30.00   Max.   :11.00   Max.   :13.000     Max.   :10.000     Max.   :119.00   Max.   :84.00

   Stroop_WC       Trail_M_A       Trail_M_B      Dynamo_Høyrehånd Dynamo_Venstrehånd   Handedness
 Min.   :20.00   Min.   :13.00   Min.   : 31.50   Min.   :15.33    Min.   :13.83      Min.   :12.00
 1st Qu.:29.75   1st Qu.:18.50   1st Qu.: 43.38   1st Qu.:25.75    1st Qu.:22.33      1st Qu.:19.25
 Median :38.50   Median :26.75   Median : 59.75   Median :32.00    Median :28.83      Median :21.50
 Mean   :38.77   Mean   :29.73   Mean   : 73.28   Mean   :34.71    Mean   :32.34      Mean   :20.80
 3rd Qu.:44.75   3rd Qu.:38.38   3rd Qu.:100.88   3rd Qu.:40.42    3rd Qu.:39.50      3rd Qu.:24.00
 Max.   :57.00   Max.   :60.00   Max.   :156.00   Max.   :60.83    Max.   :62.17      Max.   :24.00
                                                                   NA's   :1
~~~

### movement times

Are in two separate variables for the two tasks:

~~~
> summary(movement.times.task1)
      subj               action    object       repetition         time
 Min.   : 1.0   REACHING    :360   pin:1440   Min.   : 1.00   Min.   : 116.7
 1st Qu.: 8.0   GRASPING    :360              1st Qu.: 3.75   1st Qu.: 183.3
 Median :15.5   TRANSPORTING:360              Median : 6.50   Median : 283.3
 Mean   :15.5   INSERTING   :360              Mean   : 6.50   Mean   : 443.8
 3rd Qu.:23.0                                 3rd Qu.: 9.25   3rd Qu.: 583.3
 Max.   :30.0                                 Max.   :12.00   Max.   :4883.3
                                                              NA's   :501
~~~

~~~
> summary(movement.times.task2)
      subj               action        object      repetition        time
 Min.   : 1.0   GRASPING    :960   collar :960   Min.   :1.00   Min.   :  16.67
 1st Qu.: 8.0   INSERTING   :960   pin    :960   1st Qu.:2.75   1st Qu.: 183.33
 Median :15.5   REACHING    :960   washer1:960   Median :4.50   Median : 283.33
 Mean   :15.5   TRANSPORTING:960   washer2:960   Mean   :4.50   Mean   : 485.00
 3rd Qu.:23.0                                    3rd Qu.:6.25   3rd Qu.: 650.00
 Max.   :30.0                                    Max.   :8.00   Max.   :5416.66
                                                                NA's   :1273

~~~

- `action` codes the movement type
- `object` are different types of objects (in the complex assembly
  task)
- `repetition` is the index of the repetition for each subject
- `time` is the movement time for each of the actions in ms

### kinematics

The kinematics variables follow the same structure:

~~~
> summary(kinematics.task1)
      subj               action    object       repetition       PeakVel          MeanAngVel      TimePeakVel
 Min.   : 1.0   REACHING    :360   pin:1440   Min.   : 1.00   Min.   :  55.72   Min.   : 18.81   Min.   :  0.00
 1st Qu.: 8.0   GRASPING    :360              1st Qu.: 3.75   1st Qu.: 215.86   1st Qu.: 77.02   1st Qu.:  3.00
 Median :15.5   TRANSPORTING:360              Median : 6.50   Median : 340.43   Median :120.02   Median :  7.00
 Mean   :15.5   INSERTING   :360              Mean   : 6.50   Mean   : 439.89   Mean   :142.09   Mean   : 13.26
 3rd Qu.:23.0                                 3rd Qu.: 9.25   3rd Qu.: 521.54   3rd Qu.:185.21   3rd Qu.: 18.75
 Max.   :30.0                                 Max.   :12.00   Max.   :3442.59   Max.   :577.75   Max.   :132.00
                                                              NA's   :786       NA's   :786      NA's   :786
  NrChangesVel       PeakDisp       MeanAngDisp      TimePeakDisp    NrChangesDisp
 Min.   : 0.000   Min.   : 2.781   Min.   :-17.47   Min.   : 0.000   Min.   : 0.000
 1st Qu.: 2.000   1st Qu.:38.188   1st Qu.: 25.56   1st Qu.: 2.000   1st Qu.: 2.000
 Median : 3.000   Median :47.255   Median : 34.83   Median : 6.000   Median : 3.000
 Mean   : 5.011   Mean   :47.657   Mean   : 34.48   Mean   : 9.844   Mean   : 4.797
 3rd Qu.: 6.000   3rd Qu.:56.413   3rd Qu.: 43.88   3rd Qu.:12.000   3rd Qu.: 6.000
 Max.   :35.000   Max.   :90.078   Max.   : 75.76   Max.   :82.000   Max.   :48.000
 NA's   :786      NA's   :786      NA's   :786      NA's   :786      NA's   :786
~~~

~~~
> summary(kinematics.task2)
      subj               action        object      repetition      PeakVel          MeanAngVel       TimePeakVel
 Min.   : 1.0   GRASPING    :960   collar :960   Min.   :1.00   Min.   :  13.77   Min.   :  1.832   Min.   :  0.0
 1st Qu.: 8.0   INSERTING   :960   pin    :960   1st Qu.:2.75   1st Qu.: 203.34   1st Qu.: 67.525   1st Qu.:  3.0
 Median :15.5   REACHING    :960   washer1:960   Median :4.50   Median : 310.64   Median :109.112   Median :  7.0
 Mean   :15.5   TRANSPORTING:960   washer2:960   Mean   :4.50   Mean   : 401.88   Mean   :131.234   Mean   : 14.4
 3rd Qu.:23.0                                    3rd Qu.:6.25   3rd Qu.: 476.89   3rd Qu.:167.674   3rd Qu.: 21.0
 Max.   :30.0                                    Max.   :8.00   Max.   :4034.92   Max.   :757.919   Max.   :294.0
                                                                NA's   :2164      NA's   :2165      NA's   :2165
  NrChangesVel       PeakDisp       MeanAngDisp      TimePeakDisp    NrChangesDisp
 Min.   : 0.000   Min.   :-15.34   Min.   :-24.20   Min.   :  0.00   Min.   : 0.000
 1st Qu.: 2.000   1st Qu.: 35.93   1st Qu.: 24.59   1st Qu.:  2.00   1st Qu.: 2.000
 Median : 4.000   Median : 46.41   Median : 34.50   Median :  7.00   Median : 3.000
 Mean   : 5.556   Mean   : 48.49   Mean   : 35.73   Mean   : 13.61   Mean   : 4.786
 3rd Qu.: 7.000   3rd Qu.: 60.55   3rd Qu.: 46.48   3rd Qu.: 17.00   3rd Qu.: 6.000
 Max.   :82.000   Max.   : 90.90   Max.   : 88.69   Max.   :292.00   Max.   :57.000
 NA's   :2165     NA's   :2262     NA's   :2165     NA's   :2165     NA's   :2165
~~~

Variables have the same names as above and the kinematic variables are
coded as follows:

- `PeakVel` (PV) -  peak velocity
- `MeanAngVel` (MNV) - mean angular velocity
- `TimePeakVel` (TPV) - time to peak velocity
- `NrChangesVel` (NCV) - number of changes in velocity
- `PeakDisp` (PD) - peak displacement
- `MeanAngDisp` (MND) - mean angular displacement
- `TimePeakDisp` (TPD) - time to peak displacement
- `NrChangesDisp` (NCD) - number of changes in displacement

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
