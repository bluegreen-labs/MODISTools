% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mt_to_terra.R
\name{mt_to_terra}
\alias{mt_to_terra}
\title{Convert tidy MODISTools data to terra SpatRaster}
\usage{
mt_to_terra(df, reproject = FALSE, method = "bilinear")
}
\arguments{
\item{df}{a valid MODISTools data frame with a single band (filter for a
particular band using the dplyr \code{filter()} function or base \code{subset()}}

\item{reproject}{reproject output to lat / long (default = \code{FALSE})}

\item{method}{character. Method used for estimating the new cell values of
a SpatRaster. One of: near: nearest neighbor. This method is fast, and it
can be the preferred method if the cell values represent classes. It is not
a good choice for continuous values. This is used by default if the first
layer of x is categorical. bilinear: bilinear interpolation. This is the
default if the first layer of x is numeric (not categorical). cubic: cubic
interpolation. cubicspline: cubic spline interpolation.}
}
\value{
A terra SpatRaster populated with the tidy dataframe values
}
\description{
Convert tidy MODISTools data to a terra SpatRaster for easy
spatial processing and plotting.
}
\examples{

\donttest{
# list all available MODIS Land Products Subsets products
# download data
LC <- mt_subset(product = "MCD12Q1",
 lat = 48.383662,
 lon = 2.610250,
 band = "LC_Type1",
 start = "2005-01-01",
 end = "2005-12-30",
 km_lr = 2,
 km_ab = 2,
 site_name = "testsite",
 internal = TRUE,
 progress = FALSE)

head(LC)

# convert to raster
LC_r <- mt_to_terra(df = LC)
}
}
\seealso{
\code{\link[MODISTools]{mt_subset}}
\code{\link[MODISTools]{mt_batch_subset}}
}
