# getting started with Fast-RTPS

*eprosima Fast RTPS* is a C++ implementation of the RTPS (Real Time Publish Subscribe) protocol, which provides publisher-subscriber communications over unreliable transports such as UDP, 
as defined and maintained by the Object Management Group (OMG) consortium. RTPS is also the wire interoperability protocol defined for the Data Distribution
Service (DDS) standard, again by the OMG. *eProsima Fast RTPS* holds the benefit of being standalone and up-to-date, as most vendor solutions either implement RTPS as a tool to implement 
DDS or use past versions of the specification.

Some of the main features of this library are:

* Configurable best-effort and reliable publish-subscribe communication policies for real-time
applications.
* Plug and play connectivity so that any new applications are automatically discovered by any other
members of the network.
* Modularity and scalability to allow continuous growth with complex and simple devices in the
network.
* Configurable network behavior and interchangeable transport layer: Choose the best protocol and
system input/output channel combination for each deployment.
* Two API Layers: a high-level Publisher-Subscriber one focused on usability and a lower-level Writer-Reader one that provides finer access to the inner workings of the RTPS protocol.

eProsima Fast RTPS has been adopted by multiple organizations in many sectors including these important cases:

* Robotics: ROS (Robotic Operating System) as their default middleware for ROS2.
* EU R&D: FIWARE Incubated GE.

## Installation Guide

You can install Fast-RTPS with all its dependencies from the precompiled Docker image. You will first need Docker:

### Prerequisites

To keep things simple both components will be run using [Docker](https://www.docker.com). **Docker** is a
container technology which allows to different components isolated into their respective environments. 

* To install Docker on Windows follow the instructions [here](https://docs.docker.com/docker-for-windows/)
* To install Docker on Mac follow the instructions [here](https://docs.docker.com/docker-for-mac/)
* To install Docker on Linux follow the instructions [here](https://docs.docker.com/install/)

### Installation

Now you can proceed with the installation.

```console
git clone https://github.com/flemic/tutorials.Fast-RTPS
cd Fast-RTPS
docker build -t fastrtps:v1 .
```

This will (after some time) build the Docker image to your host machine. How you can run it in a Docker container with:

```console
docker run -i -t --name fastrtps_container fastrtps:v1 bin/bash
```


### Example usage

At this point, you have Fast-RTPS fully supported in the Docker entrainer environment. We can now run a _HelloWorld_ example. In the example, we will send a set of messages from a publisher to a subscriber using Fast-RTPS protocol. First navigate to the _HelloWorld_ example folder:

```console
cd home/Fast-RTPS/example/HelloWorld
```

To compile the example, do the following:

```console
cmake . 
make 
make install
```

Now we will need a second terminal in our Docker environment. In one of the terminals we will start the publisher, while in the other we will start the subscriber. To open a second terminal, open a bash terminal and run the following:

```console
sudo docker exec -i -t fastrtps_container /bin/bash
``` 

