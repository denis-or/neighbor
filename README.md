
# neighbor <a href='https://www.denis-or.com.br'><img src='man/figures/logo.png' align="right" height="139" /></a>
<!-- badges: start -->
<!-- badges: end -->

## Overview

`{neighbor}` gets and visualizes the neighbors of a spatial object (area objects) 
that has at least one point (or vertex) in common, but no intersection. 
This package uses the `poly2nb` function from the `spdep` package with the
contiguity neighborhood type: queen and rook.

## Installation

You can install the development version from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("denis-or/neighbor")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(neighbor)
## basic example code
```

## License

`{neighbor}` is licensed under the MIT license. Check out
[LICENSE.md](https://github.com/denis-or/neighbor/blob/master/LICENSE.md)
for the full text.
