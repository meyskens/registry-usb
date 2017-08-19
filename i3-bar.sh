#!/bin/bash

function checkStatus {
	docker inspect registry 1> /dev/null 2>&1
	case $? in
	  0) echo '<span foreground="green">Reg up</span>' ;;
	  *) echo '<span foreground="red">Reg down</span>' ;;
	esac
}

function onOff {
        echo '<span foreground="orange">TOGGLING</span>';
	docker inspect registry 1> /dev/null 2>&1
        case $? in
          0) docker-compose down >/dev/null ;;
          *) docker-compose up -d ;;
        esac
}

case $BLOCK_BUTTON in
    1) onOff  ;;
    *) checkStatus ;;
esac


