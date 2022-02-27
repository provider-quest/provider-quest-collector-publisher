# /bin/bash

# "Id": "/hostedzone/Z07643141N50Z459F1ECP",
# "Name": "feeds.provider.quest.",

HOSTED_ZONE_ID=Z07643141N50Z459F1ECP

FEED=$1
CID=$2

echo Feed: $FEED CID: $CID
if [ -z "$FEED" -o -z "$CID" ]; then
	echo "Missing args"
	exit 1
fi

JSON="$(cat <<EOF
    {
      "Changes": [
        {
          "Action": "UPSERT",
          "ResourceRecordSet": {
            "Name": "_dnslink.$FEED.feeds.provider.quest",
            "Type": "TXT",
            "TTL": 30,
            "ResourceRecords": [
              {
                "Value": "\"dnslink=/ipfs/$CID\""
              }
            ]
          }
        }
      ]
    }
EOF
)"

echo $JSON
aws route53 change-resource-record-sets \
  --hosted-zone-id $HOSTED_ZONE_ID \
  --change-batch "$JSON"
