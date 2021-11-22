source("selgenes_functions.R")

seed_genes = sub(".tsv", "", list.files("input_genes"))

gene_types = fread("data/gene_types.csv")$type
