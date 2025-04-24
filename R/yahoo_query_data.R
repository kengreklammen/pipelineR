library(tidyquant)

#' Returns a data frame that contains stock data for the requested tickers in the given date window.
#'
#' @param symbols A list of stock symbols.
#' @param from A date value as a start date of the requested period.
#' @param to A date value as an end date of the requested period.
#'
#' @returns A data frame with the stock data for the requested tickers in the given date window.
#' @export
#'
#' @examples
#' \dontrun{
#' yahoo_query_data(c("AAPL", "A", "CNP", "CRL"), "2015-01-02", "2015-01-04")
#' }
yahoo_query_data <- function(symbols, from, to){
	data <- tq_get(symbols) %>% subset(date >= from & date <= to)
	return(data)
	}
