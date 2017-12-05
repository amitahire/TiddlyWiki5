#!/bin/bash
tiddlywikidir=/opt/TiddlyWiki5/
wikidir=wiki-with-get-pinboard-bookmarks-plugin/
pidfile=/var/run/tiddlywiki.pid

kill $(< $pidfile)
cd $tiddlywikidir
nohup node tiddlywiki.js $wikidir --server 8080 $:/core/save/all text/plain text/html "" "" 0.0.0.0 &
echo $! > $pidfile
