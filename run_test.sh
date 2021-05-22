#!/bin/bash

# Run all server processes.
# Increase the max number of files which can be open:
ulimit -Sn 10000

# Hypercorn includes gunicorn features, an apple to apples comparison requires
# uvicorn be run UNDER gunicorn with 1 worker.
echo 7001
gunicorn app:app -b 0.0.0.0:7001 -w 1 -k uvicorn_workers.AsyncioH11Worker &
sleep 2 && echo 7002
gunicorn app:app -b 0.0.0.0:7002 -w 1 -k uvicorn_workers.UvloopH11Worker &
sleep 2 && echo 7003
gunicorn app:app -b 0.0.0.0:7003 -w 1 -k uvicorn_workers.AsyncioHttptoolsWorker &
sleep 2 && echo 7004
gunicorn app:app -b 0.0.0.0:7004 -w 1 -k uvicorn_workers.UvloopHttptoolsWorker &


# Test uvicorn by itself to see what penalty (if any) gunicorn extracts.
sleep 2 && echo 7005
uvicorn app:app -workers 1 --loop uvloop -http httptools --port 7005 --log-level error &

# Hypercorn includes gunicorn features, an apple to apples comparison requires
# uvicorn be run UNDER gunicorn with 2 workers.
sleep 2 && echo 7011
gunicorn app:app -b 0.0.0.0:7011 -w 2 -k uvicorn_workers.AsyncioH11Worker &
sleep 2 && echo 7012
gunicorn app:app -b 0.0.0.0:7012 -w 2 -k uvicorn_workers.UvloopH11Worker &
sleep 2 && echo 7013
gunicorn app:app -b 0.0.0.0:7013 -w 2 -k uvicorn_workers.AsyncioHttptoolsWorker &
sleep 2 && echo 7014
gunicorn app:app -b 0.0.0.0:7014 -w 2 -k uvicorn_workers.UvloopHttptoolsWorker &

# Hypercorn with 1 worker - asyncio
sleep 2 && echo 7101
hypercorn app:app -w 1 -k asyncio -b 0.0.0.0:7101 &

# Hypercorn with 1 worker - uvloop
sleep 2 && echo 7102
hypercorn app:app -w 1 -k uvloop -b 0.0.0.0:7102