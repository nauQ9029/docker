# docker
from 0 to hero docker

## Prefix Summary
|          Scope          |          Prefix          |          Purpose          |
----------------------------------------------------------------------------------
1. 0 to hero               tuto/ (tutorial)           Following tutorials, reading docs, writing README cheat-sheets
                      
2. pratice apps            lab/                       Self-contained, isolated mini-apps to practice specific ideas

3. real features           feat/                      Specific Docker capabilities added to your main app, ready to merge

## Workflow

(tuto/03-env-vars) ─── Tutorial notes & scratchpad
       /
main ───────────────────────────────────────────────────► [Fully Built Docker Stack]
       \                                       ▲
        (lab/todo-node-mongo) ── Isolated practice   │
                                               │
        (feat/env-and-args) ───────────────────┘ (PR / Merge when complete)

1. **Tutorial Stage (tuto/*)**: Use this branch to try commands, break things, and add notes or README.md summaries. You don't need to merge these into main unless you want to keep tutorial docs there.

2. **Practice Sandbox (lab/*)**: Build quick, disposable mini-apps (like your simple Todo app). Keep them in their own branch or in a labs/ folder.

3. **Feature Build & Merge (feat/*)**:
- Branch off main: git checkout -b feat/env-and-build-args
- Add .env parsing, Docker ARG, and ENV configurations to your Node.js + MongoDB setup.
- Verify it works, then merge it back into main.