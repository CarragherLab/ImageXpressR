#' clean file list
#'
#' Remove thumbnails and other rubbish from filename lists.
#'
#' @param file_list Vector of file paths.
#' @param ext File extension to keep.
#'
#' @export

clean <- function(file_list, ext = ".tif") {
    stopifnot(length(file_list) > 0)
    # create vector of all NA's the same length as the original file list
    wanted_files <- rep(NA, length = length(file_list))
    # iterate through files, if file ends with extension and
    # doesn't contain "thumb" (thumbnail image)
    # then substitute in the filename to the NA vector
    for (i in seq_along(file_list)) {
        current_string <- file_list[i]
        if (endsWith(current_string, ext) && !grepl("thumb", current_string)) {
            wanted_files[i] = current_string
        }
    }
    # remove any NA values
    wanted_files[!is.na(wanted_files)]
}
