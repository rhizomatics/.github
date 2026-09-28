#!/usr/bin/env bash
# Copy the admin workflow callers in templates/workflows into every rhizomatics repo
# checked out under a root directory (default ~/Projects), and remove the per-repo
# workflows and label files they replace. Only touches working trees; review and commit
# in each repo afterwards.
#
#   scripts/sync-admin.sh [--check] [root]
#
# --check reports repos that are out of date and exits non-zero, changing nothing.
set -euo pipefail

here=$(cd "$(dirname "$0")/.." && pwd)
check=false
[[ ${1:-} == --check ]] && { check=true; shift; }
root=${1:-$HOME/Projects}

legacy=(
  .github/workflows/auto_assign_issue.yml
  .github/workflows/auto_assign_pr.yml
  .github/workflows/auto-assign.yml
  .github/workflows/labeller.yml
  .github/workflows/dependency-review.yml
  .github/labels.yml
)

stale=0
while IFS= read -r gitdir; do
  repo=$(dirname "$gitdir")
  url=$(git -C "$repo" remote get-url origin 2>/dev/null || true)
  [[ $url =~ github\.com[:/]rhizomatics/ ]] || continue

  changes=()
  for tpl in "$here"/templates/workflows/*.yml; do
    dest=$repo/.github/workflows/$(basename "$tpl")
    cmp -s "$tpl" "$dest" && continue
    changes+=("update $(basename "$tpl")")
    $check || { mkdir -p "$(dirname "$dest")"; cp "$tpl" "$dest"; }
  done
  # The .github repo holds the shared labels.yml at its root, so .github/labels.yml is still legacy there.
  for f in "${legacy[@]}"; do
    [[ -e $repo/$f ]] || continue
    changes+=("remove $f")
    $check || rm "$repo/$f"
  done

  if ((${#changes[@]})); then
    stale=1
    echo "${repo#"$root"/}:"
    printf '  %s\n' "${changes[@]}"
  fi
done < <(find "$root" -maxdepth 4 -name .git -type d -prune | sort)

if $check && ((stale)); then exit 1; fi
