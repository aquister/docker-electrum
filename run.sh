#!/bin/bash

docker build -t electrum .
docker run -d --rm --link="torsock" --name electrum -ti electrum
