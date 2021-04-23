
### Agenda
# 1. Wczytywanie pakietów w R
# 2. Wczytywanie i zapisywanie danych z pliku
# 3. Podstawy pakietu dplyr
# 4. Podstawy wizualizacji z pakietem ggplot2

################################################################################

# 1. Wczytywanie pakietów w R

#instalacja 
if(FALSE) {
  install.packages("dplyr")
  install.packages("ggplot2")
}

#wczytywanie
library(dplyr) #przetwarzanie danych

library(ggplot2) #wizualizacja
detach("package:ggplot2", unload = TRUE)
library(ggplot2)


################################################################################

# 2. Wczytywanie i zapisywanie danych z pliku

## wczytywanie danych
iris_data <- read.csv("iris.csv", header = TRUE) 
read.table("iris.csv", head = TRUE, sep = ",", dec = ",") #a także read.csv2(...) - domyślny separator to ";"

## wyświetlanie danych
head(iris_data)
head(iris_data, n = 10)

tail(iris_data, n = 8)

## zmiana nazw kolumn
colnames(iris_data) <- c("Id", "Sepal_Length", "Sepal_Width", 
                         "Petal_Length", "Petal_Width", "Species")

## zapisywanie danych
write.csv(iris_data, "iris_new_columns.csv") #write.table(...), write.csv2(...)

################################################################################

# 3. Podstawy pakietu dplyr


## znak pipe %>% 

?dim

dim(iris_data)
iris_data %>% dim() # pipe przekazuje obiekt z lewej strony do funkcji z prawej


###### Pytanie: Co będzie wynikiem poniższego wywołania? 

iris_data %>% dim() %>% sum()

######


## Funkcja select(...)

select(iris_data, Sepal_Length, Sepal_Width)
iris_data %>% select(Sepal_Length, Sepal_Width) 

all.equal(select(iris_data, Sepal_Length, Sepal_Width),
          iris_data %>% select(Sepal_Length, Sepal_Width)) # to samo

iris_data %>% 
  select( -Species, -Id) %>% 
  colMeans() # funkcja z bazowego R


# funkcja filter()

iris_data %>% 
  filter(Species == "setosa", Sepal_Length >= 5) #przecinek oznacza to samo co &

iris_data %>% 
  filter(Species == "setosa", Sepal_Length >= 5) %>% 
  nrow()


##############
#### PYTANIE: Ile jest w ramce danych kwiatów mających szerokość płatka (Petal_Width) większą od 0.2 i mniejszą od 1?

#???????

##############


## funkcja mutate(...)

iris_data %>% 
  mutate(Petal_area = Petal_Length*Petal_Width)


colours <- sample(x = c("red", "blue", "yellow"),
                  prob = c(0.1, 0.6, 0.3), 
                  size = nrow(iris_data),
                  replace = TRUE)

iris_colours <- iris_data %>% 
  mutate(Petal_area = Petal_Length*Petal_Width, 
         Colours = colours) # można tworzyć kilka kolumn jednocześnie


## grupowanie funkcją group_by(...)

iris_colours %>% 
  group_by(Species) # 3 grupy dla każdego gatunku

iris_colours %>% 
  group_by(Species, Colours) # 9 grup (3 gatunki x 3 kolory)

iris_colours %>% 
  group_by(Species, Colours) %>% 
  ungroup()


iris_colours %>% 
  group_by(Colours) %>% 
  mutate(mean_Petal_Length = mean(Petal_Length))

## funkcje summarise(...) i summarise_all(...)


# przykład ze zliczaniem grupowanych obserwacji

iris_colours %>% 
  group_by(Species) %>% 
  summarise(n = n())

iris_colours %>% 
  group_by(Colours) %>% 
  summarise(n = n())

#### Pytanie: Ile jest obserwacji yellow setosa?

# ????
###############################################


# agregacja

iris_colours %>% 
  group_by(Species) %>% 
  summarise(mean_Petal_Length = mean(Petal_Length))


head(iris_colours)

iris_colours %>% 
  select(-Id, -Colours) %>% 
  group_by(Species) %>% 
  summarise_all(.funs = sd)


iris_colours %>% 
  summarise_all(.funs = mean) # wartości NA dla kolumn o złym typie

colMeans(iris_colours) # błąd wywołania

################################################################################

# 4. Podstawy wizualizacji z pakietem ggplot2

## wykresy punktowe

ggplot(iris_colours, aes(x = Petal_Length, y = Petal_Width)) +
  geom_point()

ggplot(iris_colours, aes(x = Petal_Length, y = Petal_Width, col = Species)) +
  geom_point()

ggplot(iris_colours, aes(x = Petal_Length, y = Petal_Width, col = Species)) +
  geom_point() +
  ggtitle("Nice plot title here!") +  # dodanie tytułu
  theme_minimal()  # zmiana stylu wykresu 


## histogramy:

iris_plot <- iris_data %>% 
  group_by(Species) %>% 
  mutate(mean_Petal_Length = mean(Petal_Length))

# pipe przekazuje także dane do funkdji ggplot
iris_plot %>% 
  ggplot(aes(x = Petal_Length, fill = Species)) +
  geom_histogram(binwidth = 1)

iris_plot %>% 
  ggplot(aes(x = Petal_Length)) +
  geom_histogram(binwidth = 1)+
  facet_wrap(~Species, scales = "free_y") # dzielimy wykres na osobne panele, 
                                          #manipulujemy skalami przy użyciu parametru scales

# dodawanie kolejnego mappingu
ggplot(iris_plot, aes(x = Petal_Length)) +
  geom_histogram(binwidth = 1) +
  facet_wrap(~Species, scales = "free_y") +
  geom_vline(iris_plot, mapping = aes(xintercept = mean_Petal_Length, col = Species), size = 1)



## wykres słupkowy
iris_colours %>% 
  ggplot(aes(x = Colours, fill = Colours)) +
  geom_bar()

iris_colours %>% 
  ggplot() +
  geom_bar(aes(x = Colours, fill = Colours)) +
  scale_fill_manual(values = c("blue", "red", "gold"))
  


