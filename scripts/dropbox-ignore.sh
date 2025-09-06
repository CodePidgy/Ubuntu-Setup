#!/bin/bash

DROPBOX_DIR="$HOME/Dropbox/Aidan"

# Add ignore attribute to path
add() {
    local target_path="$1"

    if [[ -z "$target_path" ]]; then
        echo "[ERROR] Usage: add <path>" >&2
        return 1
    fi

    if [[ ! -e "$target_path" ]]; then
        echo "[ERROR] Path not found: $target_path" >&2
        return 1
    fi

    if attr -g com.dropbox.ignored "$target_path" >/dev/null 2>&1; then
        echo "[INFO] Skipped: $target_path" >&2
        return 0
    fi

    if attr -s com.dropbox.ignored -V 1 "$target_path" >/dev/null 2>&1; then
        echo "[SUCCESS] Added: $target_path" >&2
    else
        echo "[ERROR] Failed: $target_path" >&2
        return 1
    fi
}

# Remove ignore attribute from path
remove() {
    local target_path="$1"

    if [[ -z "$target_path" ]]; then
        echo "[ERROR] Usage: remove <path>" >&2
        return 1
    fi

    if [[ ! -e "$target_path" ]]; then
        echo "[ERROR] Path not found: $target_path" >&2
        return 1
    fi

    if ! attr -g com.dropbox.ignored "$target_path" >/dev/null 2>&1; then
        echo "[INFO] Skipped: $target_path" >&2
        return 0
    fi

    if attr -r com.dropbox.ignored "$target_path" >/dev/null 2>&1; then
        echo "[SUCCESS] Removed: $target_path" >&2
    else
        echo "[ERROR] Failed: $target_path" >&2
        return 1
    fi
}

