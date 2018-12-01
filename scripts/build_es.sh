####################################################################################################
#
# This script builds Emulationstation on a dedicated machine using the build on the foreign one and
# the emulationstation source from the current one
#
#  Run with:    ARCH=rpi3 ./build_es.sh
#
# NB: Before using this script, you need to add the ssh Host key of the recalbox
#    => by simply initiating a ssh connexion: ssh root@recalbox_ip
#
####################################################################################################

# CONFIGURATION
SERVER_IP=192.168.0.40
RECALBOX_IP=192.168.0.41
RECALBOX_LNG=fr
LOCAL_SOURCE_PATH=/Users/jbd/git/recalbox/recalbox-emulationstation/
SERVER_BUILD_PATH=/home/jbd/git/recalbox-${ARCH}/

if [[ -z ${ARCH} ]]
then
	echo "ARCH is missing"
	exit 0
fi


# COPY FILES
clear
PACKAGE_VERSION=$(ssh ${SERVER_IP} "sed -n '/^RECALBOX_EMULATIONSTATION2_VERSION\s=\s\(.*\)$/s//\1/p' < ${SERVER_BUILD_PATH}package/recalbox-emulationstation2/recalbox-emulationstation2.mk")
PACKAGE_PATH="${SERVER_BUILD_PATH}output/build/recalbox-emulationstation2-${PACKAGE_VERSION}"
echo "PACKAGE_PATH = ${PACKAGE_PATH}"

echo "syncing files..."
ssh ${SERVER_IP} rm -rf ${PACKAGE_PATH}
rsync -e ssh -aqz --progress ${LOCAL_SOURCE_PATH} ${SERVER_IP}:${PACKAGE_PATH} --delete --exclude .git

ssh ${SERVER_IP} touch ${PACKAGE_PATH}/.stamp_downloaded
ssh ${SERVER_IP} touch ${PACKAGE_PATH}/.stamp_extracted

# BUILD ES
ssh -t ${SERVER_IP} "cd ${SERVER_BUILD_PATH} && ARCH=${ARCH} PACKAGE=recalbox-emulationstation2 ./scripts/linux/recaldocker.sh"


# COPY ES ON THE RECALBOX
sshpass -p 'recalboxroot' ssh root@${RECALBOX_IP} 'mount -o remount,rw /'
sshpass -p 'recalboxroot' ssh root@${RECALBOX_IP} 'killall -KILL emulationstation'
sshpass -p 'recalboxroot' scp -3 ${SERVER_IP}:${PACKAGE_PATH}/emulationstation root@${RECALBOX_IP}:/usr/bin/emulationstation
sshpass -p 'recalboxroot' scp -3 ${SERVER_IP}:${SERVER_BUILD_PATH}output/target/usr/share/locale/${RECALBOX_LNG}/LC_MESSAGES/emulationstation2.mo root@${RECALBOX_IP}:/usr/share/locale/${RECALBOX_LNG}/LC_MESSAGES
sshpass -p 'recalboxroot' ssh root@${RECALBOX_IP} 'mount -o remount,ro /'
sshpass -p 'recalboxroot' ssh root@${RECALBOX_IP} '/usr/bin/emulationstation'
