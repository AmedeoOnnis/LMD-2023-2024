install.packages("RedditExtractoR")
install.packages("tm")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("udpipe")
install.packages("lattice")

library(RedditExtractoR)
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(tm)
library(dplyr)
library(ggplot2)
library(udpipe)
library(lattice)

thread2021 <- get_thread_content("https://www.reddit.com/r/AskReddit/comments/m8o6iq/what_makes_you_hopeful_that_we_can_reach_net_zero/")
thread2023 <- get_thread_content("https://www.reddit.com/r/collapse/comments/15uo2dx/net_zero_by_2050_is_definitely_still_possible/")

commenti2021<-thread2021$comments
commenti2023<-thread2023$comments

# 2021

minCommenti2021<-tolower(commenti2021$comment)
tokenCommenti2021<-tokens(minCommenti2021)

commenti2021<-cbind(commenti2021, ntype(tokenCommenti2021),
                    ntoken(tokenCommenti2021))%>%
                    mutate(richness=ntype
                          (tokenCommenti2021)/ntoken(tokenCommenti2021))
colnames(commenti2021)[11] ="tipo"
colnames(commenti2021)[12] ="token"

stopwords_en <- stopwords("en")

commenti2021$comment <- sapply(commenti2021$comment, function(x) {
  x <- tolower(x)
  x <- removeWords(x, stopwords_en)
  
  return(x)
})

bigrammi2021<-tokenCommenti2021 %>%
  tokens_remove(stopwords("en")) %>%
  tokens_select(pattern = "^[a-z]", valuetype = "regex",
                case_insensitive = FALSE, padding = TRUE) %>%
  textstat_collocations(min_count = 5, size=2)

dfbigrammi2021<-bigrammi2021 %>% 
  select(Bigramma = collocation, count)

dfbigrammi2021$Bigramma <- factor(dfbigrammi2021$Bigramma,
                                  levels = dfbigrammi2021$Bigramma
                                  [order(dfbigrammi2021$count,
                                         decreasing = TRUE)])

ggplot(dfbigrammi2021, aes(x = Bigramma, y = count)) +
  geom_bar(stat = "identity", color = "black", fill="darkorange") +
  theme(axis.text.x = element_text(hjust = 1, angle = 90)) +
  order() +
  labs(title = "Bigrammi - 2021",
       x = "Bigramma",
       y = "Occorrenze")

corpus2021<-VCorpus(VectorSource(tokenCommenti2021))

dataset2021<-tm_map(corpus2021, content_transformer(tolower))
dataset2021<-tm_map(dataset2021, content_transformer(removeWords),
                    stopwords("english"))

matrice_dataset2021<-TermDocumentMatrix(dataset2021)
matrice_dataset2021<-as.matrix(matrice_dataset2021)

somma_dataset2021<-sort(rowSums(matrice_dataset2021),
                  decreasing = TRUE)
freqDataset2021<-data.frame(parola = names(somma_dataset2021),
                            freq=somma_dataset2021)

head(freqDataset2021, 10)

top20Freq2021<-freqDataset2021[1:20,]

top20Freq2021$parola <- factor(top20Freq2021$parola,
                                  levels = top20Freq2021$parola
                                  [order(top20Freq2021$freq,
                                         decreasing = TRUE)])

ggplot(top20Freq2021, aes(x = parola, y = freq)) + 
  geom_bar(stat = "identity", color = "black", fill = "darkorange") +
  theme(axis.text.x = element_text(hjust = 1, angle = 90)) +
  order() +
  labs(title = "Parole più frequenti - 2021",                   
       x = "Parola", 
       y = "Frequenza")

ud_model<-udpipe_download_model(language = "english")
ud_model<-udpipe_load_model(ud_model$file_model)
PoS2021<-udpipe_annotate(ud_model, x = commenti2021$comment,
                     doc_id = commenti2021$comment_id)
