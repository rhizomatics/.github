# Repo admin workflows

Shared GitHub admin automation for rhizomatics repos.

| Caller (in each repo) | Reusable workflow (here) | What it does |
|---|---|---|
| `admin-auto-assign.yml` | `reusable-auto-assign.yml` | Assigns new/reopened issues and PRs (including fork PRs) to `jeyrb` |
| `admin-labels.yml` | `reusable-labels.yml` | Weekly sync of [`/labels.yml`](../labels.yml) into the repo; repo-only labels are kept |
| `admin-dependency-review.yml` | `reusable-dependency-review.yml` | Flags known-vulnerable dependencies on PRs, commenting only when it fails |
| `admin-dependabot-automerge.yml` | `reusable-dependabot-automerge.yml` | Squash-merges Dependabot PRs touching only trusted deps (`TRUSTED` regex: astral's uv, ruff, ty, `astral-sh/*` actions) once every other check passes |

Callers pin the reusable workflows to a release tag's commit SHA (`@<sha> # 1.0.0`), so a
change to a reusable workflow reaches a repo only when its pin moves. To release one, tag this
repo (immutable release), update the pins in `templates/workflows/`, and run `sync-admin.sh`;
Dependabot also proposes the bump in each repo. `labels.yml` is still read from `main` at run
time, so label changes take effect everywhere on the next run.

## Adding or updating repos

```sh
scripts/sync-admin.sh --check   # list rhizomatics repos under ~/Projects that are out of date
scripts/sync-admin.sh           # copy callers in, remove the per-repo workflows they replace
```

Then commit in each repo.

## Shared mise tasks

`sync-admin.sh` copies [mise file tasks](https://mise.jdx.dev/tasks/file-tasks.html) into each
repo's `.mise/tasks/`, replacing the old `refresh-deps.sh` (which it removes):

| Repos | Task | What it does |
|---|---|---|
| Python (`uv.lock`) | `mise run refresh` | Upgrades mise tools, pulls bot PRs, re-locks and syncs with `uv`, runs `prek autoupdate --cooldown-days 7` |
| Python (`uv.lock`) | `mise run clean` | Removes build, test and lint caches and recreates an empty `.venv` |
| Node (`package-lock.json`) | `mise run refresh` | Pulls bot PRs, runs `prek autoupdate --cooldown-days 7`, upgrades mise tools, runs `npm update` |
| Node (`package-lock.json`) | `.npmrc` (not a task) | `min-release-age=7`, so `npm install`/`npm update` skip versions under 7 days old; `@rhizomatics/*` is exempt |

The Python `refresh` hides the user-level `~/.config/uv/uv.toml` from `uv` (`XDG_CONFIG_HOME=/dev/null`)
so personal settings never reach a committed `uv.lock`, while the project's own `[tool.uv]` still applies.

A file task shadows a `mise.toml` task of the same name, so a repo that needs its own version
(supernotify's `clean` also tears down its Docker preview) defines it in `mise.toml`, and
`sync-admin.sh` then leaves the shared one out.

## Cooldowns

Every automatic update waits 7 days after a release (`policies/project_standards.md` in
`rhizomatics/hq`), so a compromised or broken release has time to be pulled first:

| Updater | Where the cooldown lives |
|---|---|
| Dependabot | `cooldown: default-days: 7` on each ecosystem |
| uv | `exclude-newer = "7 days"` in `[tool.uv]`; per-package exceptions in `exclude-newer-package` |
| npm | shared `.npmrc` (`min-release-age=7`) |
| prek hooks | `prek autoupdate --cooldown-days 7` in the shared `refresh` task |

Own packages may go to 0 days, and trusted, widely used ones (Home Assistant, astral) to 2.
Repos use `prek` (from `mise.toml`) rather than `pre-commit`; it reads the same
`.pre-commit-config.yaml`.

## Dependabot

`dependabot.yml` can't be shared, so each repo has its own with a common shape per ecosystem:

- **Version updates** on the 1st and 15th of the month (Dependabot has no fortnightly interval),
  7-day cooldown. Minor+patch bumps are grouped into one PR per ecosystem; majors come separately.
- **astral** group (uv, ruff, ty, `astral-sh/*` actions) in Python and Actions ecosystems, so trusted
  updates arrive in their own PR and can be auto-merged. Keep it in step with `TRUSTED`.
- **Security updates** are raised as soon as an alert opens, grouped into one PR per ecosystem.
- **Minimum versions stay put**: pip, uv and npm entries set `versioning-strategy:
  increase-if-necessary`, so Dependabot updates the lock file and only raises a lower bound when
  a new release falls outside the declared range. Floors are a support decision: 6 months of Home
  Assistant for integrations, Python 3.13-3.15 for PyPI packages.
- The Home Assistant integrations only update direct pip deps, since their transitive deps are
  pinned by homeassistant. The same `allow` rule keeps security PRs to direct deps too.
