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

2. [DRAFTING]:
   - PATH: Target `<WorkspaceRoot>/.agent/KANBAN/todo/`.
   - INFERENCE:
     - DERIVE content directly from the `<WorkspaceRoot>/.agent/MASTER_TASK.md` description.
     - ADAPT constraints based on task type.
   - EXECUTE:
     - STRATEGY:
       - 1. List all necessary steps in logical dependency order.
       - 2. Assign IDs (01, 02...) preserving this exact order.
       - 3. Assign flat Priority (e.g., HIGH) to sequential blocks.
     - GENERATE: Create markdown tasks based on the strategy.
     - NAMING: `[TOPIC]-[ID]-[TYPE]-[SLUG].md`
       - Format:
         - TOPIC: 3-4 chars grouping code (e.g., AUTH, UI, API).
         - ID: Sequential number (01, 02...). Must reflect dependency order.
         - TYPE: FEAT, FIX, REFACTOR, DOCS, RESEARCH, REVERSE.
         - SLUG: Short description usually 2-3 words.
       - Example: `AUTH-01-RESE-jwt_options.md`
     - FORMAT: Use this minimalist template:
       - `# [Task Title]` (Header)
       - `**Priority:** [CRITICAL|HIGH|MEDIUM|LOW]`
       - `## Objective`
       - `## Execution Plan`
       - `## Definition of Done`
   - CONSTRAINT:
     - Scope: Max 80 lines per file. (Append `<!-- OV: LINES -->` to bypass if strictly necessary).
     - Keep scope atomic (one deliverable per task).
     - Complexity: Max 5 Checkpoints per task.
     - DELIVERABLES: IF task type is [RESEARCH|REVERSE], output MUST be saved in `<WorkspaceRoot>/REPORTS/`.

3. [VALIDATION]:
   - EXECUTE: `<WorkspaceRoot>/.agent/scripts/planner/validate_tasks.sh`
   - EXPECT: EXIT_CODE == 0.
   - FAILURE_HANDLER:
     - IF EXIT 1: Read the script output.
     - ACTION: Edit the failed tasks to fix the reported issues.
   - RETRY: Run validation again.

4. [STOP_AND_REPORT]:
   - NOTIFY: "Planning complete. [N] tasks created/updated. Please review `KANBAN/todo/` before running `/run_agent`."
   - STOP: Do not proceed to execution. Wait for user command.
