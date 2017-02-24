#' @title d3tree
#'
#' @description Htmlwidget that binds to d3js trees. When used in Shiny environment the widget returns
#' a data.frame of logical expressions that represent the current state of the tree. 
#'
#' @param data data.frame containing the structure the tree will represent
#' @param name character containing the name of the tree
#' @param value charater containing the name of the column in data that has the values
#' that are used in the leafs
#' 
#' @examples  
#' 
#' \donttest{
#' if(interactive()){
#' d3tree(
#' list(
#' root = df2tree(rootname='Titanic',as.data.frame(Titanic)),
#' layout = 'collapse'
#' )
#' )
#' }
#' }
#' 
#' @import htmlwidgets
#'
#' @export
d3tree <- function(
  data,
  name = "name", value = "value",
  width = NULL, height = NULL, elementId = NULL
) {
  
  # forward options using x
  x = list(
    data = data,
    options = list(name = name, value = value)
  )
  
  # create widget
  hw <- htmlwidgets::createWidget(
    name = 'd3tree',
    x,
    width = width,
    height = height,
    package = 'd3Tree',
    elementId = elementId
  )
  
  hw
}

#' Shiny bindings for d3tree
#'
#' Output and render functions for using d3tree within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a d3tree
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name d3tree-shiny
#'
#' @export
d3treeOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'd3tree', width, height, package = 'd3Tree')
}

#' @rdname d3tree-shiny
#' @export
renderD3tree <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, d3treeOutput, env, quoted = TRUE)
}