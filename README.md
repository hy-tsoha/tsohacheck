# tsohacheck
tool for course assistants

## Requirements

Script expects following tools (should be already installed on department computers):

- working linux environment (if necessary, adjust names of python and pylint within the script)
- bash
- python3
- pylint3
- find
- sed
- git


## Usage

Copy the script and other files to a directory where you want to run this script. You probably want to have separate directories to run this script for each week to be checked.

Write repo paths into file `repolist`, each path for separate line, for example:

    https://github.com/student1/example1.git
    https://github.com/student2/example2

Then run the script: `bash tsohacheck.sh` in empty directory (except for repolist and scripts).

Script assumes you are at the start in empty directory, except for scripts and repolist. (Importantly, that there is no subdirectories.)

Script will:

- clone all public repos listed in repolist (cloning will be reported as a fail for repo if it requires login)
- run some checks for extra files
- run pylint
- run (possible) checks from custom.py

Results of cloning are saved in to tsohacheck.log file in starting directory. Results of repo checks (lint etc) are saved in tsohacheck.log in repository directory.


## Future development

If you want to write custom checks, you can add them to custom.py and output results to include them in report. Please, if your additions are generally useful, make also a pull request to add them to this repo.
