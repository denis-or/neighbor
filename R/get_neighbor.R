#' Get neighbor in the geometry
#'
#' `get_neighbor()` get neighbors from an spatial object with class `sfc_MULTIPOLYGON` and returns a list object with class equal to "vizi".
#'
#'
#'
#' @param shapefile A spatial object of class `sfc_MULTIPOLYGON`
#' @param tipo type of neighbor.
#'
#' @return An object `vizi`
#'
#' @examples \dontrun{
#' # Import
#' nc <- sf::read_sf(system.file("gpkg/nc.gpkg", package = "sf"))
#'
#' # Get the neighbor
#' l_nb <- get_neighbor(nc, "Queen")
#'
#' # Visualize
#' view_connections(l_nb)
#'
#' view_neighbor(l_nb)
#'
#' }
#' @importFrom rlang .data
#' @export


get_neighbor <- function(shapefile, tipo = "Queen") {

  if (missing(shapefile) || !exists(deparse(substitute(shapefile)))) {
    stop("Geometria n\u00e3o existe", call. = F)
  }

  if (class(sf::st_geometry(shapefile))[1] != "sfc_MULTIPOLYGON") {

    shapefile <- try(sf::st_cast(shapefile, "MULTIPOLYGON"), silent = TRUE)

    if (inherits(shapefile, "try-error")) {
      stop("Uma geometria de pol\u00edgonos \u00e9 requerida", call. = F)
    }
  }

  if (length(shapefile$geom) <= 1) {
    stop("A geometria n\u00e3o pode ser usada para vizinhan\u00e7a", call. = F)
  }

  if (tipo != "Queen" & tipo != "Rook" ) {
    stop("Tipo de vizinhan\u00e7a desconhecido. Tente `Queen` ou `Rook`.", call. = F)
  }

  .crs <- sf::st_crs(shapefile)
  .shape_sp <- sf::as_Spatial(shapefile)
  .centroide <- sf::st_centroid(shapefile)
  .centroide <- .centroide %>%
    dplyr::mutate(id_vizi = rownames(.centroide)) %>%
    dplyr::select(.data$id_vizi, .data$geom)


  .coordenadas <- sf::st_coordinates(.centroide)


  if (tipo == "Queen") {
    .viz <- spdep::poly2nb(.shape_sp, queen = TRUE)
    tipo_rec <- tipo

  }
  else if (tipo == "Rook") {
    .viz <- spdep::poly2nb(.shape_sp, queen = FALSE)
    tipo_rec <- tipo
  }
  else if (missing(tipo)) {
    .viz <- spdep::poly2nb(.shape_sp, queen = TRUE)
    tipo <- tipo_rec <- "Queen"

  }

  .viz_sf <- spdep::nb2lines(.viz, coords = .coordenadas, as_sf = TRUE)
  .viz_sf <- sf::st_set_crs(.viz_sf, .crs)

  .list <- list(feicao = shapefile,
                vizinho = .viz_sf,
                tipo = tipo_rec,
                ref = .crs,
                centroide = .centroide,
                coordenadas = .coordenadas,
                classe = "vizi")

  class(.list) <- c("vizi", "list")

  return(.list)

}
