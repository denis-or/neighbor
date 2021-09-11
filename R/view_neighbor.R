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
#' l_nb <- get_neighbor(sf::read_sf(system.file("gpkg/nc.gpkg", package = "sf")), "Queen")
#'
#' view_neighbor(l_nb)
#' }
#' @export


view_neighbor <- function(nbr) {

  if (class(nbr) != "vizi") {
    stop('Erro: Objeto não foi criado anteriormente.
         Use a função `get_neighbor`.', call. = F)
  }

  .gg1 <- ggplot2::ggplot() +
    ggplot2::geom_sf(
      data = nbr$feicao,
      fill = "#f7f7f7",
      size = 0.2,
      color = "#bababa"
    ) +
    ggplot2::geom_sf(data = nbr$vizinho, size = 0.2) +
    ggplot2::geom_sf_label(data = nbr$centroide, ggplot2::aes(label = id_vizi)) +
    ggplot2::theme_bw() +
    ggplot2::theme(axis.text.y = ggplot2::element_text(angle = 90)) +
    ggplot2::labs(x = "Lat", y = "Lon")

  return(.gg1)

}
