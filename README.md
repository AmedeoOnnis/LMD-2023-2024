Amedeo Onnis

Metodi digitali per la ricerca sociale (Laboratorio) - A.A. 2023/2024
________________________________________
Net Zero Emissions entro il 2050: un confronto tra due thread

Analisi su Reddit sull’obiettivo della neutralità climatica

Introduzione

A conclusione del laboratorio Metodi digitali per la ricerca sociale si è scelto di sviluppare un breve progetto di analisi sul tema della neutralità climatica. L’analisi considera come dati di partenza i commenti di due thread in lingua inglese pubblicati sulla piattaforma Reddit in cui si discute il tema delle emissioni nette zero, o Net Zero Emissions (NZE); il termine deriva dagli Accordi sul clima di Parigi del 2015 e indica uno scenario globale in cui i Paesi che hanno aderito all’accordo si impegnano a raggiungere uno stato di azzeramento delle emissioni di CO2 entro il 2050. L’obiettivo dello scenario NZE è stato sin da subito divisivo e ha generato opinioni contrastanti nella popolazione mondiale. Non è un caso, quindi, che per questa breve analisi si sia scelto di adottare due thread con differenze sostanziali relative alla data di pubblicazione e alla natura della domanda. Nella fattispecie, il primo thread risale al marzo 2021 e sottopone un quesito neutrale – “What makes you hopeful that we can reach net zero emissions by 2050?” –, mentre il secondo thread è stato pubblicato ad agosto 2023 e propone una riflessione di stampo più umoristico – “Net Zero by 2050 is Definitely Still Possible”. Naturalmente, i due thread costituiscono due punti di partenza diversi: è lecito aspettarsi che il secondo thread, che si apre con un’affermazione netta e divisiva e, nel suo contenuto, presenta un’opinione tragicomica sull’argomento, generi dei commenti più lunghi e articolati rispetto al primo, che nasce invece con l’intento di scatenare una discussione più superficiale tra gli utenti. Bisogna, inoltre, tenere conto del fatto che i due thread sono stati pubblicati in due momenti diversi: il primo, più datato, avrà potenzialmente raggiunto molte più persone della community e generato più commenti rispetto al secondo, sebbene al momento della fase di data retrieving il primo thread risulti archiviato e il secondo sia ancora aperto. Nel corso dell’analisi si cercherà conferma nelle supposizioni proposte, generando dei grafici rappresentativi per entrambi i thread. Per farlo si utilizzerà il linguaggio R, all’interno dell’ambiente di RStudio, con cui verranno creati anche i grafici per la fase di visualizzazione dei dati.

Le fasi dell’analisi

1.	Download e caricamento delle librerie. Il processo di analisi è cominciato con il download delle librerie:

•	RedditExtractoR; estrazione dei commenti dai thread di Reddit

•	tm e dplyr; operazioni di text mining, pulizia e tokenizzazione dei commenti

•	quanteda.textplots e quanteda.textstats; analisi statistiche sui commenti

•	udpipe; analisi statistiche conclusive

•	ggplot2 e lattice; costruzione dei grafici

Dopo il download, che va effettuato solo per le librerie che non sono preinstallate su RStudio, sono state “richiamate” tutte le librerie necessarie per l’analisi.

2.	Data retrieving e creazione data frame. Una volta richiamate le librerie, si è proceduto con il download dei due thread e dei commenti al loro interno. Sono state create due variabili, una per ciascun thread, con il comando get_thread_content della libreria RedditExtractoR e al link del thread da scaricare. Dai due thread sono stati estratti i commenti, inseriti nei rispettivi data frame.

3.	Pulizia e tokenizzazione dei commenti. Il set di commenti è stato pulito dalle stopwords e da tutto ciò che non risultava necessario per questa analisi. Per farlo è stata utilizzata la libreria di stopwords in inglese.

4.	Individuazione dei bigrammi. La prima analisi si è concentrata sui bigrammi. Sono stati creati due data frame con due colonne per il bigramma individuato e il numero di occorrenze. Le tabelle sono state messe in ordine decrescente di occorrenze prima di costruire il grafico.

5.	Calcolo delle frequenze. La seconda analisi è stata effettuata per individuare le singole parole. I token rintracciati sono stati inseriti in un corpus e in una matrice con le occorrenze di ciascun token. Per facilitare la creazione del grafico, sono stati estratti i primi venti token.

6.	Occorrenze delle Parts of Speech. Nell’ultima parte dell’analisi è stata utilizzata la libreria udpipe per individuare le parti del discorso nei data frame e calcolarne l’occorrenza. Le 17 parti del discorso sono state annotate in un data frame con il numero di occorrenze e il valore percentuale di ciascuna.

7.	Generazione dei grafici. I risultati sono stati inseriti nei grafici generati con ggplot, lattice e quanteda.textplots.
