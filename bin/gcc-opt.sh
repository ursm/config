#!/bin/sh

CC="gcc"
OPT="-march=native"
NATIVE=$(echo | ${CC} -E -v ${OPT} - 2>&1 | grep cc1)
NOARCH=$(echo | ${CC} -E -v - 2>&1 | grep cc1)

for native in ${NATIVE} ; do
        FOUND=0
        for noarch in ${NOARCH} ; do
                if [ "${native}" = "${noarch}" -a "${native}" != "${OPT}" ] ; then
                        FOUND=1
                        break
                fi
        done
        if [ ${FOUND} -eq 0 ] ; then
                echo -n "${native} "
        fi
done
echo
