# modelselection

----
## Overview
* This package is an improved version of standard kmeans clustering which is Lloyd algorithm. The main improved part is initial centroids sampling. 
* Standard sampling method is to randomly select k points( k is number of clusters) as initial centroids. Yet this way usually converges too slow. The improved 
version has 3 steps:
   * Step 1: From all objects randomly select one. 
   * Step 2: select next initial centroids from n-objects in such a way that the Euclidean distance
of that object is maximum from other selected initial centroids.
   * Step 3: repeat step 2 until we get k initial centroids. <br>
 * From these steps we will get initial centroids and with these initial centroids to perform kMeans algorithm. <br>
 * You can learn more about them in *Tutorial.html* in vignette folder.
----

## Backend
* The improvement idea is from [here](https://www.ijcsmc.com/docs/papers/July2013/V2I7201338.pdf) but including some changes.
----

## installation
* install.packages('Kmeansimp')
----
## Usage
```{r}
library(Kmeansimp) 
Kmeansimp(df, 2, iter = 20) 
$each_cluster_size
[1] 7 5 7 6
$Cluster_means
     [,1] [,2] [,3] [,4]
[1,] 11.0 36.0 61.0 86.0
[2,] 23.0 48.0 73.0 98.0
[3,]  4.0 29.0 54.0 79.0
[4,] 17.5 42.5 67.5 92.5
$`Clustering_Vevtor:`
 [1] 3 3 3 3 3 3 3 1 1 1 1 1 1 1 4 4 4 4 4 4 2 2 2 2 2
$`Within_cluster_sum_of_squares(withinSS)`
[1] 112  40 112  70
$`proportion of betweenSS with totalSS`
[1] 0.94
Kmeansimp(matrix, 4, 10) 
$each_cluster_size
[1] 7 6 6 6
$Cluster_means
     [,1] [,2] [,3] [,4]
[1,] 10.0 35.0 60.0 85.0
[2,] 22.5 47.5 72.5 97.5
[3,]  3.5 28.5 53.5 78.5
[4,] 16.5 41.5 66.5 91.5
$`Clustering_Vevtor:`
 [1] 3 3 3 3 3 3 1 1 1 1 1 1 1 4 4 4 4 4 4 2 2 2 2 2 2
$`Within_cluster_sum_of_squares(withinSS)`
[1] 112  70  70  70
$`proportion of betweenSS with totalSS`
[1] 0.94
Kmeansimp(matrix, 5)
$each_cluster_size
[1] 5 4 3 4 4
$Cluster_means
     [,1] [,2] [,3] [,4] [,5]
[1,] 10.0 30.0 50.0 70.0 90.0
[2,] 18.5 38.5 58.5 78.5 98.5
[3,]  2.0 22.0 42.0 62.0 82.0
[4,] 14.5 34.5 54.5 74.5 94.5
[5,]  5.5 25.5 45.5 65.5 85.5
$`Clustering_Vevtor:`
 [1] 3 3 3 5 5 5 5 1 1 1 1 1 4 4 4 4 2 2 2 2
$`Within_cluster_sum_of_squares(withinSS)`
[1] 50 25 10 25 25
$`proportion of betweenSS with totalSS`
[1] 0.96
