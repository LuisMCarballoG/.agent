# Antigravity Empower+

**Cognitive Governance & Orchestration Suite**

An agnostic framework designed to structure, validate, and empower autonomous agent reasoning. We transform chaotic execution into deterministic workflows via 'policy-as-code', enabling scalable cognitive operations across any complex domain—from academic research to enterprise software orchestration

---

## 🚀 Quick Start

1. Define the macro mission in `MASTER_TASK.md`.
2. Execute `/run_planning` to generate micro tasks to be executed by the agent.
3. Do visual inspection of the tasks in `KANBAN/todo/`, if something is wrong you can adjust the micro task manually or update `MASTER_TASK.md` and run `/run_planning` again.

## 🏗️ System Structure

```text
./
├── README.md
├── MASTER_TASK.md              # Your macro mission for the agent.
│
├── KANBAN/
│   ├── todo/                   # Tasks ready for the engine.
│   ├── in_progress/            # What the agent is doing NOW.
│   └── done/                   # History of completed deliveries.
│
├── REPORTS/                    # Final results for research tasks.
│
│
├── scripts/
│   ├── planner/
│   |   └── validate_tasks.sh   # Validates KANBAN tasks against strict project standards.
|   |
│   └── executor/
│       └── preflight.sh        # Validate existing tasks before starting.
│
└── workflows/                  # Slash Commands (Action protocols)
    ├── run_planning.md         # Generates tasks from MASTER_TASK.md
    └── run_agent.md            # Sequential autonomous execution.
```

---

## 📜 Golden Rules

| Rule                      | Description                                                                                                       |
| :------------------------ | :---------------------------------------------------------------------------------------------------------------- |
| **🎯 MASTER_TASK First**  | Everything starts from a human intention in this file. No hidden tasks.                                           |
| **📂 Naming Conventions** | `KANBAN`, `REPORTS` (Uppercase) → **Human Domain**. <br> `scripts`, `workflows` (Lowercase) → **Machine Domain**. |

---
