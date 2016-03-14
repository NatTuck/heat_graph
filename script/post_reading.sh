#!/bin/sh

NOW=`date -R`

curl -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -X POST \
     -d "{\"reading\": {\"sensor_id\": 1, \"timestamp\": \"$NOW\", \"value\": \"20.3\" }}" \
     http://localhost:4000/api_v1/reading

echo
