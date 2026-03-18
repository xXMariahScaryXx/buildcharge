#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}"/lib/common.sh
[[ "$VERBOSE" == 1 ]] && set -x

MANIFEST_JSON="$1"
CONFIG_FILE="$2"
PACKAGE_DIR="$3"

require_arg "$MANIFEST_JSON" "manifest json"
require_arg "$CONFIG_FILE" "config file"
require_arg "$PACKAGE_DIR" "package directory"

# PROJECT_DIR is passed to us by the Makefile
source "${PROJECT_DIR}/scripts/lib/generated/config.sh"

main() {
  [[ "$CONFIG_PACKAGES" != "y" ]] && echo "pkg not enabled" && exit 0

  echo "-- We're about to start building packages! If you want to quit now, press CTRL+C to cancel the build flow, otherwise Press Enter to Continue... --"
  read -r

  jq -c '.[]' "$MANIFEST_JSON" | while IFS= read -r package_json; do
    package_name=$(echo "$package_json" | jq -r '.name')
    package_package_name=$(echo "$package_json" | jq -r '.package_name')
    package_author=$(echo "$package_json" | jq -r '.author')
    package_description=$(echo "$package_json" | jq -r '.description')
    package_repo_url=$(echo "$package_json" | jq -r '.repo_url')
    package_repo_branch=$(echo "$package_json" | jq -r '.repo_branch')
    package_directory=$(echo "$package_json" | jq -r '.directory')
    package_patch_directory=$(echo "$package_json" | jq -r '.patch_directory')
    package_overlay_directory=$(echo "$package_json" | jq -r '.overlay_directory')
    
    # these are arrays, we need to handle them differently.
    package_dependencies=$(echo "$package_json" | jq -r '.dependencies | join(" ")')
    package_build_cmd=$(echo "$package_json" | jq -r '.build_cmd | join("\n")')
    
    case "$package_name" in
      (*[!a-zA-Z0-9_-]*)
        echo "skipping package with invalid name. pass VERBOSE=1 to 'make' to see the full name."
        continue
        ;;
    esac

    # Is the package disabled?
    eval "[ \"\$CONFIG_PACKAGE_$package_package_name\" != \"y\" ]" && continue

    # TODO(kxtz):
    # We should `cd` into `/package`, clone the repository with the following args: `git clone [repo url] <if repo branch, do -b [branch]> [package dir]`
    # Then, `cd` into the package dir and apply any patches.
    # Finally, run the build command.
    echo "$package_package_name"
  done
}

main "$@"
