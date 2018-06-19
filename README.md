# Getting started with Fast-RTPS

<p align="justify"> eprosima Fast RTPS is a C++ implementation of the RTPS (Real Time Publish Subscribe) protocol, which provides publisher-subscriber communications over unreliable transports such as UDP, 
as defined and maintained by the Object Management Group (OMG) consortium. RTPS is also the wire interoperability protocol defined for the Data Distribution
Service (DDS) standard, again by the OMG. eProsima Fast RTPS holds the benefit of being standalone and up-to-date, as most vendor solutions either implement RTPS as a tool to implement DDS or use past versions of the specification.
</p>

Some of the main features of this library are:

* Configurable best-effort and reliable publish-subscribe communication policies for real-time applications.
* Plug and play connectivity so that any new applications are automatically discovered by any other members of the network.
* Modularity and scalability to allow continuous growth with complex and simple devices in the network.
* Configurable network behavior and interchangeable transport layer: Choose the best protocol and system input/output channel combination for each deployment.
* Two API Layers: a high-level Publisher-Subscriber one focused on usability and a lower-level Writer-Reader one that provides finer access to the inner workings of the RTPS protocol.

eProsima Fast RTPS has been adopted by multiple organizations in many sectors including these important cases:

* Robotics: ROS (Robotic Operating System) as their default middleware for ROS2.
* EU R&D: FIWARE Incubated GE.

The goal of this tutorial is to provide you with a simple _getting started_ guide on how to install and use Fast-RTPS. In the consequent tutorial we will discuss how Fast-RTPS (and therefore ROS2) can be connected to the Orion Context Broker using FIROS2.

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
cd tutorials.Fast-RTPS
docker build -t fastrtps:v1 .
```

This will (after some time) build the Docker image to your host machine. How you can run it in a Docker container with:

```console
docker run -i -t --name fastrtps_container fastrtps:v1 bin/bash
```


### Example usage

At this point, you have Fast-RTPS installed in the Docker entrainer environment. We can now run a _HelloWorld_ example. In the example, we will send a set of messages from a publisher to a subscriber using Fast-RTPS protocol, as shown in the figure. 

<img src="https://github.com/flemic/tutorials.Fast-RTPS/blob/master/schema.png" width="200">

First navigate to the _HelloWorld_ example folder:

```console
cd home/Fast-RTPS/examples/C++/HelloWorldExample/
```

To compile the example, do the usual:

```console
cmake . 
make 
make install
```

Now we will need a second terminal in our Docker environment. In one of the terminals, we will start the publisher, while in the other we will start the subscriber. To open a second terminal, open a bash terminal and run the following:

```console
docker exec -i -t fastrtps_container /bin/bash
cd home/Fast-RTPS/examples/C++/HelloWorldExample/
``` 

First we start a subscriber:

```console
./HelloWorldExample subscriber
```

Then we start the publisher in the other terminal:

```console
./HelloWorldExample publisher
```

The messages should be automatically sent by the publisher and received by the subscriber. If everything is OK, in your publisher and subscriber terminals respectively you should see something like:

```console
Starting 
Publisher matched
Message: HelloWorld with index: 1 SENT
Message: HelloWorld with index: 2 SENT
Message: HelloWorld with index: 3 SENT
Message: HelloWorld with index: 4 SENT
Message: HelloWorld with index: 5 SENT
Message: HelloWorld with index: 6 SENT
Message: HelloWorld with index: 7 SENT
Message: HelloWorld with index: 8 SENT
Message: HelloWorld with index: 9 SENT
Message: HelloWorld with index: 10 SENT
```


```console
Subscriber matched
Message HelloWorld 1 RECEIVED
Message HelloWorld 2 RECEIVED
Message HelloWorld 3 RECEIVED
Message HelloWorld 4 RECEIVED
Message HelloWorld 5 RECEIVED
Message HelloWorld 6 RECEIVED
Message HelloWorld 7 RECEIVED
Message HelloWorld 8 RECEIVED
Message HelloWorld 9 RECEIVED
Message HelloWorld 10 RECEIVED
Subscriber unmatched
```

Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. For more information, please refer to the official documentation of Fast-RTPS: http://eprosima-fast-rtps.readthedocs.io/en/latest/.

