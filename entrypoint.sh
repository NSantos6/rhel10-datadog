#!/bin/bash
/opt/datadog-agent/bin/agent/agent run &

sleep 2

exec /bin/bash -c "while true; do echo 'Datadog running...'; sleep 10; done"