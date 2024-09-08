# CodyAI Custom Commands Update Script

## Overview

This script automates the process of updating a `cody.json` file from the CodyAI VSCode extension, committing changes to a Git repository, incrementing the version number, and creating a new Git tag. It is designed to work with a symbolic link setup where `cody.json` is managed outside of version control and copied into the repository.

## Features

- Checks if `cody.json` exists in the repository; creates it if it doesn’t.
- Copies content from an external source file specified by an environment variable.
- Detects changes in `cody.json`.
- Updates the version number in `version.txt`.
- Commits changes to `cody.json` and `version.txt`.
- Pushes changes to the `main` branch.
- Creates a new Git tag based on the updated version and pushes it to the remote repository.

## Prerequisites

- Ensure that you have Git installed and configured on your system.
- The script requires an environment variable `CODYAI_FILE` pointing to the file from which content will be copied.
- The script should be run from within a Git repository where `cody.json` and `version.txt` are located.

## Setup
1. **Create the CodyAI configuration file**

    Create a `cody.json` file in the `.vscode` directory at the root of the user's home directory and add some custom commands.

2. **Create the script file**

    Create a new local repository and add the following content:
    - A `push_changes.sh` script inside a `bin` directory with the content from this repository.
    - A `version.txt` file with the content from this repository. Set the version number to `1.0`.

3. **Set Permissions**

    Ensure the `push_changes.sh` script has execute permissions:

      ```bash
      chmod +x /path/to/your/bin/push_version.sh
      ```

4.	**Configure Environment Variable**
Set the `CODYAI_FILE` environment variable globally to the path of the file from which `cody.json` content will be copied:
    ```bash
    export CODYAI_FILE=/path/to/your/source/file.json
    ```

## Usage

1.	**Run the Script**
Execute the script to update `cody.json`, commit changes, increment the version, and create a new Git tag:
    ```bash
    /path/to/your/bin/push_changes.sh
    ```

2.	**Check Results**
After running the script, verify the following:
	- `cody.json` in the root directory of the repository has been updated with the latest content.
	- Changes are committed and pushed to the main branch.
	- A new Git tag reflecting the updated version is created and pushed to the remote repository.


## Troubleshooting
 - File Not Found Errors: Ensure `CODYAI_FILE` is correctly set to an existing file path.
- Permission Denied: Verify script permissions and ensure you have write access to the repository.
- Git Issues: Ensure Git is correctly configured and that you have permissions to push to the remote repository.

## License

This script is provided as-is with no warranty. Feel free to modify and use it according to your needs.
This README provides a comprehensive guide on setting up and using the script, ensuring that users understand its functionality and how to configure it properly.