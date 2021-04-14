#Wczytanie danych z pliku csv
data <- read.csv("dev/WD/data-visualisation-uam/resources/games.csv", header = TRUE)

# Wykres przedstawiaj?cy rezultaty partii rozpocz?tych 20 najbardziej popularnymi otwarciami

# Zliczam wyst?powanie wszystkich otwar? i sortuje malej?co
data %>%
  count(opening_name) %>% arrange(desc(n)) -> most_common_openings

# Z wszystkich danych wyci?gam tylko te wiersze, kt?re dotycz? 5 najpopularniejszych otwar?
data %>%
  filter(opening_name %in% head(most_common_openings$opening_name, 5)) -> filtered_data

# Z wszystkich danych dot 5 najpopularniejszych otwarac wybieramy tylko te które mają niż 150 ruchow
filtered_data %>%
  filter(turns <=100) -> ridge_data

ggplot(ridge_data, aes(x=turns,y = opening_name, fill = opening_name)) +
  geom_density_ridges(scale = 4) +
  xlab('Number of turns') +
  ylab('Opening name') +
  labs(fill='Opening name')+
  scale_fill_manual(values = wes_palette("Moonrise3")) +
  theme_minimal()




# Build Dataset
group <- c(rep("Sicilian Defense",4),rep("French Defense",2),rep("Italian Game",3))
subgroup <- paste(c("Dragon Variation","Four Knights Variation","Najdorf Variation","Marshall Counterattack","French Defense","Steinitz Attack","Giuoco Piano","Evans Gambit","Giuoco Pianissimo"), sep=": ")
length(which(data=="Sicilian Defense: Dragon Variation")) -> dragon
length(which(data=="Sicilian Defense: Four Knights Variation")) -> fK
length(which(data=="Sicilian Defense: Najdorf Variation")) -> najdorf
length(which(data=="Sicilian Defense: Marshall Counterattack")) -> marshall
length(which(data=="French Defense")) -> adv
length(which(data=="French Defense: Steinitz Attack")) -> exc
length(which(data=="Giuoco Piano")) -> anti
length(which(data=="Italian Game: Evans Gambit")) -> evans
length(which(data=="Italian Game: Giuoco Pianissimo")) -> giuco
print(fK)
value <- c(dragon ,fK,najdorf,marshall,adv,exc,anti,evans,giuco)
print(value)
dataToPlot <- data.frame(group,subgroup,value)

# treemap
treemap(dataToPlot,
        index=c("group","subgroup"),
        vSize="value",
        type="index",
        title="Number of games with each opening",
        align.labels=list(c("center", "center"), c("left", "top"))
        
) 

