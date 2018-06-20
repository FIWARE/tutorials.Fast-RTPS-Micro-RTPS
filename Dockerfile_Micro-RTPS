# Dockerfile for installing Fast-RTPS and micro-RTPS
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


# install g{test} sources & put headers into /usr/include
RUN apt-get update && apt-get install -y libgtest-dev unzip build-essential

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
	apt-get update && \
# 	apt-get install -y cpp curl make cmake libprotobuf-dev libboost-all-dev protobuf-compiler
	apt-get install -y cmake 

RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get install -y gcc-7 g++-7 && \
  update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60 && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60


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

RUN git clone --recursive https://github.com/eProsima/Fast-RTPS.git /Fast-RTPS

RUN mkdir /Fast-RTPS/build && \
	cd /Fast-RTPS/ && \
	git checkout 201a393b500a35d56d3e46b5b6c2c6a96e85928e && \
	cd build && \
	cmake -DTHIRDPARTY=ON -DBUILD_JAVA=ON .. && \
	make  && \
	make install


RUN  git clone --recursive https://github.com/eProsima/micro-RTPS.git

RUN mkdir /micro-RTPS/build && \
	cd /micro-RTPS/ && \
	git checkout 344a25cbce4c2e8abca14bc0288164318a52d612 && \ 
	cd build && \ 
	#cmake -DCMAKE_C_FLAGS="-std=c++0x" -DTHIRDPARTY=ON -DEPROSIMA_BUILD_EXAMPLES=ON .. && \
	cmake -DTHIRDPARTY=ON -DEPROSIMA_BUILD_EXAMPLES=ON .. && \
	make && \
	make install && \
	cd .. && \
	ldconfig /usr/local/lib/