PoS2021<-as.data.frame(PoS2021)

statPoS2021 <- txt_freq(PoS2021$upos)
statPoS2021$key <- factor(statPoS2021$key, levels = rev(statPoS2021$key)) 
barchart(key ~ freq, data = statPoS2021, col = "darkorange",
         main = "Parts of Speech - 2021", 
         xlab = "Frequenza")

# 2023

minCommenti2023<-tolower(commenti2023$comment)
tokenCommenti2023<-tokens(minCommenti2023)

commenti2023<-cbind(commenti2023, ntype(tokenCommenti2023),
                    ntoken(tokenCommenti2023))%>%
  mutate(richness=ntype
         (tokenCommenti2023)/ntoken(tokenCommenti2023))
colnames(commenti2023)[11] ="tipo"
colnames(commenti2023)[12] ="token"

stopwords_en <- stopwords("en")

commenti2023$comment <- sapply(commenti2023$comment, function(x) {
  x <- tolower(x)
  x <- removeWords(x, stopwords_en)
  
  return(x)
})

bigrammi2023<-tokenCommenti2023%>%
  tokens_remove(stopwords("en")) %>%
  tokens_select(pattern = "^[a-z]", valuetype = "regex",
                case_insensitive = FALSE, padding = TRUE) %>%
  textstat_collocations(min_count = 5, size=2)

dfbigrammi2023<-bigrammi2023%>% 
  select(Bigramma = collocation, count)

dfbigrammi2023$Bigramma <- factor(dfbigrammi2023$Bigramma,
                                  levels = dfbigrammi2023$Bigramma
                                  [order(dfbigrammi2023$count,
                                         decreasing = TRUE)])

ggplot(dfbigrammi2023, aes(x = Bigramma, y = count)) +
  geom_bar(stat = "identity", color = "black", fill="darkorange") +
  theme(axis.text.x = element_text(hjust = 1, angle = 90)) +
  order() +
  labs(title = "Bigrammi - 2023",
       x = "Bigramma",
       y = "Occorrenze")

corpus2023<-VCorpus(VectorSource(tokenCommenti2023))

dataset2023<-tm_map(corpus2023, content_transformer(tolower))
dataset2023<-tm_map(dataset2023, content_transformer(removeWords),
                    stopwords("english"))

matrice_dataset2023<-TermDocumentMatrix(dataset2023)
matrice_dataset2023<-as.matrix(matrice_dataset2023)

somma_dataset2023<-sort(rowSums(matrice_dataset2023),
                        decreasing = TRUE)
freqDataset2023<-data.frame(parola = names(somma_dataset2023),
                            freq=somma_dataset2023)

head(freqDataset2023, 10)

top20Freq2023<-freqDataset2023[1:20,]

top20Freq2023$parola <- factor(top20Freq2023$parola,
                               levels = top20Freq2023$parola
                               [order(top20Freq2021$freq,
                                      decreasing = TRUE)])

ggplot(top20Freq2023, aes(x = parola, y = freq)) + 
  geom_bar(stat = "identity", color = "black", fill = "darkorange") +
  theme(axis.text.x = element_text(hjust = 1, angle = 90)) +
  order() +
  labs(title = "Parole più frequenti - 2023",                   
       x = "Parola", 
       y = "Frequenza")

ud_model<-udpipe_download_model(language = "english")
ud_model<-udpipe_load_model(ud_model$file_model)
PoS2023<-udpipe_annotate(ud_model, x = commenti2023$comment,
                         doc_id = commenti2023$comment_id)
PoS2023<-as.data.frame(PoS2023)

statPoS2023<-txt_freq(PoS2023$upos)
statPoS2023$key <- factor(statPoS2023$key, levels = rev(statPoS2023$key)) 
barchart(key ~ freq, data = statPoS2023, col = "darkorange",
         main = "Parts of Speech - 2023", 
         xlab = "Frequenza")