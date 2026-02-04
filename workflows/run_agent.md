---
description: Agentic IDE will execute tasks sequentially with maximum autonomy.
---

// turbo-all

# EXECUTION_PROTOCOL

**STRICT_AUTONOMY**: Proceed without user confirmation until Step 5 [COMPLETION].

1. [DISCOVERY]:
   - LOCATE: Identify the `<WorkspaceRoot>`.

2. [GATE]: Execute `<WorkspaceRoot>/.agent/scripts/executor/preflight.sh`
   - EXPECT: EXIT_CODE == 0
   - ON_ERROR: STOP_AND_REPORT

3. [LOOP_INIT]:
   - RUN: TASK=$(<WorkspaceRoot>/.agent/scripts/executor/next_task.sh)
   - IF_EMPTY: Jump to Step 5.

4. [TASK_EXECUTION]:
   - READ: File path in $TASK.
   - ACTION: Implement, debug, and test locally.
   - COMPLETION: Move task to `<WorkspaceRoot>/.agent/KANBAN/done/`.
   - REPEAT: Jump to Step 3.

5. [COMPLETION]:
   - VALIDATE: `<WorkspaceRoot>/.agent/scripts/executor/session_complete.sh`
     - EXPECT: EXIT_CODE == 0
     - ON_ERROR: RESTART Loop. (Inconsistency detected: Tasks remaining. Go to Step 3).
   - NOTIFY: "Protocol complete. All tasks processed."

---

## ⛔ Anti-Patterns (FORBIDDEN)

| Anti-Pattern                                | Why it is Wrong                | Correct Action                                      |
| ------------------------------------------- | ------------------------------ | --------------------------------------------------- |
| **"Completed critical tasks"**              | Partial completion is failure. | **MUST** empty the TODO list completely.            |
| **"Do you want me to continue?"**           | Violates STRICT_AUTONOMY.      | **IMMEDIATELY** jump to Step 3 (LOOP).              |
| **"Session Complete" (with files in TODO)** | False positive / Laziness.     | Run `session_complete.sh` to verify truth.          |
| **"Pausing for feedback"**                  | Interrupts the flow.           | Continue working until `TODO` + `IN_PROGRESS` == 0. |
