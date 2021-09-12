#' View the neighborhood
#'
#' `{view_neighbor()}` get neighbors from an neighbor object and returns a ggplot object.
#'
#'
#'
#' @param nbr A neighbor object create by `get_neighbor()` function.
#'
#' @return An object `ggplot`
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
#' @export


view_neighbor <- function(nbr) {

  if (class(nbr)[1] != "vizi") {
    stop('Erro: Objeto n\u00e3o foi criado anteriormente.
         Use a fun\u00e7\u00e3o `get_neighbor`.', call. = F)
  }

  .gg1 <- ggplot2::ggplot() +
    ggplot2::geom_sf(
      data = nbr$feicao,
      fill = "#f7f7f7",
      size = 0.2,
      color = "#bababa"
    ) +
    ggplot2::geom_sf(data = nbr$vizinho, size = 0.2) +
    ggplot2::geom_sf_label(data = nbr$centroide, ggplot2::aes(label = .data$id_vizi)) +
    ggplot2::theme_bw() +
    ggplot2::theme(axis.text.y = ggplot2::element_text(angle = 90)) +
    ggplot2::labs(x = "Lat", y = "Lon")

  return(.gg1)

}
