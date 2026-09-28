# Repo admin workflows

Shared GitHub admin automation for rhizomatics repos.

| Caller (in each repo) | Reusable workflow (here) | What it does |
|---|---|---|
| `admin-auto-assign.yml` | `reusable-auto-assign.yml` | Assigns new/reopened issues and PRs (including fork PRs) to `jeyrb` |
| `admin-labels.yml` | `reusable-labels.yml` | Weekly sync of [`/labels.yml`](../labels.yml) into the repo; repo-only labels are kept |
| `admin-dependency-review.yml` | `reusable-dependency-review.yml` | Flags known-vulnerable dependencies on PRs, commenting only when it fails |

Callers reference the reusable workflows at `@main`, so changing a reusable workflow or
`labels.yml` here takes effect everywhere on the next run.

## Adding or updating repos

```sh
scripts/sync-admin.sh --check   # list rhizomatics repos under ~/Projects that are out of date
scripts/sync-admin.sh           # copy callers in, remove the per-repo workflows they replace
```

Then commit in each repo.

## Dependabot

`dependabot.yml` can't be shared, so each repo has its own with a common shape:
`github-actions` weekly and grouped, each language ecosystem weekly with minor+patch
grouped, 7-day cooldown. The Home Assistant integrations keep direct-only pip updates
because their transitive deps are pinned by homeassistant.
