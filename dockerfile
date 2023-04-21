

### Creating jenkins Image From Docker File.

FROM ubuntu:22.04
RUN apt update
RUN apt install -y openjdk-17-jdk
LABEL Author="Ravikiran" organisation="Qualitythought"
RUN apt install -y curl
RUN curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null 
RUN apt-get update
RUN apt-get install -y jenkins
USER jenkins
EXPOSE 8080 
CMD [ "/usr/bin/jenkins" ]





### Try Creating a Dockerfile which runs PHPinfo page ,user ARG and ENV wherever Appropriate on Apache server and nginx server.

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install apache2 -y
RUN apt install php -y 
RUN apt install libapache2-mod-php -y
RUN echo "<?php phpinfo() ?>" > /var/www/html/phpinfo.php
EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]



### Try Creating a Dockerfile which runs PHPinfo page ,user ARG and ENV wherever Appropriate on Apache server and nginx 


FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install nginx -y
RUN apt install php8.1-fpm -y
RUN echo "<?php echo phpinfo(); ?>" > /var/www/html/phpinfo.php
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



FROM nginx:alpine
ADD /default.conf /etc/nginx/conf.d
ENV DEBIAN_FRONTEND noninteractive
RUN apk add php7-fpm 
COPY default.conf /etc/nginx/sites-available/default
RUN echo "<?php echo phpinfo(); ?>" >> /var/www/html/phpinfo.php
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]




FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y nginx php-fpm && \
    rm -rf /var/lib/apt/lists/*
COPY default.conf /etc/nginx/sites-available/default
RUN echo "<?php echo phpinfo(); ?>" >> /var/www/html/phpinfo.php
EXPOSE 80
CMD ["nginx", "-g", "daemon off;","php-fpm","-D"]


FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y nginx php-fpm && \
    rm -rf /var/lib/apt/lists/*
COPY default.conf /etc/nginx/sites-available/default.conf
COPY index.php /var/www/html/index.php
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]



FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update 
RUN apt-get install nginx -y
RUN apt-get install php8.1-fpm -y && \
    rm -rf /var/lib/apt/lists/*
COPY default.conf /etc/nginx/sites-available/default
RUN nginx -t
RUN chmod -R 777 /var/www/html/
RUN echo "<?php phpinfo() ?>" >> /var/www/html/info.php
ENTRYPOINT ["/bin/bash", "-c", "service php8.1-fpm start && nginx -g 'daemon off;'"]
EXPOSE 80




CMD ["nginx", "-g", "daemon off;"]




FROM mcr.microsoft.com/dotnet/sdk:7.0
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.2/nopCommerce_4.60.2_NoSource_linux_x64.zip /nop/nopCommerce_4.60.2_NoSource_linux_x64.zip
WORKDIR /nop
RUN apt update && apt install unzip -y && \
    unzip /nop/nopCommerce_4.60.2_NoSource_linux_x64.zip && \
    mkdir /nop/bin && mkdir /nop/logs
EXPOSE 5000
CMD [ "dotnet", "Nop.Web.dll","--urls", "http://0.0.0.0:5000" ]


https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Nginx-PHP-FPM-config-example
https://www.bmc.com/blogs/docker-cmd-vs-entrypoint/




In this modified Dockerfile, the ENTRYPOINT directive is used to start PHP-FPM and Nginx. When the container starts, the ENTRYPOINT command runs /bin/bash -c to execute the following commands in a shell:


