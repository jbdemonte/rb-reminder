####################################################################################################
#
# This script builds Recalbox on a dedicated machine using the source from the current one
#
#  Run with:    ARCH=rpi3 ./build.sh
#
#  NB: NEVER FORGET ENDING / on folders
#
####################################################################################################

# CONFIGURATION
SERVER_IP=192.168.0.40
LOCAL_SOURCE_PATH=/Users/jbd/git/recalbox/recalbox/
SERVER_TARGET_PATH=/home/jbd/git/recalbox-${ARCH}/

if [[ -z ${ARCH} ]]
then
	echo "ARCH is missing"
	exit 0
fi

clear

# COPY FILES
ssh ${SERVER_IP} mkdir -p ${SERVER_TARGET_PATH}
rsync -e ssh -avz --progress ${LOCAL_SOURCE_PATH} ${SERVER_IP}:${SERVER_TARGET_PATH} --exclude /output --exclude .idea --exclude /buildroot

# BUILD
ssh -t ${SERVER_IP} "cd ${SERVER_TARGET_PATH} && ARCH=${ARCH} ./scripts/linux/recaldocker.sh"
