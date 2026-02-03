---
description: Planner tool to transform goals into actionable tasks in the Kanban.
---

// turbo-all

# PLANNING_PROTOCOL

**OBJECTIVE**: Translate `<WorkspaceRoot>/.agent/MASTER_TASK.md` into granular tasks without executing them.

1. [DISCOVERY]:
   - LOCATE: Identify the Workspace Root.
   - READ: `<WorkspaceRoot>/.agent/MASTER_TASK.md`
   - VALIDATE: Check if there are instructions or context to work with.
   - CRITICAL CHECK:
     - IF Invalid: STOP EXECUTION IMMEDIATELY. Notify user and wait for input.
     - ELSE: Proceed to drafting.
   - EXPECT: Clear understanding of the current "Active Order".
