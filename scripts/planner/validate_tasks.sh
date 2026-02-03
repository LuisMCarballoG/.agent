#!/bin/bash
# validate_tasks.sh
# -----------------------------------------------------------------------------
# Validates KANBAN tasks against strict project standards.
# -----------------------------------------------------------------------------

# --- CONFIGURATION ---

KANBAN_DIR=".agent/KANBAN/todo"
MAX_LINES=80
NAMING_REGEX="^[A-Z]{2,5}-[0-9]{2,}-[A-Z]{3,}-[a-z0-9_]+\.md$"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# --- VALIDATORS ---

validate_naming() {
    local filename="$1"
    if ! [[ "$filename" =~ $NAMING_REGEX ]]; then
        echo "[BadName]"
        return 1
    fi
    return 0
}

validate_scope() {
    local filepath="$1"
    
    if grep -q "<!-- OV: LINES -->" "$filepath"; then
        return 0
    fi

    local lines
    lines=$(wc -l < "$filepath")
    
    if [ "$lines" -gt "$MAX_LINES" ]; then
        echo "[TooLong:${lines}L]"
        return 1
    fi
    return 0
}

validate_structure() {
    local filepath="$1"
    local errors=""
    
    grep -q "^# " "$filepath" || errors="${errors}[NoTitle]"
    grep -q "^## Objective" "$filepath" || errors="${errors}[NoObjective]"
    grep -q "^## Execution Plan" "$filepath" || errors="${errors}[NoExecPlan]"
    grep -q "^## Definition of Done" "$filepath" || errors="${errors}[NoDoD]"
    
    echo "$errors"
}

validate_integrity() {
    local filepath="$1"
    if ! grep -q "\- \[ \]" "$filepath"; then
        echo "[NoCheckboxes]"
        return 1
    fi
    return 0
}

# --- MAIN ---

main() {
    if [ ! -d "$KANBAN_DIR" ]; then 
        echo -e "${RED}Error: Directory $KANBAN_DIR not found.${NC}"
        exit 1
    fi

    local tasks=("$KANBAN_DIR"/*.md)
    if [ ! -e "${tasks[0]}" ]; then
        echo "No tasks found in TODO."
        exit 0
    fi

    local failure_count=0
    for task_path in "${tasks[@]}"; do
        [ -f "$task_path" ] || continue
        
        local filename
        filename=$(basename "$task_path")
        local file_issues=""

        file_issues+="$(validate_naming "$filename")"
        file_issues+="$(validate_scope "$task_path")"
        file_issues+="$(validate_structure "$task_path")"
        file_issues+="$(validate_integrity "$task_path")"

        if [ -n "$file_issues" ]; then
            echo -e "${RED}FAIL:${NC} $filename -> $file_issues"
            ((failure_count++))
        else
            if ! grep -q "VALIDATED: ✅" "$task_path"; then
                 echo "" >> "$task_path"
                 echo "VALIDATED: ✅" >> "$task_path"
            fi
        fi
    done

    if [ "$failure_count" -eq 0 ]; then
        echo -e "${GREEN}ALL VALID (${#tasks[@]} tasks)${NC}"
        exit 0
    else
        echo -e "${RED}Validation Failed: $failure_count tasks require attention.${NC}"
        exit 1
    fi
}

main "$@"
