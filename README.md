# modelselection
<!-- badges: start -->
[![R-CMD-check](https://github.com/chunhaowu/modelslection/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/chunhaowu/modelslection/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/chunhaowu/modelslection/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/chunhaowu/modelslection/actions/workflows/test-coverage.yaml)
<!-- badges: end -->
----
## Overview
* This package is used for backward or forward selection for linear regression.
   * Forward selection: start with null model; add covariates one at a time
   * Backward selection: start with full model;delete coovariates one at a time <br>
 * From this package we will get the detailed process of adding or deleting covariates and final model. <br>
 * You can learn more about them in *Tutorial.html* in vignette folder.
----


## installation
* install.packages('modelselection')
----
## Usage
```{r}
#Import package
library(modelselection)

#set a dataset 
set.seed(7.1245)
data=matrix(rnorm(700),100,7)
colnames(data)=c("y","x1","x2","x3","x4","x5","x6")
data=data.frame(data)

#run linear regression example
lm1=lm(y~x1,data=data)
lm2=lm(y~.,data=data)

#forward selection
selection(lm1,lm2,direction="forward",trace=1)

Start: AIC= -5.428045 
     Df Sum of Sq      Rss        AIC
x4    1 6.8800258 84.12273 -11.289344
x3    1 3.0333615 87.96939  -6.818128
None  0 0.0000000 91.00275  -5.428045
x5    1 0.9449805 90.05777  -4.471883
x6    1 0.3079665 90.69478  -3.767033
x2    1 0.2821497 90.72060  -3.738572
Start: AIC= -11.28934 
     Df Sum of Sq      Rss        AIC
x3    1 1.9961466 82.12658 -11.690849
None  0 0.0000000 84.12273 -11.289344
x5    1 1.2802099 82.84252 -10.822879
x6    1 0.5285894 83.59414  -9.919681
x2    1 0.3158991 83.80683  -9.665572
Start: AIC= -11.69085 
     Df Sum of Sq      Rss       AIC
None  0 0.0000000 82.12658 -11.69085
x5    1 0.9521198 81.17446 -10.85695
x6    1 0.5885968 81.53798 -10.41012
x2    1 0.4127031 81.71388 -10.19464

Call:
lm(formula = y ~ ., data = data_temp)

Coefficients:
(Intercept)           x1           x4           x3  
    0.14866      0.06318     -0.26590      0.14054  

#backward selection
selection(lm2,lm2,direction="backward",trace=1)

Start: AIC= -8.203491 
     Df Sum of Sq      Rss        AIC
x2    1 0.1252142 80.21395 -10.047269
x1    1 0.4749354 80.56368  -9.612231
x6    1 0.7241413 80.81288  -9.303380
x5    1 1.2335654 81.32231  -8.674984
None  0 0.0000000 80.08874  -8.203491
x3    1 1.7321358 81.82088  -8.063776
x4    1 6.4711156 86.55986  -2.433403
Start: AIC= -10.04727 
     Df Sum of Sq      Rss        AIC
x1    1 0.4240023 80.63796 -11.520071
x6    1 0.9605039 81.17446 -10.856954
x5    1 1.3240269 81.53798 -10.410124
None  0 0.0000000 80.21395 -10.047269
x3    1 1.6816865 81.89564  -9.972442
x4    1 6.5097184 86.72367  -4.244329
Start: AIC= -11.52007 
     Df Sum of Sq      Rss        AIC
x6    1 0.9688433 81.60680 -12.325759
x5    1 1.1852106 81.82317 -12.060976
None  0 0.0000000 80.63796 -11.520071
x3    1 2.1934315 82.83139 -10.836311
x4    1 6.1193114 86.75727  -6.205598
Start: AIC= -12.32576 
     Df Sum of Sq      Rss        AIC
x5    1 0.8284962 82.43530 -13.315648
None  0 0.0000000 81.60680 -12.325759
x3    1 2.1817113 83.78851 -11.687428
x4    1 5.7595943 87.36639  -7.505948
Start: AIC= -13.31565 
     Df Sum of Sq      Rss        AIC
None  0  0.000000 82.43530 -13.315648
x3    1  2.461797 84.89709 -12.373033
x4    1  5.586201 88.02150  -8.758911

Call:
lm(formula = y ~ ., data = data_temp)

Coefficients:
(Intercept)           x3           x4  
     0.1567       0.1524      -0.2464  
