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

# split_batch <- function(tbl, batch_size = 25){
# 	batches <- split(tbl, gl(ceiling(nrow(tbl) / batch_size), batch_size, nrow(tbl)))
# 	# batches <- split(tbl, ceiling(seq_len(nrow(tbl)) / batch_size))
# 	# batches <- lapply(batch_indices, function(idx) symbol_list[idx, , drop = FALSE])
# 	return(batches)
# 	}

split_batch <- function(tbl, batch_size = 25) {

	if (!tibble::is_tibble(tbl)) {
		stop("'symbol_list' must be a tibble.")
	}

	n <- nrow(tbl)

	if (n == 0) {
		warning("Input 'symbol_list' is empty.")
		return(list())
	}

	# Create sequence of indices for batching
	batch_indices <- split(seq_len(n), ceiling(seq_len(n) / batch_size))

	# Split the tibble into batches
	batches <- lapply(batch_indices, function(idx) tbl[idx, , drop = FALSE])

	return(batches)
}
