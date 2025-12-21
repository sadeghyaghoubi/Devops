docker images

(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'registry.abriment.co')
LIST=$(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'registry.abriment.co')
for i in $LIST; do docker rmi -f $i; done

docker images
