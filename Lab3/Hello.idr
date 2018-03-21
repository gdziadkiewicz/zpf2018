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

--multMatrix2 : Num a => Vect m (Vect n a) -> Vect n (Vect p a) -> Vect m (Vect p a)
--multMatrix2 [] _ = []
--multMatrix2 ys xs = map (\y => (map (\x => sum (zipWith (*) x y)) (transpose_mat xs)) ys

--3. Obejrzyj typ Fin i funkcje integerToFin i index
 
--(:module Data.Vect, :doc Fin, :t integerToFin, :t index)

--sprawdź wartości:

-- integerToFin 0 4
-- integerToFin 1 4
-- integerToFin 2 4
-- integerToFin 3 4
-- integerToFin 4 4

-- Napisz funkcje:

--a) tryIndex : Integer -> Vect n a -> Maybe a
tryIndex : Integer -> Vect n a -> Maybe a
tryIndex {n} i xs =
    case integerToFin i n of
    Nothig => Nothing
    Just i => Just (index i xs)
 
tryIndex2 : Integer -> Vect n a -> Maybe a
tryIndex2 {n} i xs = map (flip index xs) (integerToFin i n) 
--b) odpowiednik take dla list
mytake : (n : Nat) -> (xs : List a) -> List a
mytake i [] = []
mytake Z _ = []
mytake (S n) (x::xs) = x :: (take n xs)  

--c) sumEntries : Num a => (pos : Integer) -> Vect n a -> Vect n a -> Maybe a
sumEntries : Num a => (pos : Integer) -> Vect n a -> Vect n a -> Maybe a
sumEntries {n} pos xs ys =
    map (flip index zs) (integerToFin pos n)
    where zs = zipWith (+) xs ys

-- 5. Zdefiniuj wectory używając zagnieżdżonych krotek, tak żeby

TupleVect : Nat -> Type -> Type
TupleVect Z ty = ()
TupleVect (S k) ty = (ty, TupleVect k ty)

test : TupleVect 4 Nat
test = (1,2,3,4,())

total appendTV : TupleVect n elem -> TupleVect m elem -> TupleVect (n+m) elem
appendTV {n=Z} () ys = ys
appendTV {n=S k} (e,r) ys = (e, appendTV r ys)    


