# Repo admin workflows

Shared GitHub admin automation for rhizomatics repos.

| Caller (in each repo) | Reusable workflow (here) | What it does |
|---|---|---|
| `admin-auto-assign.yml` | `reusable-auto-assign.yml` | Assigns new/reopened issues and PRs (including fork PRs) to `jeyrb` |
| `admin-labels.yml` | `reusable-labels.yml` | Weekly sync of [`/labels.yml`](../labels.yml) into the repo; repo-only labels are kept |
| `admin-dependency-review.yml` | `reusable-dependency-review.yml` | Flags known-vulnerable dependencies on PRs, commenting only when it fails |
| `admin-dependabot-automerge.yml` | `reusable-dependabot-automerge.yml` | Squash-merges Dependabot PRs touching only trusted deps (`TRUSTED` regex: astral's uv, ruff, ty, `astral-sh/*` actions) once every other check passes |

Callers reference the reusable workflows at `@main`, so changing a reusable workflow or
`labels.yml` here takes effect everywhere on the next run.

## Adding or updating repos

```sh
scripts/sync-admin.sh --check   # list rhizomatics repos under ~/Projects that are out of date
scripts/sync-admin.sh           # copy callers in, remove the per-repo workflows they replace
```

Then commit in each repo.

## Dependabot

`dependabot.yml` can't be shared, so each repo has its own with a common shape per ecosystem:

- **Version updates** on the 1st and 15th of the month (Dependabot has no fortnightly interval),
  7-day cooldown. Minor+patch bumps are grouped into one PR per ecosystem; majors come separately.
- **astral** group (uv, ruff, ty, `astral-sh/*` actions) in Python and Actions ecosystems, so trusted
  updates arrive in their own PR and can be auto-merged. Keep it in step with `TRUSTED`.
- **Security updates** are raised as soon as an alert opens, grouped into one PR per ecosystem.
- The Home Assistant integrations only update direct pip deps, since their transitive deps are
  pinned by homeassistant. The same `allow` rule keeps security PRs to direct deps too.
