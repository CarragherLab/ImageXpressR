# ImageXpressR

**Parse metadata from ImageXpress file paths**

Two groups of functions, `get_img_...` and `get_plate_...`, as well as `clean()`.

## Examples

If we have a list of file paths like so:

```R
library(ImageXpressR)

head(image_paths)
    [1] "Thumbs.db"
    [2] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w1A52B1177-9DC7-4534-9623-9DCA396EFA00.tif"
    [3] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w1_thumb62D4A363-7C7E-40D0-8A9E-55EC6681574D.tif"
    [4] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w2D1E11FCC-8DCD-42F5-B2BD-B270F2E9223D.tif"
    [5] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w2_thumb16F0EB1B-44C9-4313-9E6A-A7A1F5236885.tif"
    [6] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w3E75611A2-A874-4065-BDAC-EE2467105EEB.tif"

# remove thumbnails and other rubbish with `clean()`
image_paths <- clean(image_paths)[1:6]

print(image_paths)
    [1] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w1A52B1177-9DC7-4534-9623-9DCA396EFA00.tif"
    [2] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w2D1E11FCC-8DCD-42F5-B2BD-B270F2E9223D.tif"
    [3] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w3E75611A2-A874-4065-BDAC-EE2467105EEB.tif"
    [4] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w4D2D992BF-2A9D-499D-B5B0-42B7F5F6A4E6.tif"
    [5] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s1_w5ECBDD964-9803-43FF-8E75-CDB518095935.tif"
    [6] "/mnt/ImageXpress/2015-07-31 val screen/val screen/HCC15691/2015-07-31/4014/val screen_B02_s2_w1AD037353-1651-4E2B-8453-083CC79C43AE.tif"
```

Extract metadata from file paths
```R
get_img_wells(image_paths)
    [1] "B02" "B02" "B02" "B02" "B02" "B02"

get_img_site(image_paths)
    [1] 1 1 1 1 1 2


get_img_channel(image_paths)
    [1] 1 2 3 4 5 1


get_plate_name(image_paths)
    [1] "HCC15691" "HCC15691" "HCC15691" "HCC15691" "HCC15691" "HCC15691"


get_plate_date(image_paths)
    [1] "2015-07-31" "2015-07-31" "2015-07-31" "2015-07-31" "2015-07-31"
    [6] "2015-07-31"

```

```R
metadata_df <- data.frame(
    well = get_img_well(image_paths),
    site = get_img_site(image_paths),
    channel = get_img_channel(image_paths),
    plate_name = get_plate_name(image_paths)
)

head(metadata_df)
      well  site  channel plate_name
    1  B02    1       1   HCC15691
    2  B02    1       2   HCC15691
    3  B02    1       3   HCC15691
    4  B02    1       4   HCC15691
    5  B02    1       5   HCC15691
    6  B02    2       1   HCC15691

```


## Functions:
`clean()`  
`get_img_channel()`  
`get_img_filename()`  
`get_img_site()`  
`get_plate_date()`  
`get_plate_name()`  
`get_plate_num()`  

