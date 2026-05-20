library(terra)
library(dplyr)


imgDir = "K:/Environmental_Studies/hkropp/Private/aerial_40s"
imgs = list.files(imgDir, pattern=".tif")
imgs = imgs[-grep(".xml", imgs)]
imgs = imgs[-grep(".ovr", imgs)]

dimCrop <- 2200

img_org <- list()
img_crop <- list()
dims <- list()
for(i in 1:length(imgs)){
  img_org[[i]] = rast(paste0(imgDir,"/",imgs[i]))
  dims[[i]] <- dim(img_org[[i]])[1:2]
  img_crop[[i]] = img_org[[i]][dimCrop:(dims[[i]][1]-dimCrop),dimCrop:(dims[[i]][2]-dimCrop), drop=FALSE]
}

plot(img_org[[1]], col=gray(1:100/100))
plot(img_org[[2]], col=gray(1:100/100))
plot(img_org[[3]], col=gray(1:100/100))

plot(img_crop[[1]], col=gray(1:100/100))
plot(img_crop[[2]], col=gray(1:100/100))
plot(img_crop[[3]], col=gray(1:100/100))


dirSave = "K:/Environmental_Studies/hkropp/Private/aerial_40s_crop"
for(i in 1:length(imgs)){
  writeRaster(img_crop[[i]], paste0(dirSave,"/",imgs[i]))
              
}
  

