library(terra)
library(dplyr)

imgDir = "K:/Environmental_Studies/hkropp/Private/aerial_40s"
imgs = list.files(imgDir, pattern=".tif")
imgs = imgs[-grep(".xml", imgs)]
imgs = imgs[-grep(".ovr", imgs)]

img_org = rast(paste0(imgDir,"/",imgs[1]))

plot(img_org, col=gray(1:100/100))
img_org
img_crop=img_org[-c((1:1000),(8872:9872)),-c((1:1000),(9131:10131))]
plot(img_crop, col=gray(1:100/100))
