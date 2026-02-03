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

