#!/bin/bash -
#===============================================================================
#
#          FILE: install.sh
#
#         USAGE: ./install.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: levis.liu(liuhuiping2013@gmail.com)
#  ORGANIZATION:
#       CREATED: 2018年02月23日 16:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

main()
{
    curl https://raw.githubusercontent.com/liuhuiping2013/onewaygg/master/.gg -o ~/.gg_saved
    echo 'install successful now'
}

main

