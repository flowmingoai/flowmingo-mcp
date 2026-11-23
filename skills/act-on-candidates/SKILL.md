---
name: act-on-candidates
description: Act on candidates in Flowmingo. Use when the user wants to invite candidates to an AI interview or test, move them to another stage, reject or remove them, or add a note, a rating, a shortlist mark or a tag.
---

Flowmingo splits actions in two. Follow the rule for each and report exactly what happened.

**Changes that a person approves at a Flowmingo link** (`invite_candidates`, `reject_application`, `remove_application`,
and `move_application_stage` into a stage that emails the candidate):

1. Make sure of the ids: the assessment from `list_interview_sets` (an invite can send an AI interview, a role-play, a
   Skill Test or a Technical Test), the applications from `list_pipeline`, the target stage from `list_stages`.
2. Call the tool once for the whole group (at most 50 per call). It sends nothing: it returns an approval link.
3. Give the user the approval link and say the change is waiting for a person to approve it, signed in to Flowmingo. You
   cannot approve it, and the user saying yes in the chat does not approve it.
4. Before saying an invite was sent or a candidate was rejected, check with `change_status`. A change can be pending,
   executed, failed, expired or cancelled; say which. `cancel_change` withdraws one that still waits.

**Small reversible changes** (`add_candidate_note`, `rate_candidate`, `shortlist_candidate`, `tag_candidate`, and a
`move_application_stage` into a stage that emails nobody):

1. Call the tool without `confirm` first: it returns a preview. Show the user what will change.
2. Only after the user agrees, call it again with `confirm: true`.
3. Each answer carries an undo reference; `undo_change` puts it back within 24 hours unless someone changed the same thing
   since.

Never say an email went out unless `change_status` says the change executed and its outcome says the candidate was emailed.
