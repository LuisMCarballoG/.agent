#!/bin/bash
set -euo pipefail
# next_task.sh
# -----------------------------------------------------------------------------
# Enforce task selection by priority. No human bias.
# -----------------------------------------------------------------------------

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"
KANBAN_DIR="$PROJECT_ROOT/KANBAN"
TODO_DIR="$KANBAN_DIR/todo"
IN_PROGRESS_DIR="$KANBAN_DIR/in_progress"

CURRENT=$(find "$IN_PROGRESS_DIR" -maxdepth 1 -name "*.md" | head -n 1 || true)

if [ -n "$CURRENT" ]; then
  echo "$CURRENT"
  exit 0
fi

for prio in "CRITICAL" "HIGH" "MEDIUM" "LOW"; do
  NEXT=$(grep -l "^\*\*Priority:\*\* $prio" "$TODO_DIR"/*.md 2>/dev/null | sort | head -n 1 || true)
  
  if [ -n "$NEXT" ]; then
    FILENAME=$(basename "$NEXT")
    mv "$NEXT" "$IN_PROGRESS_DIR/$FILENAME"
    echo "$IN_PROGRESS_DIR/$FILENAME"
    exit 0
  fi
done

REMAINING=$(find "$TODO_DIR" -maxdepth 1 -name "*.md" | wc -l)

if [ "$REMAINING" -gt 0 ]; then
  NEXT=$(find "$TODO_DIR" -maxdepth 1 -name "*.md" | sort | head -n 1)
  FILENAME=$(basename "$NEXT")
  mv "$NEXT" "$IN_PROGRESS_DIR/$FILENAME"
  echo "$IN_PROGRESS_DIR/$FILENAME"
  exit 0
fi

exit 1
