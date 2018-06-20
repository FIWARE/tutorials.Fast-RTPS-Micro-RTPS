# Getting started with Fast-RTPS and Micro-RTPS

# Getting started with Fast-RTPS

<p align="justify"> [eprosima](http://www.eprosima.com/) Fast RTPS is a C++ implementation of the RTPS (Real Time Publish Subscribe) protocol, which provides publisher-subscriber communications over unreliable transports such as UDP, 
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
docker build -f Dockerfile_Fast-RTPS -t fastrtps:v1 .
```

This will (after some time) build the Docker image to your host machine. How you can run it in a Docker container with:

```console
docker run -i -t --name fastrtps_container fastrtps:v1 bin/bash
```


### Example usage

At this point, you have Fast-RTPS installed in the Docker entrainer environment. We can now run a _HelloWorld_ example. In the example, we will send a set of messages from a publisher to a subscriber using Fast-RTPS protocol, as shown in the figure. 

<img src="https://github.com/flemic/tutorials.Fast-RTPS/blob/master/schema1.png" width="600" class="center">

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

Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. For more information, please refer to the [official documentation](http://eprosima-fast-rtps.readthedocs.io/en/latest/) of Fast-RTPS.

# Getting started with Micro-RTPS

<p align="justify"> eprosima Micro-RTPS is a software solution that provides publisher-subscriber communication between eXtremely Resource Constrained Environments (XRCEs) and a DDS network. In particular, Micro-RTPS implements a client-server protocol to enable resource-constrained devices (clients) to take part in DDS communications. Micro-RTPS agent (server) enables possible this communication by acting behalf of Micro-RTPS clients and enabling them to take part as DDS publishers and/or subscribers in the DDS Global Data Space.
</p>

## Installation Guide

You can install Micro-RTPS with all its dependencies from the precompiled Docker image. You will first need Docker:

### Prerequisites

To keep things simple both components will be run using [Docker](https://www.docker.com). **Docker** is a
container technology which allows to different components isolated into their respective environments. 

* To install Docker on Windows follow the instructions [here](https://docs.docker.com/docker-for-windows/)
* To install Docker on Mac follow the instructions [here](https://docs.docker.com/docker-for-mac/)
* To install Docker on Linux follow the instructions [here](https://docs.docker.com/install/)

The goal of this tutorial is to provide you with a simple _getting started_ guide on how to install and use Micro-RTPS. In the consequent tutorial we will discuss how Micro-RTPS (and therefore ROS2) can be connected to the Orion Context Broker using FIROS2.

### Installation

Now you can proceed with the installation.

```console
git clone https://github.com/flemic/tutorials.Fast-RTPS
cd tutorials.Fast-RTPS
docker build -f Dockerfile_Micro-RTPS -t micrortps:v1 .
```

This will (after some time) build the Docker image to your host machine. How you can run it in a Docker container with:

```console
docker run -i -t --name micrortps_container micrortps:v1 bin/bash
```


### Example usage

At this point, you have Micro-RTPS installed in the Docker entrainer environment. We can now run a _HelloWorld_ example. In the example, we will send a set of messages from a Micro-RTPS publisher to a Micro-RTPS subscriber through a Micro-RTPS agent, as shown in the figure. 

<img src="https://github.com/flemic/tutorials.Fast-RTPS/blob/master/schema2.png" width="600" class="center">

We first have to start the Micro-RTPS agent which will received messages sent by the Micro-RTPS publisher and forward them to the subscriber. In order to do that, execute the following commands, which will result in the Micro-RTPS agent being started on UDP port 2018:

```console
cd /usr/local/bin
MicroRTPSAgent udp 2018
```

Now we will need two more terminals in our Docker environment. In one of the terminals, we will start the Micro-RTPS publisher, while in the other we will start the subscriber. To open second and third terminals, open two bash terminals and in both of them run the following:

```console
docker exec -i -t micrortps_container /bin/bash
``` 

First we start a subscriber:

```console
cd /usr/local/examples/micrortps/SubscribeHelloWorldClient/bin/
./PublishHelloWorldClient udp 127.0.0.1 2018
```

Then we start the publisher in the other terminal:

```console
cd /usr/local/examples/micrortps/PublishHelloWorldClient/bin/
/SubscribeHelloWorldClient udp 127.0.0.1 2018
```

The messages should be automatically sent by the publisher and received by the subscriber. If everything is OK, in your publisher and subscriber terminals respectively you should see something like:

```console
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
Send topic: Hello DDS world!, count: 1
Send topic: Hello DDS world!, count: 2
Send topic: Hello DDS world!, count: 3
Send topic: Hello DDS world!, count: 4
Send topic: Hello DDS world!, count: 5
Send topic: Hello DDS world!, count: 6
Send topic: Hello DDS world!, count: 7
Send topic: Hello DDS world!, count: 8
...
```


```console
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
Receive topic: Hello DDS world!, count: 1
Receive topic: Hello DDS world!, count: 2
Receive topic: Hello DDS world!, count: 3
Receive topic: Hello DDS world!, count: 4
Receive topic: Hello DDS world!, count: 5
Receive topic: Hello DDS world!, count: 6
Receive topic: Hello DDS world!, count: 7
Receive topic: Hello DDS world!, count: 8
...
```

Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. For more information, please refer to the [official documentation](http://micro-rtps.readthedocs.io/en/latest/) of Micro-RTPS.
