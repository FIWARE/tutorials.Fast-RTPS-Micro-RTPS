#!/bin/bash
#
#  Command Line Interface to start all services associated with the Fast/Micro-RTPS tutorials
#
#  For this tutorial the commands are merely a convenience script to run docker-compose
#

set -e

stoppingContainers () {
	echo "Stopping containers"
	docker-compose -f docker-compose/Fast-RTPS.yml down
	docker-compose -f docker-compose/Micro-RTPS.yml down
	echo "Removing volumes"
	docker volume prune --force
	echo ""
}

if (( $# != 1 )); then
    echo "Illegal number of parameters"
    echo "usage: services [fast|micro|stop]"
    exit 1
fi

command="$1"
case "${command}" in
	"help")
        echo "usage: services [fast|micro|stop]"
        ;;
    "fast")
		stoppingContainers
		echo -e "Installing Fast-RTPS."
		echo ""
		docker-compose -f docker-compose/Fast-RTPS.yml up
		;;
	 "micro")
		stoppingContainers
		echo -e "Installing Micro-RTPS."
		echo ""
		docker-compose -f docker-compose/Micro-RTPS.yml up
		;;
	"stop")
		stoppingContainers
		;;
esac