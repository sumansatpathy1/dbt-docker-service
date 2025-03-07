#!/bin/bash

# Check for required environment variables
if [ -z "$DBT_PASSWORD" ]; then
  echo "Error: DBT_PASSWORD environment variable is not set."
  exit 1
fi

if [ -z "$DBT_RUN_ID" ]; then
  echo "Error: DBT_RUN_ID environment variable is not set."
  exit 1
fi

if [ -z "$GIT_REPO_URL" ]; then
  echo "Error: GIT_REPO_URL environment variable is not set."
  exit 1
fi

if [ -z "$GIT_BRANCH" ]; then
  echo "Error: GIT_BRANCH environment variable is not set."
  exit 1
fi

# Set password as environment variable for dbt
export DBT_PASSWORD="$DBT_PASSWORD"

echo "DBT run completed. Results saved to $PWD"

# Create run results directory
RUN_RESULTS_DIR="run_results/$DBT_RUN_ID"
mkdir -p "$RUN_RESULTS_DIR"

# Clone the Git repository dynamically
git clone -b main https://github.com/sumansatpathy1/dbt-demo.git
#git clone -b "$GIT_BRANCH" "$GIT_REPO_URL" .

#ls -ltr
#ls profiles/
cd dbt-demo
mkdir target 
#ls -ltr

# Run dbt command (replace with your actual dbt command)
#dbt run --profiles-dir "$DBT_PROFILES_DIR" --project-dir /app/ --target dev > "$RUN_RESULTS_DIR/dbt_run.log" 2>&1
#dbt run --profiles-dir /app/profiles --project-dir /app/ --target dev > "$RUN_RESULTS_DIR/dbt_run.log" 2>&1
dbt run --profiles-dir /app/profiles --target dev #> "$RUN_RESULTS_DIR/dbt_run.log" 2>&1
#dbt run --profiles-dir /app/profiles 
#ls -lrt
DBT_RUN_ID=$(python /app/get_run_id.py)
export DBT_RUN_ID="$DBT_RUN_ID"

echo "The run ID is: $DBT_RUN_ID"

# Save run results and logs
#mkdir -p "$RUN_RESULTS_DIR/target"
#cp -r target "$RUN_RESULTS_DIR/target"

# Commit and push results to git (optional)
#git config --global user.email "sumansatpathy@gmail.com"
#git config --global user.name "Suman Satpathy"
#git add .  
#git commit -m "DBT run results: $DBT_RUN_ID"
#git push origin "$GIT_BRANCH"

echo "DBT run completed. Results saved to $RUN_RESULTS_DIR"
