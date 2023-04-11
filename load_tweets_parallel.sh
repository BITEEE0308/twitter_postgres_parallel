#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | parallel bash load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:51298/ --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time echo "$files" | parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:12235/ --inputs
