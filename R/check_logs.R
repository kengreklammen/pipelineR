check_logs <- function(){
	schema <- Sys.getenv("PG_SCHEMA")
	con <- pipelineR::connect_db()
	last24hours <- Sys.Date() - 86400
	sql <- glue::glue_sql("select * from pipeline_logs where timestamp BETWEEN NOW() - INTERVAL '24 HOURS' AND NOW();", .con = con)
	DBI::dbExecute(con, glue::glue("SET search_path TO {schema}"))
	log <- DBI::dbGetQuery(con, sql)
	DBI::dbDisconnect(con)
	#return(log)
	#View(log)
	total_number_of_executions <- nrow(log)
	print(total_number_of_executions)
	failed_executions <- log %>% dplyr::filter(grepl('Error', message))
	number_of_failed <- nrow(failed_executions)
	print(number_of_failed)
	number_of_successful <- total_number_of_executions - number_of_failed
	print(number_of_successful)

	# Rendering an RMarkdown document
	rmarkdown::render(input = "log_report.Rmd",
										output_file = paste0("jenkins_home/my_logs/output", format(Sys.time(), "%Y%m%d%H%M%S"),".html"),
										params = list(te = total_number_of_executions, tf = number_of_failed, ts = number_of_successful))


}
