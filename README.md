```
stack build error
ld: warning: directory not found for option '-L/usr/local/Cellar/mysql/5.7.14/lib'
```

->
  
```
cd /usr/local/Cellar/mysql

ln -s /usr/local/Cellar/mysql/5.7.16 5.7.14
```


