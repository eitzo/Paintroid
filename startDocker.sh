
VERSION="$(md5sum docker/Dockerfile.jenkins | awk '{print $1}')"
WORKINGDIR="$(pwd)"

docker build . -t paintroid:${VERSION} -f docker/Dockerfile.jenkins --build-arg USER_ID=1000 --build-arg GROUP_ID=1000 --build-arg KVM_GROUP_ID=112

docker run -it --rm -u 1000:1000 --device=/dev/kvm:/dev/kvm:rw -e JENKINS_URL="somecrap" -v $HOME/.gradle:/home/user/.gradle -w ${WORKINGDIR} -v ${WORKINGDIR}:${WORKINGDIR}:rw,z paintroid:${VERSION}
