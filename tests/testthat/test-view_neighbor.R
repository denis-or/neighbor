test_that("analisando se abre outro tipo de arquivo", {
    no_spatial <- sf::read_sf(system.file("gpkg/nospatial.gpkg", package = "sf"))
    expect_error(view_neighbor(nbr = no_spatial))
})
