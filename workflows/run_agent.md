---
description: Agentic IDE will execute tasks sequentially with maximum autonomy.
---

// turbo-all

# EXECUTION_PROTOCOL

1. [DISCOVERY]:
   - LOCATE: Identify the `<WorkspaceRoot>`.

2. [GATE]: Execute `<WorkspaceRoot>/.agent/scripts/executor/preflight.sh`
   - EXPECT: EXIT_CODE == 0
   - ON_ERROR: STOP_AND_REPORT

3. [LOOP_INIT]:
   - RUN: TASK=$(<WorkspaceRoot>/.agent/scripts/executor/next_task.sh)

4. [TASK_EXECUTION]:
   - READ: File path in $TASK.
   - ACTION: Implement, debug, and test locally.
   - COMPLETION: Move task to `<WorkspaceRoot>/.agent/KANBAN/done/`.
   - REPEAT: Jump to Step 3.
