#!/bin/zsh

[ -z "$1" ] && echo Missing argument, type searcher --help for guide.

case "$1" in
	"--help"|"-h")
		echo Usage: searcher QUERY
		echo Search files entries inside sql database.
		;;
	*)
		mysql -s -u root -pmysql_PWD -D indexing -e "select path from data0 where path like '%$1%'" | grep --color -i "$1"
		;;
esac
