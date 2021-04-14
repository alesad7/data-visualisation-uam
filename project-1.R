#Wczytanie danych z pliku csv
data <- read.csv("dev/WD/data-visualisation-uam/resources/games.csv", header = TRUE)

# Wykres przedstawiaj?cy rezultaty partii rozpocz?tych 20 najbardziej popularnymi otwarciami

# Zliczam wyst?powanie wszystkich otwar? i sortuje malej?co
data %>%
  count(opening_name) %>% arrange(desc(n)) -> most_common_openings

# Z wszystkich danych wyci?gam tylko te wiersze, kt?re dotycz? 20 najpopularniejszych otwar?
data %>%
  filter(opening_name %in% head(most_common_openings$opening_name, 20)) -> bar_plot_data

ggplot(bar_plot_data, aes(y = opening_name, fill = victory_status)) +
  geom_bar() +
  xlab('Number of openings') +
  ylab(NULL) +
  ggtitle('Victory status in 20 most common chess openings') +
  scale_fill_manual(values=c("#4e8d7c", "#70af85", "#dff3e3", "#c6ebc9")) +
  theme(title = element_text(face = "bold")) +
  labs(fill = "Game result")

# Wybieram ze zbioru tylko dane o okre?lonych warunkach
# B?d? to wybrane wiersze zawieraj?ce wylosowane otwarcia szachowe

n.opening_name <- 15

data %>% 
  pull(opening_name) %>%
  unique() %>%
  sample(n.opening_name, replace = FALSE) -> selected.openings

# View(selected.openings)

data %>%
  filter(opening_name %in% selected.openings) -> point_plot_data

# View(point_plot_data)

ggplot(point_plot_data, aes(x = black_rating, y = white_rating, size = turns, color = winner)) +
  geom_point() +
  xlab('White rating') +
  ylab('Black rating') +
  ggtitle('Dependency between players rating and game result') +
  scale_color_manual(values = c("#000000", "#E7B800", "#ffffff")) +
  theme(
    legend.position = "bottom",
    title = element_text(face = "bold")) +
  labs(size = "Turns", color = "Winner")

