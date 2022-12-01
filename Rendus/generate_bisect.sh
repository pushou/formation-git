#!/bin/bash
set -euo pipefail
# shellcheck disable=SC2141
IFS='\n'

if [[ $# -lt 1 || $1 -lt 2 || $1 -gt 15 ]]; then
    echo "Usage: $0 <desired number of bisect steps between 2 to 15>"
    exit 1
fi
bisect_steps=$1

num_commits=$(( 1 << bisect_steps ))
echo "Will generate $num_commits commits (can go through in $bisect_steps bisect steps)"

# Neither the first nor the last commit can be special, it would be too easy!
interesting_commmit() {
    echo "$(( (RANDOM % (num_commits - 2)) + 1 ))"
}

# Determine index of the first bad commit
bad_commit=$(interesting_commmit)

# Add an ugly commit distinct from the first bad to demonstrate git bisect skip
ugly_commit=$(interesting_commmit)
while (( ugly_commit == bad_commit )); do
    ugly_commit=$(interesting_commmit)
done

echo "---"

mkdir bisect
cd bisect
git init
for (( commit=0 ; commit < num_commits ; ++commit )); do
    # Qualify commit goodness/badness/ugliness
    if [[ $commit -eq $ugly_commit ]]; then
        goodness="Ugly"
    elif [[ $commit -lt $bad_commit ]]; then
        goodness="Good"
    else
        goodness="Bad"
    fi

    # Write it in a text file that changes on every commit, commit it
    echo "$goodness commit #$commit" > Contenu.txt
    git add Contenu.txt
    git commit -am "Commit #$commit"

    # Tag first and last commit for easy bisection
    if [[ $commit -eq 0 ]]; then
        git tag first_good
    elif [[ $commit -eq $(( num_commits - 1 )) ]]; then
        git tag last_bad
    fi
done
cd ..
