options(stringsAsFactors = FALSE)
library(annotables)

### Create annotation dataframe
# First column - general category. Second - signature. Third - EntrezIDs
md.human.custom <- data.frame(collection = vector(mode = "character"), geneset = vector(mode = "character"), entrez = vector(mode = "character"))


### PAM50
mtx <- read.table("/Users/mdozmorov/Documents/Work/GenomeRunner/gwas2bed/tumorportal/data/pam50_centroids.txt")

genes.symbol <- unique(rownames(mtx))
genes.notmap <- setdiff(genes.symbol, grch38$symbol)
genes.symbol[ genes.symbol == "CDCA1" ] <- "NUF2"
genes.symbol[ genes.symbol == "KNTC2" ] <- "NDC80"
genes.symbol[ genes.symbol == "ORC6L" ] <- "ORC6"
genes.entrez <- unique(grch38$entrez[ grch38$symbol %in% genes.symbol ])

md.human.custom.pam50 <- data.frame(collection = "cancer", geneset = "PAM50", entrez = sort(genes.entrez))
md.human.custom.pam50 <- md.human.custom.pam50[ complete.cases(md.human.custom.pam50), ]

### ADME core. Source: [PharmaADME.org](http://pharmaadme.org/)
mtx <- read.table("/Users/mdozmorov/Documents/Work/GenomeRunner/gwas2bed/genes/data/ADME_core.txt")

genes.symbol <- unique(mtx$V1)
genes.notmap <- setdiff(genes.symbol, grch38$symbol)
genes.entrez <- unique(grch38$entrez[ grch38$symbol %in% genes.symbol ])

md.human.custom.ADMEcore <- data.frame(collection = "pharmacology", geneset = "ADMEcore", entrez = sort(genes.entrez))
md.human.custom.ADMEcore <- md.human.custom.ADMEcore[ complete.cases(md.human.custom.ADMEcore), ]

### ADME extended. Source: [PharmaADME.org](http://pharmaadme.org/)
mtx <- read.table("/Users/mdozmorov/Documents/Work/GenomeRunner/gwas2bed/genes/data/ADME_extended.txt")

genes.symbol <- unique(mtx$V1)
genes.notmap <- setdiff(genes.symbol, grch38$symbol)
genes.symbol[ genes.symbol == "SULT1C1" ] <- "SULT1C2"
genes.symbol[ genes.symbol == "NOS2A" ] <- "NOS2"
genes.symbol[ genes.symbol == "CYP2D7P1" ] <- "CYP2D7"
genes.entrez <- unique(grch38$entrez[ grch38$symbol %in% genes.symbol ])

md.human.custom.ADMEextended <- data.frame(collection = "pharmacology", geneset = "ADMEextended", entrez = sort(genes.entrez))
md.human.custom.ADMEextended <- md.human.custom.ADMEextended[ complete.cases(md.human.custom.ADMEextended), ]

### ADME related. Source: [PharmaADME.org](http://pharmaadme.org/)
mtx <- read.table("/Users/mdozmorov/Documents/Work/GenomeRunner/gwas2bed/genes/data/ADME_related.txt")

genes.symbol <- unique(mtx$V1)
genes.notmap <- setdiff(genes.symbol, grch38$symbol)
genes.symbol[ genes.symbol == "ABP1" ] <- "AOC1"
genes.symbol[ genes.symbol == "ARS2" ] <- "SRRT"
genes.symbol[ genes.symbol == "BHLHB5" ] <- "BHLHE22"
genes.symbol[ genes.symbol == "C3orf15" ] <- "MAATS1"
genes.symbol[ genes.symbol == "CCBP2" ] <- "ACKR2"
genes.symbol[ genes.symbol == "CREBL1" ] <- "ATF6B"
genes.symbol[ genes.symbol == "FAM82A" ] <- "RMDN2"
genes.symbol[ genes.symbol == "HNRPA3" ] <- "HNRNPA3"
genes.entrez <- unique(grch38$entrez[ grch38$symbol %in% genes.symbol ])

md.human.custom.ADMErelated <- data.frame(collection = "pharmacology", geneset = "ADMErelated", entrez = sort(genes.entrez))
md.human.custom.ADMErelated <- md.human.custom.ADMErelated[ complete.cases(md.human.custom.ADMErelated), ]

### Age-associated genes, Enrichr
# mtx <- read.table("http://amp.pharm.mssm.edu/Enrichr/geneSetLibrary?mode=text&libraryName=Aging_Perturbations_from_GEO_up")

### Append data
md.human.custom <- rbind(md.human.custom.pam50,
                         md.human.custom.ADMEcore,
                         md.human.custom.ADMEextended,
                         md.human.custom.ADMEextended)
save(md.human.custom, file = "data/md.human.custom.rda")
