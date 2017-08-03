#' test if path contains file separators
#'
#' @param path string, ImageExpress file path
is_full_path <- function(path) {
    grepl("/|\\\\", path)
}


#' split path into components by file separator
#'
#' @inheritParams is_full_path
split_path <- function(path) {
    rev(setdiff(strsplit(path, "/|\\\\")[[1]], ""))
}


#' return the final image filename from the path
#'
#' @inheritParams is_full_path
#' @export
get_img_filename <- function(path) {
    if (length(path) > 1) return(unname(.vec_func(get_img_filename)(path)))
    basename(path)
}


#' split the image URL into components separated by `char`
#'
#' @param img_url string, final image URL in ImageXpress file path
#' @param char string, separating character in URL
split_url <- function(img_url, char = "_") {
    # check if it's actually a full path
    # if so, get only the final image url
    if (is_full_path(img_url)) {
        img_url <- get_img_filename(img_url)
    }
    components <- strsplit(img_url, char)[[1]]
    names(components) <- c("exp_name", "well", "site", "hash")
    components
}


#' return the path up until the image URL
#'
#' @inheritParams is_full_path
#' @export
get_path <- function(path) {
    if (length(path) > 1) return(unname(.vec_func(get_path)(path)))
    dirname(path)
}


#' return well from the final image URL
#'
#' @inheritParams split_url
#' @export
get_img_well <- function(img_url, char = "_") {
    if (length(img_url) > 1) return(unname(.vec_func(get_img_well)(img_url, char)))
    unname(split_url(img_url, char)["well"])
}


#' return site from the image URL
#'
#' @inheritParams split_url
#' @export
get_img_site <- function(img_url, char = "_") {
    if (length(img_url) > 1) return(unname(.vec_func(get_img_site)(img_url, char)))
    site_with_s <- unname(split_url(img_url, char)["site"])
    # remove the s from the beginning of the site string
    site <- substring(site_with_s, 2)
    as.integer(site)
}


#' return the image channel from the image URL
#'
#' @inheritParams split_url
#' @export
get_img_channel <- function(img_url, char = "_") {
    if (length(img_url) > 1) return(unname(.vec_func(get_img_channel)(img_url, char)))
    hash <- unname(split_url(img_url, char)["hash"])
    channel <- strsplit(hash, "")[[1]][2]
    as.integer(channel)
}


#' return the plate name from the image URL
#'
#' @inheritParams is_full_path
#' @export
get_plate_name <- function(path) {
    if (length(path) > 1) return(unname(.vec_func(get_plate_name)(path)))
    split_path(path)[4]
}


#' return the plate date from the image URL
#'
#' @inheritParams is_full_path
#' @param as_datetime Boolean, whether to convert to a Date object
#' @export
get_plate_date <- function(path, as_datetime = TRUE) {
    if (length(path) > 1) return(unname(.vec_func(get_plate_date)(path, as_datetime)))
    date <- split_path(path)[3]
    if (as_datetime) {
        date <- as.Date(date)
    }
    date
}


#' return the plate number from the image URL
#'
#' @inheritParams is_full_path
#' @export
get_plate_num <- function(path) {
    if (length(path) > 1) return(unname(.vec_func(get_plate_num)(path)))
    plate_num <- split_path(path)[2]
    as.integer(plate_num)
}


.vec_func <- function(func) {
    Vectorize(func)
}
