test_that("formato diferente de sfc", {
  no_spatial <- sf::read_sf(system.file("gpkg/nospatial.gpkg", package = "sf"))
  expect_error(get_neighbor(shapefile = no_spatial, "Queen"))
})
test_that("somente um poligono",{
  one_polygon <- sf::read_sf(system.file("gpkg/tl.gpkg", package = "sf"))
  expect_error(get_neighbor(shapefile = one_polygon, "Queen"))
})
test_that("vizinhanca errada",{
  polygon_ok <- sf::read_sf(system.file("gpkg/nc.gpkg", package = "sf"))
  expect_error(get_neighbor(shapefile = polygon_ok, "1"))
})
