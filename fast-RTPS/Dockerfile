# Dockerfile for installing Fast-RTPS
FROM phusion/baseimage:0.9.17

MAINTAINER Filip Lemic <filip.lemic@gmail.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list

RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ trusty-updates main universe multiverse restricted" >> /etc/apt/sources.list

RUN apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-software-properties software-properties-common

# Install Java 8
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y software-properties-common && \
	add-apt-repository ppa:webupd8team/java -y && \
	apt-get update && \
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
	apt-get install -y oracle-java8-installer 

RUN apt-get update && \
	apt-get install -y cpp gcc g++ gcc curl g++ make cmake libprotobuf-dev libboost-all-dev protobuf-compiler

# install g{test} sources & put headers into /usr/include
RUN apt-get update && apt-get install -y libgtest-dev unzip build-essential

# build & install gtest (cmake -DBUILD_SHARED_LIBS=ON . for shlibs)
RUN cd /usr/src/gtest ; cmake CMakeLists.txt ; make

RUN cp /usr/src/gtest/*.a /usr/lib/

# Download and install Gradle
RUN cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-2.5-bin.zip -o gradle-2.5-bin.zip && \
    unzip gradle-2.5-bin.zip && \
    rm gradle-2.5-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-2.5

ENV PATH=$PATH:$GRADLE_HOME/bin 

RUN apt-get update && apt-get install -y git

RUN git clone --recursive https://github.com/eProsima/Fast-RTPS.git /home/Fast-RTPS

RUN mkdir /home/Fast-RTPS/build && \
	cd /home/Fast-RTPS/ && \
	git checkout 201a393b500a35d56d3e46b5b6c2c6a96e85928e && \
	cd build && \
	cmake -DTHIRDPARTY=ON -DBUILD_JAVA=ON .. && \
	make  && \
	make install

WORKDIR /home/Fast-RTPS/examples/C++/HelloWorldExample/
