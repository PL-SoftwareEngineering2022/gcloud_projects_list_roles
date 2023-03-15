#!/bin/bash
echo $(date) >> iamlist.csv
gcloud projects list --format="csv[no-heading](projectId,name)" |\
while IFS="," read -r ID NAME
do
  POLICY=$(\
    gcloud projects get-iam-policy ${ID} \
    --flatten="bindings[].members[]" \
    --format="csv[no-heading](bindings.role,bindings.members)" \
    --filter="bindings.members:group")
echo " " >> iamlist.csv
echo ${ID} >> iamlist.csv
  for line in ${POLICY}
  do
   echo ${line} >> iamlist.csv
  done
done
echo "script is complete"
