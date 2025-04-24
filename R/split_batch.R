#' Returns the complete stock symbol table horizontally split up into
#'
#' @param tbl A data frame that represents the complete data table of the stock symbols.
#' @param batch_size A numeric parameter that represents the batch size.
#'
#' @returns A list of data frames of the split-up symbol table.
#' @export
#'
#' @examples
#' \dontrun{
#' split_batch(df, 50)
#' split_batch(df)
#' }
split_batch <- function(tbl, batch_size = 25){
	batches <- split(tbl, gl(ceiling(nrow(tbl) / batch_size), batch_size, nrow(tbl)))
	# batches <- split(tbl, ceiling(seq_len(nrow(tbl)) / batch_size))
	# batches <- lapply(batch_indices, function(idx) symbol_list[idx, , drop = FALSE])
	return(batches)
	}
