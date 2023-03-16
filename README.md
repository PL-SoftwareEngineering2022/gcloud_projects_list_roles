### gcloud projects list roles by group
- This script uses the Google Cloud SDK gcloud command to get the IAM policy for each project, and then filters the policy to 
find the role assigned to each group:
  - It outputs a CSV-formatted list of project ID, group email, and the role assigned to the group for each project.
- The `--flatten` and `--format` options are used to extract the relevant information from the policy.
- The script can be run directly on the cloud shell or on an editor that has been authenticated with the google cloud 
you are trying to run the script against.

