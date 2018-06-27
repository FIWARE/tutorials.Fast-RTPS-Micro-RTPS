[![FIWARE Banner](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/fiware.png)](https://www.fiware.org/developers)

This is an Introductory Tutorial to the [Fast-RTPS](https://eprosima-fast-rtps.readthedocs.io) and [Micro-RTPS](http://micro-rtps.readthedocs.io) protocols for RTPS (Real Time Publish Subscribe) as used in robotics and extremely constrained devices.
The enablers of the FIWARE platform are not directly involved at this low level of communication but a complete understanding of the protocols is required before proceeding to connect robotic devices to the FIWARE System.

The tutorial introduces a series of exercises which can be run directly from within a [Docker](https://www.docker.com) container, no HTTP calls are required.

* このチュートリアルは[日本語](README.ja.md)でもご覧いただけます。

# Contents

- [What is Fast-RTPS?](#what-is-fast-rtps)
- [What is Micro-RTPS?](#what-is-micro-rtps)
- [Prerequisites](#prerequisites)
  * [Docker](#docker)
  * [Cygwin](#cygwin)
- [Start Up](#start-up)
- [Introduction to Fast-RTPS](#introduction-to-fast-rtps)
  * [Example usage](#example-usage)
    + [Make the examples (:one:st Terminal)](#make-the-examples-onest-terminal)
    + [Start the Fast-RTPS Subscriber (:one:st Terminal)](#start-the-fast-rtps-subscriber-onest-terminal)
    + [Start the Fast-RTPS Publisher (:two:nd Terminal)](#start-the-fast-rtps-publisher-twond-terminal)
- [Introduction to Micro-RTPS](#introduction-to-micro-rtps)
  * [Example usage](#example-usage-1)
    + [Start the Micro-RTPS Agent (:one:st Terminal)](#start-the-micro-rtps-agent-onest-terminal)
    + [Start the Micro-RTPS Subscriber (:two:nd Terminal)](#start-the-micro-rtps-subscriber-twond-terminal)
    + [Start the Micro-RTPS Publisher (:three:rd Terminal)](#start-the-micro-rtps-publisher-threerd-terminal)
- [Next Steps](#next-steps)



# What is Fast-RTPS?

[eProsima](http://www.eprosima.com/) [Fast-RTPS](https://eprosima-fast-rtps.readthedocs.io) is a C++ implementation of the RTPS (Real Time Publish Subscribe) protocol, which provides publisher-subscriber communications over unreliable transports such as UDP, 
as defined and maintained by the Object Management Group (OMG) consortium. RTPS is also the wire interoperability protocol defined for the Data Distribution
Service (DDS) standard, again by the OMG. eProsima Fast RTPS holds the benefit of being standalone and up-to-date, as most vendor solutions either implement RTPS as a tool to implement DDS or use past versions of the specification.

Some of the main features of this library are:

* Configurable best-effort and reliable publish-subscribe communication policies for real-time applications.
* Plug and play connectivity so that any new applications are automatically discovered by any other members of the network.
* Modularity and scalability to allow continuous growth with complex and simple devices in the network.
* Configurable network behavior and interchangeable transport layer: Choose the best protocol and system input/output channel combination for each deployment.
* Two API Layers: a high-level Publisher-Subscriber one focused on usability and a lower-level Writer-Reader one that provides finer access to the inner workings of the RTPS protocol.

eProsima Fast RTPS has been adopted by multiple organizations in many sectors including these important cases:

* Robotics: ROS (Robotic Operating System) as their default middleware for ROS2.
* EU R&D: FIWARE Incubated GE.

# What is Micro-RTPS?

[eProsima](http://www.eprosima.com/) [Micro-RTPS](http://micro-rtps.readthedocs.io) protocols for RTPS (Real Time Publish Subscribe) as used in robotics and extremely constrained devices, which is a software solution that provides publisher-subscriber communication between eXtremely Resource Constrained Environments (XRCEs) and a DDS network. In particular, Micro-RTPS implements a client-server protocol to enable resource-constrained devices (clients) to take part in DDS communications. Micro-RTPS agent (server) enables possible this communication by acting behalf of Micro-RTPS clients and enabling them to take part as DDS publishers and/or subscribers in the DDS Global Data Space.


# Prerequisites

## Docker

To keep things simple both components will be run using [Docker](https://www.docker.com). **Docker** is a
container technology which allows to different components isolated into their respective environments. 

* To install Docker on Windows follow the instructions [here](https://docs.docker.com/docker-for-windows/)
* To install Docker on Mac follow the instructions [here](https://docs.docker.com/docker-for-mac/)
* To install Docker on Linux follow the instructions [here](https://docs.docker.com/install/)

**Docker Compose** is a tool for defining and running multi-container Docker applications. A 
[YAML file](https://raw.githubusercontent.com/Fiware/tutorials.Entity-Relationships/master/docker-compose.yml) is used
configure the required services for the application. This means all container services can be brought up in a single 
command. Docker Compose is installed by default as part of Docker for Windows and  Docker for Mac, however Linux users 
will need to follow the instructions found  [here](https://docs.docker.com/compose/install/)

## Cygwin 

We will start up our services using a simple bash script. Windows users should download [cygwin](http://www.cygwin.com/) to provide a
command line functionality similar to a Linux distribution on Windows. 


# Start Up

To start the installation, do the following:

```console
git clone git@github.com:Fiware/tutorials.Fast-RTPS-Micro-RTPS.git

./services create
``` 

>**Note** The initial creation of Docker images can take up to fifteen minutes


Thereafter, all services can be initialized from the command line by running the [services](https://github.com/Fiware/tutorials.Fast-RTPS-Micro-RTPS/blob/master/services) Bash script provided within the repository:

```console
./services start
``` 

>:information_source: **Note:** If you want to clean up and start over again you can do so with the following command:
>
>```console
>./services stop
>``` 
>


# Introduction to Fast-RTPS

The goal of this section is to provide you with a simple getting started guide on how to install and use Fast-RTPS. 
In the subsequent tutorials we will discuss how Fast-RTPS (and therefore ROS2) can be connected to the Orion Context
Broker using FIROS2.


## Example usage

At this point, you have Fast-RTPS installed in the Docker container environment. We can now run a **Hello World** example. In the example, we will send a set of messages from a publisher to a subscriber using the Fast-RTPS protocol, as shown in the figure. 

![](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/fast-rtps-schema.png)


### Make the examples (:one:st Terminal)

Open a new terminal and enter the running `examples-fast-rtps` Docker container with:

```console
docker exec -ti examples-fast-rtps /bin/bash
```

To compile the example, do the usual:

```console
cmake . 
make 
make install
```

### Start the Fast-RTPS Subscriber (:one:st Terminal)

First we start a subscriber:

```console
./HelloWorldExample subscriber
```

#### :one:st terminal - Result:

The Fast-RTPS Subscriber has started and is awaiting messages:

```
Starting 
Subscriber running. Please press enter to stop the Subscriber
```


### Start the Fast-RTPS Publisher (:two:nd Terminal)

Open a **second new terminal** and enter the running `examples-fast-rtps` Docker container with:

```console
docker exec -ti examples-fast-rtps /bin/bash
```

Then we start the publisher in this second terminal:

```console
./HelloWorldExample publisher
```

The messages should be automatically sent by the publisher and received by the subscriber. If everything is OK, in your publisher and subscriber terminals respectively you should see something like:


#### :one:st terminal - Result:

The Fast-RTPS Subscriber has received a series of messages:

```
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

#### :two:nd terminal - Result:

The Fast-RTPS Publisher sends a series of messages:

```
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


You can stop the Fast-RTPS Subscriber in the :one:st terminal by pressing `<enter>`

To leave the containers and end interactive mode, run the following in each terminal.

```console
exit
```
 You will then return to the command line.

Other examples are available in the `examples` folder, which are beyond the scope of this tutorial. For more information, please refer to the [official Fast-RTPS documentation](http://eprosima-fast-rtps.readthedocs.io/en/latest/).

# Introduction to Micro-RTPS

The goal of this section is to provide you with a simple getting started guide on how to install and use Micro-RTPS. 


## Example usage

At this point, you have Micro-RTPS installed in the Docker container environment. We can now run a **Hello World** example. In the example, we will send a set of messages from a Micro-RTPS publisher to a Micro-RTPS subscriber through a Micro-RTPS agent, as shown in the figure. 

![](https://fiware.github.io/tutorials.Fast-RTPS-Micro-RTPS/img/micro-rtps-schema.png)


### Start the Micro-RTPS Agent (:one:st Terminal)

Open a new terminal and enter the running `examples-micro-rtps` Docker container with:

```console
docker exec -ti examples-micro-rtps /bin/bash
```

We first have to start the Micro-RTPS agent which will received messages sent by the Micro-RTPS publisher and forward them to the subscriber. In order to do that, execute the following commands, which will result in the Micro-RTPS agent being started on UDP port `2018`:

```console
cd /usr/local/bin
MicroRTPSAgent udp 2018
```

#### :one:st terminal - Result:

The Micro-RTPS Agent is up and running

```
UDP agent initialization... OK
Running DDS-XRCE Agent...
```


Now we will need two more terminals in our Docker environment. In one of the terminals, we will start the Micro-RTPS publisher, while in the other we will start the subscriber. To open second and third terminals, open two bash terminals and in both of them run the following:

### Start the Micro-RTPS Subscriber (:two:nd Terminal)

Open a **second new terminal** and enter the running `examples-micro-rtps` Docker container with:

```console
docker exec -ti examples-micro-rtps /bin/bash
```

We start a subscriber as shown:

```console
cd /usr/local/examples/micrortps/SubscribeHelloWorldClient/bin/
./SubscribeHelloWorldClient udp 127.0.0.1 2018
```

#### :two:nd terminal - Result:

The Micro-RTPS Subscriber is running and awaiting messages

```
<< UDP mode => ip: 127.0.0.1 - port: 2018 >>
```

### Start the Micro-RTPS Publisher (:three:rd Terminal)

Open a **third new terminal** and enter the running `examples-micro-rtps` Docker container with:

```console
docker exec -ti examples-micro-rtps /bin/bash
```

Then we start the publisher in the third terminal:

```console
cd /usr/local/examples/micrortps/PublishHelloWorldClient/bin/
./PublishHelloWorldClient udp 127.0.0.1 2018
```

The messages should be automatically sent by the publisher and received by the subscriber. If everything is OK, in your publisher and subscriber terminals respectively you should see something like:


#### :one:st terminal - Result:

The Micro-RTPS Agent has started receiving messages from the Publisher

```
UDP agent initialization... OK
Running DDS-XRCE Agent...
RTPS Publisher matched
...
```

#### :two:nd terminal - Result:

The Micro-RTPS Subscriber has received the messages passed on by the Micro-RTPS Agent 

```
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

#### :three:rd terminal - Result:

The Micro-RTPS Publisher has sent a series of messages as shown:

```
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




To leave the containers and end interactive mode, run the following:

```console
exit
```

 You will then return to the command line.



Other examples are available in the _examples_ folder, which are beyond the scope of this tutorial. For more information, please refer to the [official Micro-RTPS documentation](http://micro-rtps.readthedocs.io/en/latest/).





# Next Steps

Want to learn how to add more complexity to your application by adding advanced features?
You can find out by reading the other tutorials in this series:

&nbsp; 101. [Getting Started](https://github.com/Fiware/tutorials.Getting-Started)<br/>
&nbsp; 102. [Entity Relationships](https://github.com/Fiware/tutorials.Entity-Relationships)<br/>
&nbsp; 103. [CRUD Operations](https://github.com/Fiware/tutorials.CRUD-Operations)<br/>
&nbsp; 104. [Context Providers](https://github.com/Fiware/tutorials.Context-Providers)<br/>
&nbsp; 105. [Altering the Context Programmatically](https://github.com/Fiware/tutorials.Accessing-Context)<br/> 
&nbsp; 106. [Subscribing to Changes in Context](https://github.com/Fiware/tutorials.Subscriptions)<br/>

&nbsp; 201. [Introduction to IoT Sensors](https://github.com/Fiware/tutorials.IoT-Sensors)<br/>
&nbsp; 202. [Provisioning an IoT Agent](https://github.com/Fiware/tutorials.IoT-Agent)<br/>
&nbsp; 203. [IoT over MQTT](https://github.com/Fiware/tutorials.IoT-over-MQTT)<br/>
&nbsp; 250. [Introduction to Fast-RTPS and Micro-RTPS ](https://github.com/Fiware/tutorials.Fast-RTPS-Micro-RTPS)<br/>
&nbsp; 301. [Persisting Context Data](https://github.com/Fiware/tutorials.Historic-Context)<br/>
&nbsp; 302. [Querying Time Series Data](https://github.com/Fiware/tutorials.Short-Term-History)<br/>
