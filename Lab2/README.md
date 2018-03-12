# Lab2

1.  Na własnym komputerze
    * Zainstalować `stack` *done*
    * Zainstalować GHC 7.10 przy pomocy `stack setup` *done*
    * Zainstalować GHC 8 przy pomocy `stack setup` *done*
    * Uruchomić `stack ghci` 7.10 i 8 *done*
    * Zbudować i uruchomić projekt hello, trochę go zmodyfikować
    * `stack install QuickCheck` *done*
    
2. Na students
   * Można zrobić to samo co powyżej, ale możliwy problem z quota
   * `stack setup` przy użyciu GHC 7.10 (i może 7.8) z PUBLIC
   * Reszta jak wyżej

Jeżeli ktoś nie jest w stanie użyć `stack`, można `cabal install doctest HUnit QuickCheck`

# QuickCheck
* Wypróbuj testy przy uzyciu `doctest` i `HUnit` *Wrzuciłem testy Fib z wykładu i opaliłem `stack exec doctest ./src/Fib.hs`. W pliku spec.hs zrobiłm testy HUnit i poczarowałem main, żeby przy niepowodzeniu testow failowa. Wypadaloby sie dowiedziec jak sie to w typowej sytuacji.*
* Napisz kilka testów dla sortowania [Int] *Zrobiłem kawałek kodu, ktory laduje wszystkie property z danego modulu i odpala. Failuje, jesli cos nie przejdzie. Skopiowałem idempotencje i dodałem sortowanie permutacji*
* Napisz kilka testów sprawdzających własności funkcji na listach (++,concat,map,etc.) *Zrobiłem dla ++ i map*
* Napisz generator dla OrderedInts (posortowanych [Int])
* Napisz generator dla jakichś drzew (np. BST) i użyj go w testach
* Bazując na notatkach z wykładu, odtwórz QuickCheck v1 (i ulepsz go)