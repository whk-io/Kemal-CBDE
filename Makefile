console: build env

build:
	docker build -t crystal-dev .

env:
	docker run -p 3000:3000 -w /kemal -ti -v "$(shell pwd)/kemal:/kemal" crystal-dev /bin/bash

package:
	docker build -t kemal -f Dockerfile.package .

run-package:
	docker run -p 3000:3000 kemal:latest

flatten:
	./flatten.sh

run-flatten:
	docker run -p 3000:3000 kemal-package:flat

deploy: package flatten run-flatten