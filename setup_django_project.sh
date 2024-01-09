#!/bin/bash

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Error: Git is not installed. Please install it before running this script."
    exit 1
fi

# Get project name from user
read -p "Enter the Django project name: " project_name

# Get virtual environment name from user, default to 'env'
read -p "Enter the virtual environment name (default is 'env'): " venv_name
venv_name=${venv_name:-env}


# Create the root folder and navigate into it
mkdir $project_name
cd $project_name

# Create a virtual environment
python3 -m venv $venv_name

# Activate the virtual environment
source $venv_name/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

# Install Django
pip install django

# Create Django project
django-admin startproject $project_name ./

# Initialize Git repository 
git init

# Create a .gitignore file
echo -e "*.pyc\n__pycache__\n$venv_name/\n*.sqlite3\n*.pyo\n*.pyd\n" > .gitignore

# Add and commit files to Git
git add .
git commit -m "Initial commit"

echo -e "\n\nDjango project '$project_name' has been set up with virtual environment '$venv_name' and Git repository."
echo -e "\nNavigate to the repository\ncd $project_name"
echo -e "\nDon't forget to activate the virtual environment before working on the project:"
echo -e "source $venv_name/bin/activate\n\n"
