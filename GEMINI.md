# Flowmingo

The `flowmingo` MCP server reads and acts on the user's Flowmingo hiring data: job posts, hiring projects, assessments
(AI interviews, role-plays, Skill Tests, Technical Tests, CV evaluations, showcases), candidates and results.

- Sign-in: the first call opens a Flowmingo page in the browser where the user pastes their Flowmingo API key
  (`/mcp auth flowmingo` starts it again).
- Every result has an `assessment_type`. Name the kind when reporting, and only call a score an interview rating when the
  kind is an AI interview or a role-play.
- Invites, rejects, removals and moves into a stage that emails the candidate are not done by the tool: it returns an
  approval link that a person must open, signed in to Flowmingo. Give the user that link and say the change is waiting;
  check `change_status` before saying it happened.
- Notes, ratings, shortlist marks, tags and quiet stage moves are previewed first (`confirm: false`); repeat the call with
  `confirm: true` only after the user agrees. Each returns an undo reference usable with `undo_change` for 24 hours.
