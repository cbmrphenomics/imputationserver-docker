#!/bin/bash

set -o nounset # Fail on unset variables
set -o errexit # Fail on uncaught non-zero returncodes
set -o pipefail # Fail is a command in a chain of pipes fails

if [ -e "/var/lib/hadoop-hdfs/cache/" ];
then
	chown hdfs:hadoop /var/lib/hadoop-hdfs/cache/
fi

# Original CMD in genepi/imputationserver:v1.5.7
/usr/bin/startup "$@"
