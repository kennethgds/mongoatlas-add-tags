#!/bin/bash

public_key="XXX"
private_key="XXX"
project_name="XXX"
cluster_name="XXX"

project_id=$(curl --user "$public_key:$private_key" \
--digest \
--request GET \
--url "https://cloud.mongodb.com/api/public/v1.0/groups/byName/$project_name?pretty=true" | jq -r '.id')

curl --user "$public_key:$private_key" \
  --digest \
  --header "Accept: application/vnd.atlas.2023-02-01+json" \
  --request PATCH \
  --url "https://cloud.mongodb.com/api/atlas/v2/groups/$project_id/clusters/$cluster_name" \
  --header "Content-Type: application/json" \
  --data "{
    \"tags\": [
      {
        \"key\"   : \"Name\",
        \"value\" : \"$cluster_name\"
      },
      {
        \"key\"   : \"environment\",
        \"value\" : \"$cluster_name\"
      }
    ]
  }"
