
VERSION="$(md5sum docker/Dockerfile.jenkins | awk '{print $1}')"
WORKINGDIR="$(pwd)"

docker build . -t paintroid:${VERSION} -f docker/Dockerfile.jenkins --build-arg USER_ID=1000 --build-arg GROUP_ID=1000 --build-arg KVM_GROUP_ID=$(getent group kvm | cut -d: -f3)

docker run -it --rm -u 1000:1000 -v /dev/kvm:/dev/kvm:Z -e JENKINS_URL="notEmpty" -e GRADLE_USER_HOME=$HOME/.gradle -v $HOME/.gradle:$HOME/.gradle -w ${WORKINGDIR} -v ${WORKINGDIR}:${WORKINGDIR}:rw,z paintroid:${VERSION}
