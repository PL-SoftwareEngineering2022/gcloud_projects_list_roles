### gcloud projects list roles by group
- These scripts use the Google Cloud SDK gcloud command to get the IAM policy for each project, and then filter the policy to 
find the roles assigned to each group/service account:

  - `roles_by_group.sh`
    -  Outputs a CSV-formatted list of project ID, group email, and the role assigned to the group for each project.
    
 - `roles_by_serviceAccount.sh`
    - Outputs a CSV-formatted list of project ID, service account email, and the role assigned to the service account for each project.
    
- The `--flatten` and `--format` options are used to extract the relevant information from the policy.
- The scripts can be run directly on the cloud shell or on an editor that has been authenticated with the google cloud 
you are trying to run either script against.