# Common function to scan Dropbox for ignore attributes
scan() {
    local root_dir="$1"

    if [[ -z "$root_dir" ]]; then
        root_dir="$DROPBOX_DIR"
    fi

    local total_count
    total_count=$(find "$root_dir" -type f -o -type d | wc -l)

    local checked_count=0
    local skipped_count=0
    local last_reported_percentage=0
    local progress_check_interval=100
    local found_paths=()

    # Recursive function that skips ignored directories
    scan_path() {
        local current_path="$1"

        # Check if current path has ignore attribute
        if attr -g com.dropbox.ignored "$current_path" >/dev/null 2>&1; then
            found_paths+=("$current_path")

            # If it's a directory, skip scanning its contents
            if [[ -d "$current_path" ]]; then
                local dir_contents
                dir_contents=$(find "$current_path" -mindepth 1 | wc -l)
                skipped_count=$((skipped_count + dir_contents))
            fi
            return
        fi

        ((checked_count++))

        # Progress indicator with percentage - check every N items to reduce overhead
        if (( checked_count % progress_check_interval == 0 )); then
            local total_processed=$((checked_count + skipped_count + ${#found_paths[@]}))
            local current_percentage=$(( total_processed * 100 / total_count ))
            if (( current_percentage > last_reported_percentage )); then
                echo "[INFO] P: $total_processed/$total_count ($current_percentage%) | C: $checked_count | F: ${#found_paths[@]} | S: $skipped_count" >&2
                last_reported_percentage=$current_percentage
            fi
        fi

        # If it's a directory and not ignored, scan its immediate contents
        if [[ -d "$current_path" ]]; then
            local item
            while IFS= read -r item; do
                [[ -n "$item" ]] && scan_path "$item"
            done < <(find "$current_path" -mindepth 1 -maxdepth 1 2>/dev/null)
        fi
    }

    # Start scanning from the root directory
    scan_path "$root_dir"

    echo "[SUCCESS] C: $checked_count | F: ${#found_paths[@]} | S: $skipped_count" >&2
    echo >&2

    # Display list of found paths at the end
    if [[ ${#found_paths[@]} -gt 0 ]]; then
        for path in "${found_paths[@]}"; do
            echo "$path"
        done
    fi
}

# Reset ignore attributes
reset() {
    local target_dir="$1"
    local reset_count=0
    local error_count=0
    local total_paths=0
    local paths_to_reset=()

    # Determine input source and read paths
    if [[ ! -t 0 ]]; then
        echo "[INFO] Reading paths from input..." >&2
        readarray -t paths_to_reset
    elif [[ -n "$target_dir" ]]; then
        echo "[INFO] Scanning directory: $target_dir" >&2
        readarray -t paths_to_reset < <(scan "$target_dir")
    else
        echo "[INFO] Scanning from root..." >&2
        readarray -t paths_to_reset < <(scan)
    fi

    total_paths=${#paths_to_reset[@]}

    if [[ $total_paths -eq 0 ]]; then
        echo "[INFO] No ignored paths found to reset" >&2
        return 0
    fi

    echo "[INFO] Removing attributes from $total_paths paths..." >&2

    for path in "${paths_to_reset[@]}"; do
        ((reset_count++))

        if attr -r com.dropbox.ignored "$path" >/dev/null 2>&1; then
            echo "[INFO] Removed: $path" >&2
        else
            ((error_count++))
            echo "[ERROR] Failed: $path" >&2
        fi
    done

    echo "[SUCCESS] Removed: $((reset_count - error_count))/$total_paths | Errors: $error_count" >&2
}

# Apply patterns from .dropbox-ignore file
apply() {
    local ignore_file="$1"
    local dry_run="$2"

    if [[ -z "$ignore_file" ]]; then
        echo "[ERROR] Usage: apply [--dry] <path-to-.dropbox-ignore>" >&2
        return 1
    fi

    [[ "$dry_run" == "true" ]] && echo "[DRY RUN] Preview mode - no changes will be made" >&2

    if [[ ! -f "$ignore_file" ]]; then
        echo "[ERROR] .dropbox-ignore file not found: $ignore_file" >&2
        return 1
    fi

    # Always use directory containing the .dropbox-ignore file as base
    local base_dir="$(dirname "$ignore_file")"

    if [[ ! -d "$base_dir" ]]; then
        echo "[ERROR] Base directory not found: $base_dir" >&2
        return 1
    fi

    local pattern_count=0
    local applied_count=0
    local already_ignored_count=0
    local error_count=0
    local total_patterns
    total_patterns=$(grep -c '^[^#]' "$ignore_file" 2>/dev/null || echo 0)

    if [[ $total_patterns -eq 0 ]]; then
        echo "[INFO] No patterns found in .dropbox-ignore file" >&2
        return 0
    fi

    # Helper function to process patterns and apply ignore attributes
    process_pattern() {
        local pattern="$1"
        local is_directory="$2"
        local dry_run="$3"
        local matched_paths=()
        local pattern_applied=0
        local pattern_already_ignored=0

        if [[ "$is_directory" == "true" ]]; then
            # Directory pattern - remove trailing slash for find
            local dir_pattern="${pattern%/}"

            # Build find command with pruning for already-ignored directories
            local find_cmd="find \"$base_dir\""

            # Add exclusions for ignored directories
            for ignored_dir in "${ignored_dirs[@]}"; do
                find_cmd+=" -path \"$ignored_dir\" -prune -o"
            done

            # Add the directory search
            find_cmd+=" -type d -name \"$dir_pattern\" -print0"

            # Find all matching directories and sort by path length (shallowest first)
            local all_matches=()
            while IFS= read -r -d '' path; do
                all_matches+=("$path")
            done < <(eval "$find_cmd" 2>/dev/null)

            # Sort by path length to process parent directories first
            IFS=$'\n' sorted_matches=($(printf '%s\n' "${all_matches[@]}" | awk '{print length($0) " " $0}' | sort -n | cut -d' ' -f2-))

            # Build matched_paths hierarchically - only include directories that aren't inside other matched directories
            for path in "${sorted_matches[@]}"; do
                local inside_matched=false
                for matched_dir in "${matched_paths[@]}"; do
                    if [[ "$path" == "$matched_dir"/* ]]; then
                        inside_matched=true
                        break
                    fi
                done

                # Only include paths that aren't inside already-matched directories
                if [[ "$inside_matched" == false ]]; then
                    matched_paths+=("$path")
                fi
            done
        else
            # File pattern - build find command with pruning for ignored directories
            local find_cmd="find \"$base_dir\""

            # Add exclusions for ignored directories
            for ignored_dir in "${ignored_dirs[@]}"; do
                find_cmd+=" -path \"$ignored_dir\" -prune -o"
            done

            # Handle patterns with path separators (like dist/*.js)
            if [[ "$pattern" == */* ]]; then
                # Complex pattern with path
                find_cmd+=" -type f -path \"*/$pattern\" -print0"
            else
                # Simple filename pattern
                find_cmd+=" -type f -name \"$pattern\" -print0"
            fi

            # Execute find command and collect results
            while IFS= read -r -d '' path; do
                matched_paths+=("$path")
            done < <(eval "$find_cmd" 2>/dev/null)
        fi

        # Apply ignore attribute to all matched paths
        for path in "${matched_paths[@]}"; do
            if [[ "$dry_run" == "true" ]]; then
                # Dry-run mode: check current state but don't modify
                if attr -g com.dropbox.ignored "$path" >/dev/null 2>&1; then
                    echo "[DRY] Skipped: $path" >&2
                    ((already_ignored_count++))
                    ((pattern_already_ignored++))
                else
                    echo "[DRY] Applied: $path" >&2
                    ((applied_count++))
                    ((pattern_applied++))
                fi

                # In dry-run, always add to ignored_dirs for proper pruning simulation
                if [[ "$is_directory" == "true" ]]; then
                    ignored_dirs+=("$path")
                fi
            else
                # Normal mode: actually apply changes
                if attr -g com.dropbox.ignored "$path" >/dev/null 2>&1; then
                    echo "[INFO] Skipped: $path" >&2
                    if [[ "$is_directory" == "true" ]]; then
                        ignored_dirs+=("$path")
                    fi
                    ((already_ignored_count++))
                    ((pattern_already_ignored++))
                elif attr -s com.dropbox.ignored -V 1 "$path" >/dev/null 2>&1; then
                    echo "[INFO] Applied: $path" >&2
                    if [[ "$is_directory" == "true" ]]; then
                        ignored_dirs+=("$path")
                    fi
                    ((applied_count++))
                    ((pattern_applied++))
                else
                    echo "[ERROR] Failed: $path" >&2
                    ((error_count++))
                fi
            fi
        done

        echo "[SUCCESS] '$pattern': Matched ${#matched_paths[@]} | A:$pattern_applied S:$pattern_already_ignored" >&2
        echo >&2
    }

    # Process all patterns in one loop
    local ignored_dirs=()
    local dir_count=0

    while IFS= read -r pattern; do
        # Clean pattern: strip BOM and carriage returns
        pattern=$(echo "$pattern" | sed 's/^\xEF\xBB\xBF//' | tr -d '\r')

        # Skip comments and empty lines
        [[ "$pattern" =~ ^[[:space:]]*# ]] && continue
        [[ "$pattern" =~ ^[[:space:]]*$ ]] && continue

        ((pattern_count++))
        echo "[INFO] ($pattern_count/$total_patterns): '$pattern'" >&2

        # Determine if it's a directory pattern and process
        if [[ "$pattern" == */ ]]; then
            ((dir_count++))
            [[ $dir_count -eq 1 ]] && echo "[INFO] Phase 1: Directory patterns" >&2
            process_pattern "$pattern" "true" "$dry_run"
        else
            [[ $dir_count -gt 0 && $((pattern_count - dir_count)) -eq 1 ]] && echo "[INFO] Phase 2: File patterns" >&2
            process_pattern "$pattern" "false" "$dry_run"
        fi
    done < "$ignore_file"

    if [[ "$dry_run" == "true" ]]; then
        echo "[DRY RUN] Patterns: $pattern_count | Would apply: $applied_count | Already ignored: $already_ignored_count | Errors: $error_count" >&2
    else
        echo "[SUCCESS] Patterns: $pattern_count | Applied: $applied_count | Skipped: $already_ignored_count | Errors: $error_count" >&2
    fi
}

# Main script logic
case "$1" in
    "add")
        add "$2"
        ;;
    "remove")
        remove "$2"
        ;;
    "scan")
        scan "$2"
        ;;
    "reset")
        reset "$2"
        ;;
    "apply")
        if [[ "$2" == "--dry" ]]; then
            apply "$3" "true"
        else
            apply "$2" "false"
        fi
        ;;
    "--dry")
        if [[ "$2" == "apply" ]]; then
            apply "$3" "true"
        else
            echo "[ERROR] --dry flag only supported with apply command" >&2
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 [scan|reset|add|remove|apply]"
        echo "  add <path>              Add ignore attribute to path"
        echo "  remove <path>           Remove ignore attribute from path"
        echo "  scan [dir]              Scan for ignored files/directories"
        echo "  reset [dir]             Remove ignore attributes"
        echo "  apply <ignore-file>     Apply patterns from .dropbox-ignore"
        echo "  apply --dry <file>      Preview apply without making changes"
        echo ""
        echo "Examples:"
        echo "  $0 add ./node_modules            # Ignore specific folder"
        echo "  $0 remove ./dist                 # Un-ignore specific folder"
        echo "  $0 scan                          # Scan Dropbox"
        echo "  $0 scan /project                 # Scan specific directory"
        echo "  $0 scan | $0 reset               # Pipe results to reset"
        echo "  $0 apply /project/.dropbox-ignore # Apply patterns"
        echo "  $0 apply --dry /project/.dropbox-ignore # Preview changes"
        exit 1
        ;;
esac
