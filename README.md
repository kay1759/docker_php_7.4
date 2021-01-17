# docker_php_7.4

	php 7.4 with changing uid and gid of www-data

	Mainly used for development purpose

## Application Installation Instructions:

    git clone git@github.com:kay1759/docker_php_7.4.git
    cd docker_php_7.4
	** change uid data below as your environment
	   *** uid and gid in Dockerfile, recommend to same uid and gid with developer account in your docker host
	   *** myhostname in main.cf
	   *** timezone and/or mbstring.language
	docker build .
	docker tag <docker-image-id> myphp:7.4
	

### Usage Example

	docker network create --subnet=172.23.2.0/24 mydockernet
	docker run --name mariadb -d -e MYSQL_ROOT_PASSWORD=myapassword --net=mydockernet --ip=172.23.2.2 mariadb

	docker run --name phpapp -d -v /home/app/myapp/html:/var/www/html -v /home/app/myapp/sites-available:/etc/apache2/sites-available --net=mydockernet --ip=172.23.2.3 myphp:7.4

    connet with browzer
    http://172.23.2.3/

## Licence
[MIT]

## Author
[Katsuyoshi Yabe](https://github.com/kay1759)

