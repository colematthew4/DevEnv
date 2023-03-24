settings_file=$(cat $(dirname $0)/settings.json)
profile=$(dirname $0)/$1
extensions=$(jq -c '.extensions' $profile.json-profile)
state=$(jq '.globalState | map_values(map_values(tostring)) | tostring' $profile.json-profile)
jq \
  --arg name $1 \
  --arg settings "$settings_file" \
  --arg extensions "$extensions" \
  --arg state "$state" \
  '{name:$name,settings:({settings:$settings} | tostring),extensions:$extensions,globalState:$state}' \
  $profile.json-profile > $profile.code-profile
