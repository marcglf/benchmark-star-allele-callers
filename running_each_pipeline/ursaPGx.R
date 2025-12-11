library(ursaPGx)
library(dplyr)

##### FOR GENOTYPING 1KG ONLY #####
vcf = "/path/to/data/Genotyping/1KG_hg38_allchr_gsaArray.vcf.gz"
out = NULL
for(pgx in availableGenes()){
    if(pgx != "CYP2D6"){
        result <- tryCatch(
            {
                callDiplotypes(vcf, pgx, build = "GRCh38", phased = TRUE)
            },
            error = function(e) {
                message("error FOR ", pgx, " : ", e$message)
                return(NULL) 
            }
        )
        if(!is.null(result)){
        if(is.null(out)){out = result} else {out = cbind(out, result)}}
    }
}

out = as.data.frame(out)
write.table(out, quote=F, sep = "\t", file="/output/ursapgx_1KG_CHIP_geno.out")


##### FOR WGS 1KG ONLY #####
vcf = "/path/to/data/CCDG_14151_B01_GRM_WGS_2020-08-05_allchr.filtered.shapeit2-duohmm-phased.vcf.gz"
out = NULL
for(pgx in availableGenes()){
    if(pgx != "CYP2D6"){
        result <- tryCatch(
            {
                callDiplotypes(vcf, pgx, build = "GRCh38", phased = TRUE)
            },
            error = function(e) {
                message("error FOR ", pgx, " : ", e$message)
                return(NULL) 
            }
        )
        if(!is.null(result)){
        if(is.null(out)){out = result} else {out = cbind(out, result)}}
    }
}
out = as.data.frame(out)
write.table(out, quote=F, sep = "\t", file="/output/ursapgx_1KG_WGS_geno.out")


##### FOR low-pass/imputed 1KG-GET-RM ONLY #####
vcf = "/path/to/data/GeT-RM_low_pass_CRAM/GeT-RM_allchr_low-pass_0.5x_imputed_ligated.merged.vcf.gz"
out = NULL
for(pgx in availableGenes()){
    if(pgx != "CYP2D6"){
        result <- tryCatch(
            {
                callDiplotypes(vcf, pgx, build = "GRCh38", phased = TRUE)
            },
            error = function(e) {
                message("error FOR ", pgx, " : ", e$message)
                return(NULL) 
            }
        )
        if(!is.null(result)){
        if(is.null(out)){out = result} else {out = cbind(out, result)}}
    }
}
out = as.data.frame(out)
write.table(out, quote=F, sep = "\t", file="/output/ursapgx_1KG_GETRM_LOWPASS_geno.out")


##### FOR IMPUTATION 1KG-GET-RM ONLY #####
vcf = "/path/to/data/imputation/GeT-RM_allchr.gsaArray.mini4.merged.vcf.gz"
out = NULL
for(pgx in availableGenes()){
    if(pgx != "CYP2D6"){
        result <- tryCatch(
            {
                callDiplotypes(vcf, pgx, build = "GRCh38", phased = TRUE)
            },
            error = function(e) {
                message("error FOR ", pgx, " : ", e$message)
                return(NULL) 
            }
        )
        if(!is.null(result)){
        if(is.null(out)){out = result} else {out = cbind(out, result)}}
    }
}
out = as.data.frame(out)
write.table(out, quote=F, sep = "\t", file="/output/ursapgx_1KG_GETRM_LOWPASS_geno.out")
