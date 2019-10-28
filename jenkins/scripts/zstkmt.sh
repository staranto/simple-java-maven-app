#!/usr/bin/env bash

pwd
id
env

echo token:::: $GITHUBPAT
echo tokensubstring:::: ${GITHUBPAT:0:5}

release=$(curl -XPOST -H "Authorization:token $GITHUBPAT" --data "{\"tag_name\": \"mytag\", \"target_commitish\": \"master\", \"name\": \"myname\", \"body\": \"mydesc\", \"draft\": false, \"prerelease\": true}" https://api.github.com/repos/staranto/simple-java-maven-app/releases)
echo release:::: $release

# Extract the id of the release from the creation response
id=$(echo "$release" | sed -n -e 's/"id":\ \([0-9]\+\),/\1/p' | head -n 1 | sed 's/[[:blank:]]//g')
echo id:::: $id

curl -XPOST -H "Authorization:token $GITHUBPAT" -H "Content-Type:application/octet-stream" --data-binary @artifact.zip https://uploads.github.com/repos/staranto/simple-java-maven-app/releases/$id/assets?name=artifact.zip

