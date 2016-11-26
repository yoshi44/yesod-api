
stack build error

```
stack build error
ld: warning: directory not found for option '-L/usr/local/Cellar/mysql/5.7.14/lib'
```

->

```
cd /usr/local/Cellar/mysql

ln -s /usr/local/Cellar/mysql/5.7.16 5.7.14
```

Start MySql

```
mysql.server start
```

Add handler

```
stack exec -- yesod add-handler
```

Add Module

```
ghc-pkg find-module Text.HTML.Scalpel
stack install scalpel
Add "scalpel" build-depends in the .cabal file
```

