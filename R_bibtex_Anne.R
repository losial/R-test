rm(list=ls())

setwd("/users/Losia/Documents/My Dropbox/Anne") #@home - my laptop
setwd("/Users/naksh50p/Dropbox/Anne") #@work

options(scipen=100)

#install.packages('ProjectTemplate')
library('ProjectTemplate')

#install.packages('knitr')
library('knitr')

#install.packages('devtools')
library(devtools)
install_github("knitcitations", "cboettig")
#install.packages('bibtex')
library(bibtex)
require(knitcitations)

#in the source file for every "incollection" add line ",publisher = {NA}", using text editor!
biblio <- read.bib("Anne_re_exported_refs.bib")
head(biblio)
biblio[[1]]$key
length(biblio)

###extract a vector of IDs
id<-unlist(biblio[[]]$key)
length(id)

###OR
###create a vector of numerical IDs
#id <- sprintf("ID%03d", c(1:length(biblio)))
#head(id)
#length(id) 

###extract a vector of titles
title<-unlist(biblio[[]]$title)
length(title)

###extract a vector of abstracts (with some missing values)
#First, extend each vector in your list with NAs to get vectors of the same length. Then create your matrix. For example:
corrected.list <- lapply(biblio[[]]$abstract, function(x) {c(x, rep(NA, 1 - length(x)))})
a <- do.call(rbind, corrected.list)
abstract<-unlist(a)[,1]
length(abstract)
#str(abstract)

###extract a vector of journals (with some missing values)
corrected.list <- lapply(biblio[[]]$journal, function(x) {c(x, rep(NA, 1 - length(x)))})
a <- do.call(rbind, corrected.list)
journal<-unlist(a)[,1]
length(journal)

###extract a vector of  authors (first author)
authors<-lapply(biblio,function(x) x$author$family[[1]])
head(authors)
length(authors)

###extract a vector of first family name and year and use as custom keywords for Abstrackr
keywords<-lapply(biblio,function(x) paste(x$author$family[[1]], x$year, sep = "_") )
head(keywords)
length(keywords)


#check for whitespaces (tabs, lin ends) in the tatles and abstracts
grep("\\t", title) #no tabs in the title
grep("\\t", abstract) #no tabs in the abstract
grep("\\t", journal) #no tabs in the journal
grep("\\n", title) 
grep("\\n", abstract) 
grep("\\n", journal)
#if e.g. there are new line symboles in the abstract use:
# abstract<-gsub("\\n"," ", abstract)


###bind columns together
data<-cbind(id, title, abstract, keywords, authors, journal)
head(data)
write.table(data, file="Anne_abstrackr_input.txt", sep="\t", row.names = FALSE, col.names = TRUE, quote = FALSE)


#EXAMPLE
#write.bib(c('bibtex', 'knitr', 'knitcitations'), file="example.bib")
#biblio <- read.bib("example.bib")
#biblio[[1]]
#citet(biblio[1])
#bibliography()
