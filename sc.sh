#!/bin/bash

dateSevenDaysAgo=$(date -u --date='7 days ago' +'%Y-%m-%d')
COMMIT_COUNT=0

scr() {
COMMIT_COUNT=$(git rev-list --count --all)
}


can_script() {
if ! scr; 
then
#if [ $? != 0 ]; then
  return 1
else
  date
  #scr
  echo 'All commits:' "$COMMIT_COUNT"
  echo All commits in 7 days: "$(git rev-list --since="$dateSevenDaysAgo" --count --all)"
  echo Added and deleted rows in 7 days: "$(git log --since="$dateSevenDaysAgo" --numstat | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}')"

  echo Authors in 7 days:
  git log --format='%an <%ae>' --since="$dateSevenDaysAgo" | sort | uniq
  return 0
fi
}

can_script
