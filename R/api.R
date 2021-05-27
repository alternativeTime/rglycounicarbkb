library(tidyverse) ; library(httr) ; library(jsonlite) ; library(httr)


#' Get entries matching composition
#' @param composition
#' @return all composition matches
#' @export
#' @examples
#' getComposition(hex=3&hexnac=5)

getComposition <- function(composition){
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/search-composition?", composition, sep='')
  data <- getJSON(path)
  data
}

#' Get glycoproteins
#' @return all glycoproteins
#' @export
#' @examples
#' getAllGlycoproteins()

getAllGlycoproteins <- function(){
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/glycoproteins")
  data <- getJSON(path)
  data
}

#' Get Proteoglycoforms
#' @parm uniprot
#' @return all glycoforms for uniprot
#' @export
#' @examples
#' getProteoglycoforms('P14210-1')

getProteoglycoforms <- function(uniprot){
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/get-proteoglycoforms/",uniprot, sep='')
  data <- getJSON(path)
  data
}

getGlytoucanUniprotAnnotations <- function(glytoucan_id){
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/get-glytoucan-published-uniprot-glycoforms/",glytoucan_id, sep='')
  data <- getJSON(path)
  data
}

#' Get glycan structure details
#' @param glytoucan_id
#' @return structure metadata
#' @export
#' @examples
#' getGlytoucanStructureDetails('G17689DH')
#'

getGlytoucanStructureDetails <- function(glytoucan_id){
  #glytoucan_id
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/get-glytoucan-structure-details/",glytoucan_id, sep='')
  data <- getJSON(path)
  data
}

#' Get GTs involved in synthesis of structure
#'
#' @param  glytoucan_id
#' @return lists of GTs
#' @export
#' @examples
#' getGlycanStructureGTs('G17689DH')
#'

getGlycanStructureGTs <- function(glytoucan_id){
  #glytoucan_id
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/get-glycan-structure-gts/",glytoucan_id, sep='')
  data <- getJSON(path)
  data

}

#' Gets structures with a mass
#'
#' @param mass Native mass
#' @return glycan structure sequence details and mass
#' @export
#' @examples
#' searchMass(180)
#'

searchMass <- function(mass){
  mass
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/search-mass/",mass, sep='')
  path

  r <- GET(url = path)
  x <- content(r, as = "text", encoding = "UTF-8")

  x <- cleanJSON(x)
  data <- getJSON(path)
  data
}

#' Gets structures and glycoproteins with a mass
#'
#' @param mass Native mass
#' @return glycan structure sequences, mass and associated glycoproteins
#' @export
#' @examples
#' searchMass(180)
#'

searchMassGlycoprotein <- function(mass){
  mass
  path <- paste("https://flaskapp-cr-v1-gateway-v3vtg36c3q-ue.a.run.app/search-mass-glycoprotein/",mass, sep='')
  path

  r <- GET(url = path)
  x <- content(r, as = "text", encoding = "UTF-8")

  x <- cleanJSON(x)
  data <- getJSON(path)
  data
}



cleanJSON <- function(json){
  json <- gsub("f0_", "", json)
  json <- gsub ("\\{\"\":", "", json)
  json <- gsub ("\\}\\}\\]", "}]", json)
  json <- gsub ("\\}\"\\}", "}", json)
  json <- gsub ("\\,\"\\{", ",{", json )
  json <- gsub("\\[\"\\{", "[{", json)
  json <- gsub("\\\\", "", json)
}

getJSON <- function(path){
  path
  r <- GET(url = path)
  result <- content(r, as = "text", encoding = "UTF-8")
  result <- cleanJSON(result)
  data <- fromJSON(result, flatten = TRUE)
  data
}





