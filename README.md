# MODISTools <a href='https://github.com/bluegreen-labs/MODISTools'><img src='https://raw.githubusercontent.com/bluegreen-labs/MODISTools/master/MODISTools-logo.png' align="right" height="139" /></a>

[![R build
status](https://github.com/bluegreen-labs/MODISTools/workflows/R-CMD-check/badge.svg)](https://github.com/bluegreen-labs/MODISTools/actions)
[![codecov](https://codecov.io/gh/bluegreen-labs/MODISTools/branch/main/graph/badge.svg)](https://app.codecov.io/gh/bluegreen-labs/MODISTools/tree/main/R)
![Status](https://www.r-pkg.org/badges/version/MODISTools)
![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/MODISTools)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7551165.svg)](https://doi.org/10.5281/zenodo.7551165)

Programmatic interface to the [‘MODIS Land Products Subsets’ web
services](https://modis.ornl.gov/data/modis_webservice.html). Allows for
easy downloads of [‘MODIS’](https://modis.gsfc.nasa.gov/) time series
directly to your R workspace or your computer. When using the package
please cite the manuscript as referenced below. Keep in mind that the
original manuscript describes versions prior to release 1.0 of the
package. Functions described in this manuscript do not exist in the
current package, please consult [the
documentation](https://bluegreen-labs.github.io/MODISTools/) to find
matching functionality.

Please cite the package in your work as: 

> Koen Hufkens. (2023). bluegreen-labs/MODISTools: MODISTools v1.1.5. Zenodo. https://doi.org/10.5281/zenodo.7551164

## Installation

### stable release

To install the current stable release use a CRAN repository:

``` r
install.packages("MODISTools")
library("MODISTools")
```

### development release

To install the development releases of the package run the following
commands:

``` r
if(!require(remotes)){install.package("remotes")}
remotes::install_github("bluegreen-labs/MODISTools")
library("MODISTools")
```

Vignettes are not rendered by default, if you want to include additional
documentation please use:

``` r
if(!require(remotes)){install.package("remotes")}
remotes::install_github("bluegreen-labs/MODISTools", build_vignettes = TRUE)
library("MODISTools")
```

## Use

### Downloading MODIS time series

To extract a time series of modis data for a given location and its
direct environment use the mt_subset() function.

<details>
<summary>
detailed parameter description (click to expand)
</summary>
<p>

| Parameter | Description                                                                                                                     |
|-----------|---------------------------------------------------------------------------------------------------------------------------------|
| product   | a MODIS product                                                                                                                 |
| band      | a MODIS product band (if NULL all bands are downloaded)                                                                         |
| lat       | latitude of the site                                                                                                            |
| lon       | longitude of the site                                                                                                           |
| start     | start year of the time series (data start in 1980)                                                                              |
| end       | end year of the time series (current year - 2 years, use force = TRUE to override)                                              |
| internal  | logical, TRUE or FALSE, if true data is imported into R workspace otherwise it is downloaded into the current working directory |
| out_dir   | path where to store the data when not used internally, defaults to tempdir()                                                    |
| km_lr     | force “out of temporal range” downloads (integer)                                                                               |
| km_ab     | suppress the verbose output (integer)                                                                                           |
| site_name | a site identifier                                                                                                               |
| site_id   | a site_id for predefined locations (not required)                                                                               |
| progress  | logical, TRUE or FALSE (show download progress)                                                                                 |

</p>
</details>

``` r
# load the library
library(MODISTools)

# download data
subset <- mt_subset(product = "MOD11A2",
                    lat = 40,
                    lon = -110,
                    band = "LST_Day_1km",
                    start = "2004-01-01",
                    end = "2004-02-01",
                    km_lr = 1,
                    km_ab = 1,
                    site_name = "testsite",
                    internal = TRUE,
                    progress = FALSE)
print(str(subset))
```

The output format is a *tidy* data frame, as shown above. When witten to
a csv with the parameter `internal = FALSE` this will result in a flat
file on disk.

Note that when a a region is defined using km_lr and km_ab multiple
pixels might be returned. These are indexed using the `pixel` column in
the data frame containing the time series data. The remote sensing
values are listed in the `value` column. When no band is specified all
bands of a given product are returned, be mindful of the fact that
different bands might require different multipliers to represent their
true values. To list all available products, bands for particular
products and temporal coverage see function descriptions below.

### Batch downloading MODIS time series

When a large selection of locations is needed you might benefit from
using the batch download function `mt_batch_subset()`, which provides a
wrapper around the `mt_subset()` function in order to speed up large
download batches. This function has a similar syntax to `mt_subset()`
but requires a data frame defining site names (site_name) and locations
(lat / lon) (or a comma delimited file with the same structure) to
specify a list of download locations.

Below an example is provided on how to batch download data for a data
frame of given site names and locations (lat / lon).

``` r
# create data frame with a site_name, lat and lon column
# holding the respective names of sites and their location
df <- data.frame("site_name" = paste("test",1:2))
df$lat <- 40
df$lon <- -110
  
# test batch download
subsets <- mt_batch_subset(df = df,
                     product = "MOD11A2",
                     band = "LST_Day_1km",
                     internal = TRUE,
                     start = "2004-01-01",
                     end = "2004-02-01")

print(str(subsets))
```

### Listing products

To list all available products use the mt_products() function.

``` r
products <- mt_products()
head(products)
```

### Listing bands

To list all available bands for a given product use the mt_bands()
function.

``` r
bands <- mt_bands(product = "MOD11A2")
head(bands)
```

### listing dates

To list all available dates (temporal coverage) for a given product and
location use the mt_dates() function.

``` r
dates <- mt_dates(product = "MOD11A2", lat = 42, lon = -110)
head(dates)
```

## References

Koen Hufkens. (2023). bluegreen-labs/MODISTools: MODISTools v1.1.5. Zenodo. https://doi.org/10.5281/zenodo.7551164

## Acknowledgements

Original development was supported by the UK Natural Environment
Research Council (NERC; grants NE/K500811/1 and NE/J011193/1), and the
Hans Rausing Scholarship. Refactoring was supported through the Belgian
Science Policy office COBECORE project (BELSPO; grant
BR/175/A3/COBECORE). Logo design elements are taken from the FontAwesome
library according to [these terms](https://fontawesome.com/license),
where the globe element was inverted and intersected.
