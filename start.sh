#!/bin/sh
export MYSQL_USER=yoshi && export MYSQL_PASSWORD=pass && stack exec -- yesod devel --port 4444

