######
# See: https://hub.docker.com/_/php/
######

FROM php:7.1.12-fpm
MAINTAINER yuxuewen <8586826@qq.com>

######
# You can install php extensions using docker-php-ext-install
######

#RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak

#RUN echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list \
#    && echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list \
#    && echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >> /etc/apt/sources.list

#RUN cat /etc/apt/sources.list.bak >> /etc/apt/sources.list

#安装composer
#WORKDIR /opt
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php --install-dir= --filename=composer
#RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

#安装node


COPY ./composer /usr/bin/composer
WORKDIR /opt

RUN echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib " > /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


RUN apt-get update \
    &&  apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        wget \
        vim \
        git \
        git-gui \
        zip \
        unzip \
        supervisor \
        cron \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysql mysqli pdo pdo_mysql zip opcache \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && wget https://npm.taobao.org/mirrors/node/v8.9.0/node-v8.9.0-linux-x64.tar.xz \
    && tar xf node-v8.9.0-linux-x64.tar.xz \
    && mv node-v8.9.0-linux-x64 node

ENV PATH /opt/node/bin:$PATH
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
WORKDIR /source













