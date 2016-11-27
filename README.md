[![Build Status](https://travis-ci.org/yoshi44/yesod-api.svg?branch=master)](https://travis-ci.org/yoshi44/yesod-api)
[![Coverage Status](https://coveralls.io/repos/github/yoshi44/yesod-api/badge.svg)](https://coveralls.io/github/yoshi44/yesod-api)
# Yesod API application

NOTE

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
Setting MySql for test

```
create user yoshi@localhost identified by 'pass';
grant all on yesodapi_test.* to yoshi@localhost identified by 'pass';
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

