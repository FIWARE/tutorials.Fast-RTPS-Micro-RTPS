# Dockerfile for installing Fast-RTPS
FROM openjdk:10-jdk

MAINTAINER Filip Lemic <filip.lemic@gmail.com>

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
	cd build && \
	cmake -DTHIRDPARTY=ON -DBUILD_JAVA=ON .. && \
	make  && \
	make install

WORKDIR /home/Fast-RTPS/examples/C++/HelloWorldExample/
