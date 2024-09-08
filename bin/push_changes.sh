#!/bin/bash

# Path to the actual file content from the environment variable
cody_json_path="$(dirname "$0")/../cody.json"

# Check if cody.json exists; if not, create it
if [[ ! -f "$cody_json_path" ]]; then
  echo "cody.json not found. Creating it."
  touch "$cody_json_path"
else
  echo "cody.json already exists."
fi

# Copy the content of the actual file to cody.json
cat "$CODYAI_FILE" > "$cody_json_path"

# Path to the version file
version_file="$(dirname "$0")/../version.txt"

# Change to the root directory of the repository
cd "$(dirname "$0")/.."

# Check for changes in cody.json file
if [[ `git status --porcelain cody.json` ]]; then
  echo "Changes detected in cody.json"

  # Read the current version from the version file
  if [[ -f "$version_file" ]]; then
    current_version=$(cat "$version_file")
  else
    current_version="0.0"
  fi

  # Split the current version into major and minor parts
  IFS='.' read -r major minor <<< "$current_version"

  # Increment the minor version
  minor=$((minor + 1))

  # Construct the new version string
  new_version="$major.$minor"

  # Write the new version to the version file
  echo "$new_version" > "$version_file"

  # Add changes and commit
  git add cody.json version.txt
  git commit -m "chore: update cody.json to v$new_version"

  # Push changes to the remote repository
  if git push origin main; then
    echo "Changes pushed successfully"

    # Create and push a new Git tag
    git tag "v$new_version"
    git push origin "v$new_version"

    echo "Version updated to $new_version and tagged successfully"
  else
    echo "Failed to push changes. Version not updated and tag not created."
  fi
else
  echo "No changes in cody.json"
fi