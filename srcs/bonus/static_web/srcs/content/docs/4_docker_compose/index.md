---
title: 'Docker Compose'
date: 2019-02-11T19:27:37+10:00
weight: 5
---
**1\. Overview**
----------------

When using Docker extensively, the management of several different containers quickly becomes cumbersome.

Docker Compose is a tool that helps us overcome this problem and **easily handle multiple containers at once.**

In this tutorial, we'll examine its main features and powerful mechanisms.

**2\. The YAML Configuration Explained**
----------------------------------------

In short, Docker Compose works by applying many rules declared within **a single _docker-compose.yml_ configuration file**.

These [YAML](https://en.wikipedia.org/wiki/YAML) rules, both human-readable and machine-optimized, provide an effective way to snapshot the whole project from ten-thousand feet in a few lines.

freestar.config.enabled\_slots.push({ placementName: "baeldung\_leaderboard\_mid\_1", slotId: "baeldung\_leaderboard\_mid\_1" });

Almost every rule replaces a specific Docker command, so that in the end, we just need to run:
```
    docker-compose up
```
We can get dozens of configurations applied by Compose under the hood. This will save us the hassle of scripting them with Bash or something else.

In this file, we need to specify the _version_ of the Compose file format, at least one _service_, and optionally _volumes_ and _networks_:
```
    version: "3.7"
    services:
      ...
    volumes:
      ...
    networks:
      ...
```    

Let's see what these elements actually are.

### **2.1. Services**

First of all, **_services_ refer to the containers' configuration**.

freestar.config.enabled\_slots.push({ placementName: "baeldung\_leaderboard\_mid\_2", slotId: "baeldung\_leaderboard\_mid\_2" });

For example, let's take a dockerized web application consisting of a front end, a back end, and a database. We'd likely split these components into three images, and define them as three different services in the configuration:
```
    services:
      frontend:
        image: my-vue-app
        ...
      backend:
        image: my-springboot-app
        ...
      db:
        image: postgres
        ...
```    

There are multiple settings that we can apply to services, and we'll explore them in more detail later on.

### **2.2. Volumes & Networks**

_Volumes_, on the other hand, are physical areas of disk space shared between the host and a container, or even between containers. In other words, **a volume is a shared directory in the host**, visible from some or all containers.

Similarly, **_networks_ define the communication rules between containers, and between a container and the host**. Common network zones will make the containers' services discoverable by each other, while private zones will segregate them in virtual sandboxes.

Again, we'll learn more about them in the next section.

freestar.config.enabled\_slots.push({ placementName: "baeldung\_leaderboard\_mid\_3", slotId: "baeldung\_leaderboard\_mid\_3" });

**3\. Dissecting a Service**
----------------------------

Now let's begin to inspect the main settings of a service.

### **3.1. Pulling an Image**

Sometimes, the image we need for our service has already been published (by us or by others) in [Docker Hub](https://hub.docker.com/), or another Docker Registry.

If that's the case, then we refer to it with the _image_ attribute by specifying the image name and tag:
```
    services: 
      my-service:
        image: ubuntu:latest
        ...
```    

### **3.2. Building an Image**

Alternatively, we might need to [build](https://docs.docker.com/compose/compose-file/#build) an image from the source code by reading its _Dockerfile_.

This time, we'll use the _build_ keyword, passing the path to the Dockerfile as the value:
```
    services: 
      my-custom-app:
        build: /path/to/dockerfile/
        ...
```    

We can also [use a URL](https://gist.github.com/derianpt/420617ffa5d2409f9d2a4a1a60cfa9ae#file-build-contexts-yml) instead of a path:
```
    services: 
      my-custom-app:
        build: https://github.com/my-company/my-project.git
        ...
```    

Additionally, we can specify an _image_ name in conjunction with the _build_ attribute, which will name the image once created, [making it available for use by other services](https://stackoverflow.com/a/35662191/1654265):
```
    services: 
      my-custom-app:
        build: https://github.com/my-company/my-project.git
        image: my-project-image
        ...
```    

### **3.3. Configuring the Networking**

**Docker containers communicate between themselves in networks created, implicitly or through configuration, by Docker Compose**. A service can communicate with another service on the same network by simply referencing it by the container name and port (for example _network-example-service:80_), provided that we've made the port accessible through the _expose_ keyword:

freestar.config.enabled\_slots.push({ placementName: "baeldung\_incontent\_1", slotId: "baeldung\_incontent\_1" });
```
    services:
      network-example-service:
        image: karthequian/helloworld:latest
        expose:
          - "80"
```    

In this case, it would also work without exposing it because the _expose_ directive is already in [the image Dockerfile](https://github.com/karthequian/docker-helloworld/blob/master/Dockerfile#L45).

**To reach a container from the host**, **the ports must be exposed declaratively through the _ports_ keyword**, which also allows us to choose if we're exposing the port differently in the host:
```
    services:
      network-example-service:
        image: karthequian/helloworld:latest
        ports:
          - "80:80"
        ...
      my-custom-app:
        image: myapp:latest
        ports:
          - "8080:3000"
        ...
      my-custom-app-replica:
        image: myapp:latest
        ports:
          - "8081:3000"
        ...
```    

Port 80 will now be visible from the host, while port 3000 of the other two containers will be available on ports 8080 and 8081 in the host. **This powerful mechanism allows us to run different containers exposing the same ports without collisions**.

Finally, we can define additional virtual networks to segregate our containers:
```
    services:
      network-example-service:
        image: karthequian/helloworld:latest
        networks: 
          - my-shared-network
        ...
      another-service-in-the-same-network:
        image: alpine:latest
        networks: 
          - my-shared-network
        ...
      another-service-in-its-own-network:
        image: alpine:latest
        networks: 
          - my-private-network
        ...
    networks:
      my-shared-network: {}
      my-private-network: {}
```    

In this last example, we can see that _another-service-in-the-same-network_ will be able to ping and reach port 80 of _network-example-service_, while _another-service-in-its-own-network_ won't.

### **3.4. Setting Up the Volumes**

There are three types of volumes: [_anonymous_, _named_, and _host_](https://success.docker.com/article/different-types-of-volumes).

**Docker manages both anonymous and named volumes**, automatically mounting them in self-generated directories in the host. While anonymous volumes were useful with older versions of Docker (pre 1.9), named ones are now the suggested way to go. **Host volumes also allow us to specify an existing folder in the host.**

We can configure host volumes at the service level, and named volumes in the outer level of the configuration, in order to make the latter visible to other containers, rather than only to the one they belong:

freestar.config.enabled\_slots.push({ placementName: "baeldung\_incontent\_2", slotId: "baeldung\_incontent\_2" });
```
    services:
      volumes-example-service:
        image: alpine:latest
        volumes: 
          - my-named-global-volume:/my-volumes/named-global-volume
          - /tmp:/my-volumes/host-volume
          - /home:/my-volumes/readonly-host-volume:ro
        ...
      another-volumes-example-service:
        image: alpine:latest
        volumes:
          - my-named-global-volume:/another-path/the-same-named-global-volume
        ...
    volumes:
      my-named-global-volume: 
```    

Here, both containers will have read/write access to the _my-named-global-volume_ shared folder, regardless of which path they've mapped it to. Instead, the two host volumes will be available only to _volumes-example-service_.

The _/tmp_ folder of the host's file system is mapped to the _/my-volumes/host-volume_ folder of the container. This portion of the file system is writeable, which means that the container can read and also write (and delete) files in the host machine.

**We can mount a volume in read-only mode by appending _:ro_** to the rule, like for the _/home_ folder (we don't want a Docker container erasing our users by mistake).

### **3.5. Declaring the Dependencies**

Often, we need to create a dependency chain between our services so that some services get loaded before (and unloaded after) other ones. We can achieve this result through the _depends\_on_ keyword:
```
    services:
      kafka:
        image: wurstmeister/kafka:2.11-0.11.0.3
        depends_on:
          - zookeeper
        ...
      zookeeper:
        image: wurstmeister/zookeeper
        ...
```    

We should be aware, however, that Compose won't wait for the _zookeeper_ service to finish loading before starting the _kafka_ service; it'll simply wait for it to start. If we need a service to be fully loaded before starting another service, we need to get [deeper control of the startup and shutdown order in Compose](https://docs.docker.com/compose/startup-order/).

**4\. Managing Environment Variables**
--------------------------------------

Working with environment variables is easy in Compose. We can define static environment variables, as well as dynamic variables, with the _${}_ notation:
```
    services:
      database: 
        image: "postgres:${POSTGRES_VERSION}"
        environment:
          DB: mydb
          USER: "${USER}"
```    

There are different methods to provide those values to Compose.

For example, one method  is setting them in a _.env_ file in the same directory, structured like a _.properties_ file, _key=value_:

freestar.config.enabled\_slots.push({ placementName: "baeldung\_incontent\_3", slotId: "baeldung\_incontent\_3" });
```
    POSTGRES_VERSION=alpine
    USER=foo
```
Otherwise, we can set them in the OS before calling the command:
```
    export POSTGRES_VERSION=alpine
    export USER=foo
    docker-compose up
``` 

Finally, we might find it easy to use a simple one-liner in the shell:
```
    POSTGRES_VERSION=alpine USER=foo docker-compose up
``` 

We can mix the approaches, but let's keep in mind that Compose uses the following priority order, overwriting the less important with the higher priorities:

1.  Compose file
2.  Shell environment variables
3.  Environment file
4.  Dockerfile
5.  Variable not defined

**5\. Scaling & Replicas**
--------------------------

In older Compose versions, we were allowed to scale the instances of a container through the [_docker-compose scale_](https://docs.docker.com/compose/reference/scale/) command. Newer versions deprecated it, and replaced it with the _–__–__scale_ option.

We can exploit [Docker Swarm](https://docs.docker.com/engine/swarm/), a cluster of Docker Engines, and autoscale our containers declaratively through the _replicas_ attribute of the _deploy_ section:
```
    services:
      worker:
        image: dockersamples/examplevotingapp_worker
        networks:
          - frontend
          - backend
        deploy:
          mode: replicated
          replicas: 6
          resources:
            limits:
              cpus: '0.50'
              memory: 50M
            reservations:
              cpus: '0.25'
              memory: 20M
          ...
```    

Under _deploy,_ we can also specify many other options, like the resources thresholds. Compose, however, **considers the whole _deploy_ section only when deploying to Swarm**, and ignores it otherwise.

**6\. A Real-World Example: Spring Cloud Data Flow**
----------------------------------------------------

While small experiments help us understand the single gears, seeing the real-world code in action will definitely unveil the big picture.

Spring Cloud Data Flow is a complex project, but simple enough to be understandable. Let's [download its YAML file](https://dataflow.spring.io/docs/installation/local/docker/) and run:

freestar.config.enabled\_slots.push({ placementName: "baeldung\_incontent\_4", slotId: "baeldung\_incontent\_4" });
```
    DATAFLOW_VERSION=2.1.0.RELEASE SKIPPER_VERSION=2.0.2.RELEASE docker-compose up 
```    

Compose will download, configure, and start every component, and then **intersect the container's logs into a single flow in the current terminal**.

It'll also apply unique colors to each one of them for a great user experience:

[![Screenshot-from-2019-05-22-01-37-52](/images/Screenshot-from-2019-05-22-01-37-52-1024x576.png)](/images/Screenshot-from-2019-05-22-01-37-52.png)

We might get the following error running a brand new Docker Compose installation:
```
    lookup registry-1.docker.io: no such host
```
While [there are different solutions](https://stackoverflow.com/questions/46036152/lookup-registry-1-docker-io-no-such-host) to this common pitfall, using _8.8.8.8_ as DNS is probably the simplest.

**7\. Lifecycle Management**
----------------------------

Now let's take a closer look at the syntax of Docker Compose:
```
    docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]
```    

While there are [many options and commands available](https://docs.docker.com/compose/reference/overview/), we need to at least know the ones to activate and deactivate the whole system correctly.

### **7.1. Startup**

We've seen that we can create and start the containers, the networks, and the volumes defined in the configuration with _up_:
```
    docker-compose up
```
After the first time, however, we can simply use _start_ to start the services:

freestar.config.enabled\_slots.push({ placementName: "baeldung\_incontent\_5", slotId: "baeldung\_incontent\_5" });
```
    docker-compose start
```
If our file has a different name than the default one (_docker-compose.yml_), we can exploit the _\-f_ and _–__–__file_ flags to specify an alternate file name:

    docker-compose -f custom-compose-file.yml start

Compose can also run in the background as a daemon when launched with the _\-d_ option:
```
    docker-compose up -d
```
### **7.2. Shutdown**

To safely stop the active services, we can use _stop_, which will preserve containers, volumes, and networks, along with every modification made to them:
```
    docker-compose stop
```
To reset the status of our project, we can simply run _down_, **which will destroy everything with the exception of external volumes**:
```
    docker-compose down
```