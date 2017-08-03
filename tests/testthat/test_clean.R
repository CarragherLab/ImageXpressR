context("clean functions")

example_paths <- readLines("images.txt")

test_that("clean" , {
    output <- clean(example_paths)
    expect_true(length(output) < length(example_paths))
    expect_false(output[1] == "Thumbs.db")
    # check none of the images in the output are thumbnails
    for (line in output) {
        expect_false(grepl(line, "thumb"))
    }
})