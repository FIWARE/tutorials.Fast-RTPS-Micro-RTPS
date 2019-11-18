# Dockerfile for installing Fast-RTPS and micro-RTPS
FROM openjdk:10-jdk

MAINTAINER Filip Lemic <filip.lemic@gmail.com>

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
	cd build && \
	cmake -DTHIRDPARTY=ON -DBUILD_JAVA=ON .. && \
	make  && \
	make install


RUN  git clone --recursive https://github.com/eProsima/micro-RTPS.git

RUN mkdir /micro-RTPS/build && \
	cd /micro-RTPS/ && \
	cd build && \ 
	#cmake -DCMAKE_C_FLAGS="-std=c++0x" -DTHIRDPARTY=ON -DEPROSIMA_BUILD_EXAMPLES=ON .. && \
	cmake -DTHIRDPARTY=ON -DEPROSIMA_BUILD_EXAMPLES=ON .. && \
	make && \
	make install && \
	cd .. && \
	ldconfig /usr/local/lib/

CMD ["bin/bash"]

