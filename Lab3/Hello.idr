module Main
import Data.Vect

--test
main : IO ()
main = putStrLn "Hello, Idris world!"

-- 1. Dla wektorów napisz:
 
-- a) my_vect_map : (a -> b) -> Vect n a -> Vect n b
-- b)insert : Ord elem => (x : elem) -> (xsSorted : Vect k elem) -> Vect (S k) elem
-- c)insSort : Ord elem => Vect n elem -> Vect n elem 

-- pamiętaj o import Data.Vect

--Zad 1.a
my_vect_map : (a -> b) -> Vect n a -> Vect n b
my_vect_map _ [] = []
my_vect_map f (x::xs) = f x :: my_vect_map f xs

--Zad 1.b
insert : Ord elem => (x : elem) -> (xsSorted : Vect k elem) -> Vect (S k) elem
insert y [] = [y]
insert y (x::xs) = if y < x then [y,x] ++ xs else x :: insert y xs

--Zad 1.c
insSort : Ord elem => Vect n elem -> Vect n elem
insSort [] = []
insSort (x::xs) = insert x (insSort xs)

-- 2. Załóżmy, że typ macierzy nxm (n wierszy m kolumn) o wartościach w typie a reprezentowany jest przez Vect n (Vect m a). 

-- Używając:

create_empties : Vect n (Vect 0 elem)
create_empties = replicate  _ []

-- Napisz funkcje: 

-- a) transpose_mat : Vect m (Vect n elem) -> Vect n (Vect m elem)
-- zamieniającą macierz 

-- 1 2 3
-- 4 5 6

-- na

-- 1 4
-- 2 5
-- 3 6

-- b) addMatrix : Num a => Vect n (Vect m a) -> Vect n (Vect m a) -> Vect n (Vect m

-- c) multMatrix : Num a => Vect m (Vect n a) -> Vect n (Vect p a) -> Vect m (Vect p a)

-- Wskazówka do c) zacznij od transpose_mat prawej macierzy

--Zad 2a
transpose_mat : Vect m (Vect n elem) -> Vect n (Vect m elem)
transpose_mat [] = create_empties
transpose_mat (x::xs)  = zipWith (::) x (transpose xs)
--transpose_mat [row] = map (\x => [x]) row
--transpose_mat (row::rows) = map (\(x,y) => x ++ y) (zip (map (\x => [x]) row) (transpose_mat rows))

--Zad 2b
addMatrix : Num a => Vect n (Vect m a) -> Vect n (Vect m a) -> Vect n (Vect m a)
addMatrix = zipWith (zipWith (+))

--Zad 2c
multMatrix : Num a => Vect m (Vect n a) -> Vect n (Vect p a) -> Vect m (Vect p a)
multMatrix [] _ = []
multMatrix (y::ys) xs = (map (\x => sum (zipWith (*) x y)) xss) :: multMatrix ys xs
    where xss = transpose_mat xs

multMatrix2 : Num a => Vect m (Vect n a) -> Vect n (Vect p a) -> Vect m (Vect p a)
multMatrix2 [] _ = []
multMatrix2 ys xs = map (\y => (map (\x => sum (zipWith (*) x y)) (transpose_mat xs)) ys