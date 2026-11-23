---
name: review-candidates
description: Review candidates in Flowmingo. Use when the user asks how a job or hiring project is going, who the best candidates are, what an AI interview or test said about someone, or wants candidates compared or summarised.
---

Use the Flowmingo connector's read tools. They never change anything, so there is nothing to confirm.

1. **Find the job.** If the user names a job or project, find its id with `list_projects` or `list_job_posts`; two can
   share a title, so if more than one matches, ask which. If they name none, say which open jobs exist and ask, unless the
   question is about all of them.
2. **Get the numbers.** If the connector offers `ask_data`, ask it the question in plain words and put the id in it
   ("How many candidates finished the AI interview for project <id> this week?"). Quote its numbers exactly and say what
   was counted. If it says the answer is exploratory, say so; if it could not check, say that, never zero. Without
   `ask_data`, use `hiring_overview` for the funnel and `list_pipeline` for who is at which stage.
3. **Find the strongest candidates.** Use `top_candidates` when it is offered, or `list_results` filtered by the
   assessment, and read the best few with `get_result_detail` for the AI summary and per-competency ratings.
4. **Compare** two to ten people with `compare_candidates` when it is offered; otherwise put their result details side by
   side yourself.
5. **Report.** For each candidate give the assessment kind (`assessment_type`), the score on its own scale (a Skill Test is
   a percentage, a showcase or questionnaire has no AI score), and one or two lines from the evaluation on why. Use the
   candidate's name from `get_candidate` only when the user needs it. Don't paste raw tool output.

End with what the user might do next (invite, shortlist, move a stage), and leave doing it to the act-on-candidates skill.
