options(stringsAsFactors = FALSE)
library(annotables)
# PAM50
mtx <- read.table("/Users/mdozmorov/Documents/Work/GenomeRunner/gwas2bed/tumorportal/data/pam50_centroids.txt")

genes.symbol <- unique(rownames(mtx))
genes.notmap <- setdiff(genes.symbol, grch38$symbol)
genes.symbol[ genes.symbol == "CDCA1" ] <- "NUF2"
genes.symbol[ genes.symbol == "KNTC2" ] <- "NDC80"
genes.symbol[ genes.symbol == "ORC6L" ] <- "ORC6"
genes.entrez <- unique(grch38$entrez[ grch38$symbol %in% genes.symbol ])

# First column - general category. Second - signature
md.human.custom <- data.frame(collection = "cancer", geneset = "PAM50", entrez = sort(genes.entrez))
save(md.human.custom, file = "data/md.human.custom.rda")
