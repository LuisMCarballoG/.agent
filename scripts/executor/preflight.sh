#!/bin/bash
set -euo pipefail
# preflight.sh
# -----------------------------------------------------------------------------
# Checks: Kanban status report.
# -----------------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"
KANBAN_ROOT="$PROJECT_ROOT/KANBAN"

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

todo_count=$(find "$KANBAN_ROOT/todo" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
in_progress_count=$(find "$KANBAN_ROOT/in_progress" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)

echo "Tasks in TODO:       $todo_count"
echo "Tasks IN PROGRESS:   $in_progress_count"

if [ "$todo_count" -eq 0 ] && [ "$in_progress_count" -eq 0 ]; then
    echo -e "SYSTEM STATUS: ${YELLOW}IDLE (No tasks)${NC}"
    exit 1
fi

echo -e "SYSTEM STATUS: ${GREEN}READY${NC}"
exit 0
