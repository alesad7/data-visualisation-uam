#Wczytanie danych z pliku csv
data <- read.csv("dev/WD/data-visualisation-uam/resources/games.csv", header = TRUE)

# Wykres przedstawiaj?cy rezultaty partii rozpocz?tych 20 najbardziej popularnymi otwarciami

# Zliczam wyst?powanie wszystkich otwar? i sortuje malej?co
data %>%
  count(opening_name) %>% arrange(desc(n)) -> most_common_openings

# Z wszystkich danych wyci?gam tylko te wiersze, kt?re dotycz? 5 najpopularniejszych otwar?
data %>%
  filter(opening_name %in% head(most_common_openings$opening_name, 5)) -> ridge_data

ggplot(ridge_data, aes(x=turns,y = opening_name, fill = opening_name)) +
  geom_density_ridges(scale = 4) +
  xlab('Number of turns') +
  ylab('Opening name') +
  labs(fill='Opening name')+
  scale_fill_manual(values = wes_palette("Moonrise3")) +
  theme_minimal()
