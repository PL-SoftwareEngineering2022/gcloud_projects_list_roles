#!/bin/bash
echo $(date) >> iamlist2.csv
for PROJECT in  $(gcloud projects list --format="value(projectId)")
do
  POLICY=$(\
    gcloud projects get-iam-policy ${PROJECT} \
    --flatten="bindings[].members[]" \
    --filter="bindings.members:serviceAccount" \
    --format="csv[no-heading](bindings.role,bindings.members)")
echo " " >> iamlist2.csv
echo ${PROJECT} >> iamlist2.csv
  for LINE in ${POLICY}
  do
    echo ${LINE} >> iamlist2.csv
  done
done
echo "script is complete"
