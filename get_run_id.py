import json
import os
import uuid

def extract_invocation_id():
    """Extracts the invocation ID from run_results.json."""
    run_results_path = "target/run_results.json"  # Adjust path if needed
    try:
        with open(run_results_path, "r") as f:
            run_results = json.load(f)
            invocation_id = run_results.get("metadata", {}).get("invocation_id")
            if invocation_id:
                return invocation_id
            else:
                print("Error: Invocation ID not found in run_results.json.")
                return None
    except FileNotFoundError:
        print("Warning: run_results.json not found.")
        return None
    except json.JSONDecodeError:
        print("Error: run_results.json is not valid JSON.")
        return None
    except Exception as e:
        print(f"Error: An unexpected error occurred: {e}")
        return None



if __name__ == "__main__":
    invocation_id = extract_invocation_id()
    if invocation_id:
        os.environ["DBT_RUN_ID"] = invocation_id #sets the environment variable
        print(f"Invocation ID: {invocation_id}")
    else:
        #if there is no invocation ID, then generate a random UUID, so we can always have a RUN_ID
        random_uuid = uuid.uuid4()
        os.environ["DBT_RUN_ID"] = str(random_uuid)
        print(f"Generated Random UUID: {random_uuid}")
