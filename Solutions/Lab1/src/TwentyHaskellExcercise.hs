module TwentyHaskellExcercise
where
class Fluffy f where
  furry :: (a -> b) -> f a -> f b
 
-- Exercise 1
-- Relative Difficulty: 1
instance Fluffy [] where
  furry = fmap
 
-- Exercise 2
-- Relative Difficulty: 1
instance Fluffy Maybe where
  furry = fmap
 
-- Exercise 3
-- Relative Difficulty: 5
instance Fluffy ((->) t) where
  furry  = (.)
 
newtype EitherLeft b a = EitherLeft (Either a b)
newtype EitherRight a b = EitherRight (Either a b)
 
-- Exercise 4
-- Relative Difficulty: 5
instance Fluffy (EitherLeft t) where
  furry f (EitherLeft (Left l)) =  EitherLeft (Left (f l))
  furry _ (EitherLeft (Right r)) =  EitherLeft (Right r)

-- Exercise 5
-- Relative Difficulty: 5
instance Fluffy (EitherRight t) where
  furry f (EitherRight e) = EitherRight (fmap f e)
 
class Misty m where
  banana :: (a -> m b) -> m a -> m b
  unicorn :: a -> m a
  -- Exercise 6
  -- Relative Difficulty: 3
  -- (use banana and/or unicorn)
  furry' :: (a -> b) -> m a -> m b
  furry' f =  banana (unicorn . f)
 
-- Exercise 7
-- Relative Difficulty: 2
instance Misty [] where
  banana = (=<<)
  unicorn = return
 
-- Exercise 8
-- Relative Difficulty: 2
instance Misty Maybe where
  banana = (=<<)
  unicorn = return
 
-- Exercise 9
-- Relative Difficulty: 6
instance Misty ((->) t) where
  banana f a t = f (a t) t
  unicorn = const
 
-- Exercise 10
-- Relative Difficulty: 6
instance Misty (EitherLeft t) where
  banana f (EitherLeft (Left x)) = f x
  banana _ (EitherLeft (Right r)) = EitherLeft (Right r)
  unicorn = EitherLeft . Left
 
-- Exercise 11
-- Relative Difficulty: 6
instance Misty (EitherRight t) where
  banana f (EitherRight (Right r)) = f r
  banana _ (EitherRight (Left l)) = EitherRight (Left l)
  unicorn = EitherRight . Right
 
-- Exercise 12
-- Relative Difficulty: 3
jellybean :: (Misty m) => m (m a) -> m a
jellybean = banana id
 
-- Exercise 13
-- Relative Difficulty: 6
apple :: (Misty m) => m a -> m (a -> b) -> m b
apple a f = banana (\aa -> banana (\ff -> (unicorn.ff) aa) f) a
 
-- Exercise 14
-- Relative Difficulty: 6
moppy :: (Misty m) => [a] -> (a -> m b) -> m [b]
moppy [] _ = unicorn []
--Działające w jednej linii
--moppy (x:xs) f = banana (\xx -> banana (\xss -> unicorn (xx:xss)) (moppy xs f)) (f x)
moppy (x:xs) f =
    let mtail = moppy xs f
        mhead = f x
        in
    banana (\head' -> banana (\tail' -> unicorn (head':tail')) mtail) mhead
--moppy xs f =
--    let mx1 = xs !! 0
--        mx2 = xs !! 1
--        in
--    mx1 >>= (\x1 -> mx2 >>=(\x2 -> return [x1,x2]))
 
-- Exercise 15
-- Relative Difficulty: 6
-- (bonus: use moppy)
sausage :: (Misty m) => [m a] -> m [a]
sausage = flip moppy id
 
-- Exercise 16
-- Relative Difficulty: 6
-- (bonus: use apple + furry')
banana2 :: (Misty m) => (a -> b -> c) -> m a -> m b -> m c
banana2 f ma mb = apple mb (furry' f ma)
 
-- Exercise 17
-- Relative Difficulty: 6
-- (bonus: use apple + banana2)
banana3 :: (Misty m) => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
banana3 f ma mb mc = apple mc (banana2 f ma mb)
 
-- Exercise 18
-- Relative Difficulty: 6
-- (bonus: use apple + banana3)
banana4 :: (Misty m) => (a -> b -> c -> d -> e) -> m a -> m b -> m c -> m d -> m e
banana4 f ma mb mc md = apple md (banana3 f ma mb mc)
 
newtype State s a = State {
  state :: s -> (s, a)
}
 
pies :: (a->b)->(a->c)->a->(b,c)
pies l r x = (l x, r x)
-- Exercise 19
-- Relative Difficulty: 9
instance Fluffy (State s) where
  furry f s = State{state= pies (fst.state s) (f.snd.state s)}
 
-- Exercise 20
-- Relative Difficulty: 10
instance Misty (State s) where
  banana f sa = State{state= \s -> state ((f.snd.state sa) s) s}
  unicorn a = State{state=pies id (const a)}

main :: IO ()
main = return ()