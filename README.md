# tsohacheck
tool for course assistants

## Requirements

Script expects following tools (should be already installed on department computers):

- working linux environment (Department distribution or something similar, eg ubuntu)
- bash
- pylint3
- find
- git


## Usage

Write repo paths into file repolist, each path for separate line, for example:

    https://github.com/student1/example1.git
    https://github.com/student2/example2.git

Then run the script: `bash tsohacheck.sh` in empty directory.

Script assumes you are in the start in empty directory, except for script and repolist.

Script will:

- clone all public repos listed in repolist (cloning will fail for repo if it requires login)
- run some checks for extra files
- run pylint

Results of cloning are saved in to tsohacheck.log file. Results of checks are saved in tsohacheck.log in repository directory.
