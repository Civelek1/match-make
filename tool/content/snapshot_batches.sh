#!/bin/bash
# Snapshots each batch worktree (without touching its index) and pushes it to its own branch.
cd /home/user/match-make
declare -A B=( [a020a7418ce551f2e]=b1 [a88e1157cf4c458dd]=b2 [a784848f8e2c84fba]=b3 [afb171da45d626035]=b4 )
for id in "${!B[@]}"; do
  wt=.claude/worktrees/agent-$id; n=${B[$id]}
  [ -d "$wt" ] || continue
  tmp=$(mktemp)
  ( cd "$wt" && cp "$(git rev-parse --git-path index)" "$tmp" 2>/dev/null; \
    GIT_INDEX_FILE="$tmp" git add -A . && tree=$(GIT_INDEX_FILE="$tmp" git write-tree) && \
    commit=$(git commit-tree "$tree" -p HEAD -m "WIP snapshot: content batch ${n#b}" ) && \
    for i in 1 2 3 4; do git push -q -f origin "$commit:refs/heads/claude/projeyi-incele-12280x-$n" && break; sleep $((2**i)); done && \
    echo "$n -> $commit ($(git diff --stat HEAD $commit | tail -1))" )
  rm -f "$tmp"
done
