NGX_IMG_NAME := nginx:1337
NGX_CNT_NAME := nginx
CLT_IMG_NAME := client:1337
CLT_CNT_NAME := client
NET_NAME     := net

build :
	docker network create $(NET_NAME)
	docker build -t $(NGX_IMG_NAME) -f DockerfileNginx .
	docker build -t $(CLT_IMG_NAME) -f DockerfileClient .

run :
	docker run -d  --rm --network $(NET_NAME) --name $(NGX_CNT_NAME) -p 8080:8080 $(NGX_IMG_NAME) 
	docker run -d  --rm --network $(NET_NAME) --name $(CLT_CNT_NAME) $(CLT_IMG_NAME)
run-nginx :
	docker run -d --rm --network $(NET_NAME) --name $(NGX_CNT_NAME) -p 8080:8080 $(NGX_IMG_NAME)
run-client :
	docker run -it --rm --network $(NET_NAME) --name $(CLT_CNT_NAME) $(CLT_IMG_NAME)

enter-nginx :
	docker exec -it $(NGX_CNT_NAME) bash
enter-client :
	docker exec -it $(CLT_CNT_NAME) bash

rm :
	docker rm -f $(NGX_CNT_NAME)
	docker rmi $(NGX_IMG_NAME)
	docker rm -f $(CLT_CNT_NAME)
	docker rmi $(CLT_IMG_NAME)
	docker network rm $(NET_NAME)
