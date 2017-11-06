#!/bin/bash
#Dawid Tracz gr.2

kill -SIGTERM -$1
sleep 1
kill -SIGKILL -$1