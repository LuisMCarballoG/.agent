#!/bin/bash
set -euo pipefail
# session_complete.sh
# -----------------------------------------------------------------------------
# Binary gate to declare "Session Complete" or "Keep Working".
# -----------------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"
KANBAN_ROOT="$PROJECT_ROOT/KANBAN"

todo_count=$(find "$KANBAN_ROOT/todo" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
in_progress_count=$(find "$KANBAN_ROOT/in_progress" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)

if [ "$todo_count" -eq 0 ] && [ "$in_progress_count" -eq 0 ]; then
    echo "SESSION STATUS: COMPLETE (All tasks done)."
    exit 0
else
    echo "SESSION STATUS: INCOMPLETE ($in_progress_count In Progress, $todo_count Todo)."
    exit 1
fi
