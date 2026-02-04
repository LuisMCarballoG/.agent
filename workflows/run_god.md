---
description: GOD_MODE: Creation Ex Nihilo. Transform intention into reality.
---

# GOD_PROTOCOL

**OBJECTIVE**: Omnipotent execution. From `MASTER_TASK.md` to Final Product without human interruption.

1. [PLANNING_PHASE]:
   - INPUT: `<WorkspaceRoot>/.agent/MASTER_TASK.md`
   - EXECUTE: `/run_planning`
   - VALIDATE: Verify `<WorkspaceRoot>/.agent/scripts/planner/validate_tasks.sh` passes successfully.
     - ON_FAILURE: FIX. Read script output, correct the tasks in `KANBAN/todo/`, and RETRY validation. Loop until success.
     - CRITICAL_STOP: Only stop if human intervention is strictly required (e.g., missing secrets).

2. [EXECUTION_PHASE]:
   - TRIGGER: Automatic transition upon Planning success.
   - EXECUTE: `/run_agent`
   - MONITOR: The agent will now run autonomously until session completion.

3. [MISSION_COMPLETE]:
   - VERIFY: `<WorkspaceRoot>/.agent/scripts/executor/session_complete.sh`
   - NOTIFY: "Mission Accomplished. All tasks done. Ready for final review."
