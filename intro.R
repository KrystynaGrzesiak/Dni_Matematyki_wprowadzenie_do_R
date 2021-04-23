### Agenda
# 1. Typy danych w R
# 2. Operacje na wektorach
# 3. Jak korzystać z funkcji w R
# 4. Dokumentacja
# 5. Jak budować funkcje, pisać instrukcje warunkowe itd.


### Typy danych w R
## Typy atomowe - jednorodne wektory
# Logiczne
TRUE
FALSE
T
F
True

length(TRUE) # nie ma wartości skalarnych, są tylko wektory!
mode(TRUE) # sposób przechowywania
typeof(TRUE)

# Liczbowe
1 / całkowity
1.23 # rzeczywisty/zmiennoprzecinkowy

1.23e3
1.23e-3

typeof(1)
mode(1)
typeof(1L)
typeof(1.23)

1+2i
typeof(1+2i)

Inf
1/0

# napisy
"napis"
typeof("napis")
mode("napis")

letters
LETTERS


## Tworzenie wektorów

#c()
c("A", "B", "C")
c(1:2, "c")
1:2
3 * 2:3

typeof(1:10)
rep("a", 12)

help(rep)
?rep
????rep

paste("a", "b")  # ...
help(paste)
paste(c("a", "b"), "a")
paste(c("a", "b"), "a", sep=".", collapse="-")


# puste wektory
numeric(4)
logical(2)
character(2)


# sprawdzenie typu
is.logical(TRUE)
is.logical(1)

# Co zwróci takie wywołanie?
is.logical(as.logical(3))

## Hierarchia typów
# logical < integer < double < complex < character

as.integer(TRUE)
as.double(TRUE)
as.complex(TRUE)
as.character(TRUE)

# Rzutowanie działa dla całych wektorów!
as.character(1:5)

## Wartości specjalne
NA # not available - tzw. missing data

# Co zwróci takie wywołanie?
typeof(as.character(NA))

# Typy NA's
NA_real_
typeof(NA_real_)

## Nazywanie obiektów
# Operator przypisania "<-", "->"
# Operator (=) także pozwala przypisywać
?make.names

imie <- "Jakub"

# Uwaga!
TRUE <- FALSE
T <- FALSE
T
rm(T)
T

### Operacje na wektorach w R
?Arithmetic
# Dodawanie +
# Odejmowanie - 
# Mnożenie *
# Dzielenie /
# Potęgowanie ** ^
# Reszta z dzielenia %%
# Dzielenie całkowitoliczbowe %/%

1 + 2
2L / 3L
2 ** 2


# Wynik takiego wywołania to w przybliżeniu?
?Comparison
2 ^ (1/2)

5 %% 4
14 %/% 4

## Operatory relacji
# <, >, <=, >=, == , !=
2 < 5
3 <= 3
2 == 3
3 != 3
"Ala" < "Jola"
FALSE > TRUE

#Co zwróci takie wywołanie?
c(TRUE, FALSE) & c(TRUE, TRUE) 

## Operatory logiczne
?Logic
# !x, x | y, x & y
!TRUE
TRUE | FALSE
TRUE & FALSE

# Co zwróci takie wywołanie?
TRUE | NA

# Funkcyjność R
`+`(1, 1)
`<-`(x, 5)
x

# Indeksowanie wektorów w R
letters
letters[1:4]
letters[c(10, 1, 11, 21, 2)]
letters[rep(2, 10)]

# Co zwróci takie wywołanie?
letters[letters > "k"]

## Funkcje w R
# Zwektoryzowane funkcje
sin(pi/2)
tan(pi/2)
factorial(14)

x <- sample(1:5, size=2)

# Funkcje agregujące
x <- factorial(1:4)
print(x)
sum(x)
min(x)
x > 1 
all(x > 1)
any(x > 1)

max(x)
which.max(x)
x[which.max(x)]

sort(x)
sort(x, decreasing = TRUE)

2 %in% x
7 %in% x

### Listy
# Lista = uogólniony wektor o dowolnych typach

L <- list(TRUE, "Jakub", 1:4, sum)
L
L[1] # zwróci listę
L[[1]] #zwróci element listy
L[1:2]
L[[1:2]]
length(list)

L[[4]](1:4)

# Tak jak w wektorach, w listach można nadpisywać elementy
L[[2]] <- "Krysia"
L

# Listy można ze sobą łączyć
L1 <- list(1:2, "abc")
c(L, L1)

# poszczególnym elementom można nadawać nazwy
names(L) <- c("logiczny", "tekstowy", "liczbowy", "funkcja")

L[["logiczny"]]
L$logiczny # z tym trzeba uważać!

## Czym jest data.frame?
# Powszechnie używany format tabelarycznego przedstawienia danych
# Dla nas: lista wektorów tej samej długości!

imiona <- c("Jarek", "Kasia", "Michał")
wiek <- c(15, 21, 37)
uczen <- c(TRUE, TRUE, FALSE)

df <- data.frame(imie=imiona, wiek=wiek, uczen=uczen)
df
View(df)
df$imie
df[1, ]
df[df$uczen == TRUE, "imie"]

### Istotne rzeczy, kolejne kroki!
# 1. Funkcje
# 2. Pętle
# 3. apply() functions
# 4. intstrukcje warunkowe





