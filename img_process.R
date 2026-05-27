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

dirSave2 = "I:/aerial/crop_1"
#for(i in 1:length(imgs)){
  writeRaster(img_crop[[i]], paste0(dirSave,"/",imgs[i]))
} 
  
  
  
  
  dimCrop2 <- 2500
  img_org[[13]] <- img_org[[13]][dimCrop2:(dims[[13]][1]-dimCrop2),dimCrop2:(dims[[13]][2]-dimCrop2), drop=FALSE]
 plot(img_org[[13]], col=grey(1:100/100))
  
   dimCropR2 <- 2650
   dimCropC2 <- 3000
   
  img_crop2 = list()
  resL = list()
  dims = list()
 xminV = numeric()
 xmaxV = numeric()
 yminV = numeric()
 ymaxV = numeric()
  for(i in 1:length(imgs)){
    dims[[i]] = dim(img_org[[i]])[1:2]
    resL[[i]] = res(img_org[[i]])
    xminV[i] = ext(img_org[[i]])[1]
    xmaxV[i] = ext(img_org[[i]])[2]
    yminV[i] = ext(img_org[[i]])[3]
    ymaxV[i] = ext(img_org[[i]])[4]
    if(i != 13){
    img_crop2[[i]] = img_org[[i]][dimCropR2:(dims[[i]][1]-dimCropR2),dimCropC2:(dims[[i]][2]-dimCropC2), drop=FALSE]
    }else{
      img_crop2[[i]] = img_org[[i]][1400:(dims[[i]][1]-1400),1400:(dims[[i]][2]-1400), drop=FALSE]}
  }

 
 
 #create raster
 res_rast <- rast(xmin=min(xminV),xmax=max(xmaxV), ymin=min(yminV),ymax=max(ymaxV),
                  crs="epsg:32619",
                  res=c(0.5,0.5))
 
 plot(res_rast)
 for(i in 1:length(imgs)){
   plot(img_crop2[[i]],col=grey(1:100/100),add=TRUE,legend=FALSE)
 } 
  

  

  resamp_img <- list()
  for(i in 1:length(imgs)){
    resamp_img[[i]] <- resample(img_crop2[[i]], res_rast)
  }
  
  plot(resamp_img[[1]])
  

 #test merge 

img_resamp <- do.call(merge, resamp_img)


# mosaic

rsrc <- sprc(resamp_img)

img_mos <- mosaic(rsrc, fun="max")
plot(img_mos,col=grey(1:100/100))
         
plot(img_resamp,col=grey(1:100/100))
plot(img_mos,col=grey(1:100/100))
  
writeRaster(img_resamp,"K:/Environmental_Studies/hkropp/Private/aerial_40s_merge/merge_test.tif")
writeRaster(img_mos,"K:/Environmental_Studies/hkropp/Private/aerial_40s_merge/mos_test.tif")



# crop for test in agisoft



#resample to same resolution

dimCropRI <- 2300
dimCropCI <- 2500

res_rastc = list()
xminV = numeric()
xmaxV = numeric()
yminV = numeric()
ymaxV = numeric()
resamp_imgc = list()
imgCrop = list()
dimsR = list()
for(i in 1:length(imgs)){
  xminV[i] = ext(img_org[[i]])[1]
  xmaxV[i] = ext(img_org[[i]])[2]
  yminV[i] = ext(img_org[[i]])[3]
  ymaxV[i] = ext(img_org[[i]])[4]
  res_rastc[[i]] <- rast(xmin=min(xminV[i]),xmax=max(xmaxV[i]), ymin=min(yminV[i]),ymax=max(ymaxV[i]),
                 crs="epsg:32619",
                 res=c(0.5,0.5))
  resamp_imgc[[i]] = resample(img_org[[i]], res_rastc[[i]])
  dimsR[[i]] = dim(resamp_imgc[[i]])[1:2]
  imgCrop[[i]] =  resamp_imgc[[i]][dimCropRI:(dimsR[[i]][1]-dimCropRI),dimCropCI:(dimsR[[i]][2]-dimCropCI), drop=FALSE]
}

plot(res_rast)
for(i in 1:length(imgs)){
  plot(imgCrop[[i]],col=grey(1:100/100),add=TRUE,legend=FALSE)
} 

for(i in 1:length(imgs)){
  writeRaster(imgCrop[[i]],paste0("I:/aerial/crop_1/",imgs[i]))
  
}
imgCrop[[1]]

