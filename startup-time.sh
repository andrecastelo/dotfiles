#!/bin/sh
nvim --startuptime startup.log -c exit && tail -5 startup.log
