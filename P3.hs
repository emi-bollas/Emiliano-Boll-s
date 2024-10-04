-- PŔACTICA 3 EN HASKELL: FUNCIONES CON ESTRUCTURAS DEFINIDAS POR EL PROGRAMADOR --
        -- Emiliano García Bollás, Laboratorio de Estructuras Discretas --

-- Nueva estructura, provista por Raúl
data List a = Void | Node a (List a) deriving Show

-- Función que calcula la cantidad de elementos de la nueva estructura List
longitud :: List a -> Int
longitud Void = 0
longitud (Node x xs) = 1 + longitud xs

-- Función que revisa si un elemento está contenido en una lista
estaContenido :: Eq a => List a -> a -> Bool
estaContenido Void e = False
estaContenido (Node x xs) e =
  if x == e
  then True
  else estaContenido xs e

-- Función que convierte una lista nativa de Haskell a una de la nueva estructura definida
convertirAEstructura :: [a] -> List a
convertirAEstructura [] = Void
convertirAEstructura (x:xs) = Node x (convertirAEstructura xs)

-- Proceso visceverso al de la función anterior, transforma una lista de la nueva estructura a una nativa de Haskell
convertirALista :: List a -> [a]
convertirALista Void = []
convertirALista (Node x xs) = x : convertirALista xs

-- Función que descarta elementos repetidos y conserva únicamente una aparición de cada uno
conjunto :: Eq a => List a -> List a
conjunto Void = Void
conjunto (Node x xs) =
  if estaContenido xs x 
  then conjunto xs
  else Node x (conjunto xs)

-- Función que elimina un elemento en el índice indicado, considerando que el primer elemento está en la posición 0
eliminarIndice :: List a -> Int -> List a
eliminarIndice Void a = Void
eliminarIndice (Node x xs) n =
  if n < 0 || n > longitud (Node x xs)-1
  then error "Indice fuera del rango permitido."
  else if n == 0
  then xs
  else Node x (eliminarIndice xs (n-1))

-- Función que inserta un elemento en el índice indicado
insertarIndice :: List a -> Int -> a -> List a
insertarIndice Void n e = Node e (Void)
insertarIndice (Node x xs) n e =
  if n < 0 || n > longitud (Node x xs)-1
  then error "Indice fuera del rango permitido."
  else if n == 0
  then Node e (Node x xs)
  else Node x (insertarIndice xs (n-1) e)

-- Función que recorre a la derecha los elementos en la cabeza de una lista
recorrerLista :: List a -> Int -> List a
recorrerLista Void a = Void
recorrerLista (Node x xs) a =
  if a > 0
  then recorrerLista (convertirAEstructura(adj(convertirALista(Node x xs)))) (a-1)
  else (Node x xs)

adj :: [a] -> [a]
adj [] = []
adj (x:xs) = xs ++ [x]

