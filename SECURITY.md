# Security Policy

This is the default security policy for every repository in the
[rhizomatics](https://github.com/rhizomatics) organisation that doesn't have its own `SECURITY.md`.

## Supported versions

Only the latest release of each project gets security fixes. Upgrade before reporting, if you can.

## Reporting a vulnerability

Please report it privately. Don't open a public issue, discussion or pull request.

1. Go to the **Security** tab of the affected repository.
2. Choose **Report a vulnerability**.

This opens a private advisory that only you and the maintainer can see. Include what you can of:

- the affected version, and the configuration needed to reproduce it
- steps to reproduce, or a proof of concept
- the impact as you see it

## Platform issues

Vulnerabilities in Home Assistant, SignalK server, Node.js or Python themselves belong with those
projects. Report them here only if a Rhizomatics project uses the affected feature in a way that
makes it worse.

## What to expect

Rhizomatics is run by one volunteer maintainer, so replies are not immediate, but every private
report is read. Fixes are released as a new version, credited to you in the advisory unless you'd
rather not be named.
