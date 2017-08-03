context("parse functions")

example_paths <- readLines("images.txt")

test_that("is_full_path", {
    full_path <- "/path/with/file_separators.txt"
    full_path2 <- "\\weird\\windows\\path\\is\\stupid.txt"
    not_full_path <- "just_a_file.txt"
    expect_true(is_full_path(full_path))
    expect_true(is_full_path(full_path2))
    expect_false(is_full_path(not_full_path))
})


test_that("split_path", {
    test_path <- example_paths[2]
    output <- split_path(test_path)
    expect_equal(length(output), 8)
    expect_equal(output[length(output)], "mnt")
    expect_equal(output[length(output)-1], "ImageXpress")
})


test_that("get_img_filename", {
    test_path <- example_paths[2]
    output <- get_img_filename(test_path)
    expected_answer <- "val screen_B02_s1_w1A52B1177-9DC7-4534-9623-9DCA396EFA00.tif"
    expect_equal(output, expected_answer)
})


test_that("split_url", {
    # should work for both full length paths and just the image URL
    # so test on both and make sure the outputs are the same
    # split full path
    test_full_path <- example_paths[2]
    output_full <- split_url(test_full_path)
    expected_answer <- c("val screen", "B02", "s1",
                         "w1A52B1177-9DC7-4534-9623-9DCA396EFA00.tif")
    names(expected_answer) <- c("exp_name", "well", "site", "hash")
    expect_equal(output_full, expected_answer)
    # split only URL
    test_url <- "val screen_B02_s1_w1A52B1177-9DC7-4534-9623-9DCA396EFA00.tif"
    output_url <- split_url(test_url)
    expect_equal(output_url, expected_answer)
    expect_equal(output_url, output_full)
})


test_that("get_path", {
    test_path <- example_paths[2]
    output <- get_path(test_path)
    # NOTE, no trailing file separator
    expected_answer <- "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014"
    expect_equal(output, expected_answer)
})


test_that("get_img_well", {
    full_path <- example_paths[2]
    just_url <- get_img_filename(full_path)
    expected_answer <- "B02"
    expect_equal(get_img_well(full_path), expected_answer)
    expect_equal(get_img_well(just_url), expected_answer)
    expect_equal(get_img_well(full_path), get_img_well(just_url))
})


test_that("get_img_site", {
    full_path <- example_paths[2]
    just_url <- get_img_filename(full_path)
    expected_answer <- 1L
    expect_equal(get_img_site(full_path), expected_answer)
    expect_equal(get_img_site(just_url), expected_answer)
    expect_equal(get_img_site(full_path), get_img_site(just_url))
})


test_that("get_img_channel", {
    full_path <- example_paths[2]
    just_url <- get_img_filename(full_path)
    expected_answer <- 1L
    expect_equal(get_img_channel(full_path), expected_answer)
    expect_equal(get_img_channel(just_url), expected_answer)
    expect_equal(get_img_channel(full_path), get_img_channel(just_url))
    # try on another example
    full_path_2 <- example_paths[4]
    just_url_2 <- get_img_filename(full_path_2)
    expected_answer_2 <- 2L
    expect_equal(get_img_channel(full_path_2), expected_answer_2)
    expect_equal(get_img_channel(just_url_2), expected_answer_2)
    expect_equal(get_img_channel(full_path_2), get_img_channel(just_url_2))
})


test_that("get_plate_date", {
    full_path <- example_paths[2]
    expected_answer <- "2015-07-31"
    expect_equal(get_plate_date(full_path, as_datetime = TRUE), as.Date(expected_answer))
    expect_equal(get_plate_date(full_path, as_datetime = FALSE), expected_answer)
})


test_that("get_plate_num", {
    full_path <- example_paths[2]
    expected_answer <- 4014L
    expect_equal(get_plate_num(full_path), expected_answer)
})
