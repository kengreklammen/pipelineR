library(glue)
library(DBI)
library(RPostgres)

#' Returns all sp500 symbols and their related data from the database.
#' The parameter is a PqConnection object that represents an active PostgreSQL database connection.
#'
#' @param con A PqConnection object that represents an active PostgreSQL connection.
#'
#' @returns A data frame with the sp500 symbols and their related data.
#' @export
#'
#' @examples
#' \dontrun{
#' fetch_symbols(con)
#' }
fetch_symbols <- function(con){
	sql <- glue::glue_sql("select * from info;", .con = con)
	DBI::dbExecute(con, "SET search_path TO sp500")
	df <- DBI::dbGetQuery(con, sql)
	return(df)
}
