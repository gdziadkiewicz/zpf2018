## Materiały do wykładu "Zaawansowane Programowanie Funkcyjne" Wydział MIM UW 2017/18

## "Advanced Functional Programming" course materials  (in Polish)

* Gotowe notatki/slajdy w katalogu www
* Kod w katalogu Code
* Do wygenerowania notatek i slajdów ze źródeł potrzebny program pandoc

### Szybki start

~~~~~
$ cabal update
$ cabal install pandoc
$ PATH=~/.cabal/bin:$PATH            # Linux
$ PATH=~/Library/Haskell/bin:$PATH   # OS X
$ git clone git://github.com/mbenke/zpf2018.git
$ cd zpf2018/Slides
$ make
~~~~~

albo, przy użyciu stack

~~~~
stack setup
stack install pandoc
export PATH=$(stack path --local-bin):$PATH
...
~~~~

Windows:
Do złożenia projekty można wykorzystać wsl (https://docs.microsoft.com/en-us/windows/wsl/install-win10 ). Wsl pozwala odapalać binarki windowsowe (aby zadziałał ten mechanizm należy podać nazwę binarki razem z rozszerzeniem) i automatycznie jest mu przekazywana zmienna środowiskowa PATH.
~~~~ (cmd/powershell)
> stack setup
> stack install pandoc
> git clone git://github.com/mbenke/zpf2018.git
> cd zpf2018/Slides
> wsl
$ make PANDOC=pandoc.exe
~~~~