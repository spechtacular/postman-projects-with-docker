#!/bin/bash

sleep 30s
newman run verity.postman_collection.json -e Verity.postman_environment.json --bail
