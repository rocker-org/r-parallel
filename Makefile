tag=rocker-org/r-parallel

build:
	docker build . --tag $(tag)

run:
	docker run -ti $(tag)

push:
	docker push $(tag)

login:
	docker login
