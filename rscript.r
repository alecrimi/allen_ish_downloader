library(dplyr)
library(allenBrain)

# get a list of structure names and ids
#IDs = getStructureIDs()
#IDs %>% head

#df <- read.table("DEG_Downregulated_term_Pval_ForA.csv",      header = TRUE,  sep = ",", stringsAsFactors = FALSE)
df <- read.table("mouse_screen_dr.csv",      header = FALSE,  sep = ",", stringsAsFactors = FALSE)


for (i in seq_len(nrow(df))) {
  stringa = df[i,1]
  
  # get the dataset for the desired gene (the first saggital experiment that did not fail)
  datasetID = getGeneDatasets(gene = stringa,
                              planeOfSection = 'sagittal',
                              probeOrientation = 'antisense')[1]
  #Download the data
  url_annotation = paste("http://api.brain-map.org/grid_data/download/",datasetID)
  browseURL(url_annotation, browser = getOption("browser"),encodeIfNeeded = FALSE)
  
}



















if(FALSE) {
  # get the id of the desired region
  rootID = IDs['Cerebrum' == IDs$name,]$id
  
  # get the slide that has the desired brain region and coordinates of the center of the region
  imageID = structureToImage(datasetID = datasetID,regionID = rootID)
  
  # decide how much to you wish to downsample
  downsample = 2
  listImages(imageID)
  # download the slide
  downloadImage(imageID = imageID$section.image.id, 
                view = 'expression',
                outputFile = 'image.jpg',
                downsample = downsample)
  
  
  # gel all images for Prox1 experiment
  allImages = listImages(datasetID)  %>% arrange(as.numeric(`section.number`))
  
  
  data = head(getStructureExpressions(datasetID))
}