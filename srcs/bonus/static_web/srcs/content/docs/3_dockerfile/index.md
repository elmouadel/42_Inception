---
title: 'Dockerfile'
date: 2019-02-11T19:27:37+10:00
weight: 5
---
What is Dockerfile?
-------------------

A **dockerfile** is a text document that contains a set of instructions to create a docker image. Docker builds images by reading the instructions from a Dockerfile.

With the help of dockerfile, docker images get created, and docker containers get created with the help of docker images. I have tried to explain to same with the below image.

![dockerfile tutorial for beginners](/images/docker.png)

dockerfile

Now we know what dockerfile is. Let’s proceed further and understand why we need to write a dockerfile.

Why a dockerfile is required?
-----------------------------

There are so many docker images readily available in [dockerhub](https://hub.docker.com/), so why anyone needs to create a dockerfile? The most straightforward answer to this question is to create a dockerfile if existing docker images do not fulfill your project requirement, which happens most of the time.

And it might be possible that the dockerfile someone else has written has contained some venerability, so the recommendation is to write your dockerfile instead of relying on someone else dockerfile.

General syntex of dockerfile
----------------------------

The general syntax of dockerfile follows the below pattern
```
\# Comment
INSTRUCTION arguments
```

Lines that begin with a hash, or pound, symbol (#) are comments.

INSTRUCTION represents the keyword in the dockerfile. Instructions are not case-sensitive, but the convention is to make instructions all uppercase to improve visibility.

The first non-comment instruction must be a FROM instruction which specifies the base image to use. Dockerfile instructions are executed into a new container using this base image. The execution order of instructions in the order of their appearance in the Dockerfile.

The instruction is not case-sensitive. However, the convention is to use UPPERCASE to distinguish keywords from arguments more easily.

There are so many keywords available in the dockerfile. Good to have a basic idea about all the keywords before writing a dockerfile.

What is an Instruction in dockerfile?
-------------------------------------

Before writing a dockerfile, it is crucial to understand what makes a dockerfile. Let’s try to understand keywords with the help of the below example:
```
FROM ubuntu:18.04
COPY . /app
RUN make /app
CMD python /app/app.py
```
In the above dockerfile, the keywords FROM, COPY, RUN, and CMD are the instructions we pass while creating a dockerfile. These instructions perform specific tasks based on the order in which it is written, and these instructions are called keywords in the dockerfile. Some of the important instructions are:

### Docker Instructions:

*   FROM
*   ADD
*   COPY
*   ENV
*   EXPOSE
*   LABEL
*   STOPSIGNAL
*   USER
*   VOLUME
*   WORKDIR

It is essential to have a basic understanding of the above keywords before writing a dockerfile. Let’s see a quick explanation of each keyword.

#### FROM

Every dockerfile should start with FROM keyword. In the FROM keyword, we specify the base image to be used. It is always recommended to use a small base image. Follow this blog to learn more about [which base image to use while creating a dockerfile](https://naiveskill.com/docker-base-image/).

The general syntax for FROM keyword is
```
FROM <base-image-name>:tag
```
#### ADD

The ADD instruction used to copy a directory(one or more) from the source and add it to the filesystem of the image at the path `<dest>`. We can also specify wildcards to copy entire files from a directory.

To copy all files from the test directory to /var in the docker container.
```
ADD hom\* /mydir/
```
#### COPY

The COPY instruction copies files or directories and adds them to the container filesystem at the path. Similar to ADD command, we can specify multiple source path files.

Syntex
```
COPY \[--chown=&lt;user&gt;:&lt;group&gt;\] &lt;src&gt;... &lt;dest&gt;
COPY \[--chown=&lt;user&gt;:&lt;group&gt;\] \["&lt;src&gt;",... "&lt;dest&gt;"\]
```
#### Difference between COPY and ADD

Most beginners are always confused between COPY And ADD. Since both ADD and COPY are functionally similar, but generally, COPY is preferred. That’s because it’s more transparent than ADD.

The COPY command supports the basic copying of local files into the container, while ADD has some features (like local-only tar extraction and remote URL support).

#### ENV

With the help of the **ENV** Instruction, you can set up the environment variables. You can use **ENV** to define the environment variable which will be available in the container.

ENV can also be used to set commonly used version numbers so that version bumps are easier to maintain in the dockerfile.

Consider the below dockerfile where the env variable is used to set up admin\_user
```
FROM alpine
ENV ADMIN\_USER="mark"
RUN echo $ADMIN\_USER &gt; ./mark
RUN unset ADMIN\_USER
```
#### EXPOSE

The expose instruction exposes the ports on which a container listens for connections. The expose command is similar to the -p flag, which we have seen earlier.

We can not expose any random ports; ports should be exposed based on the application we are deploying. i.e., for Nginx, we should expose port 80, and for MongoDB, we should expose port 2017.

Format and usage:
```
FROM ubuntu
RUN apt-get update
RUN apt-get install -y nginx
ENTRYPOINT \[“/usr/sbin/nginx”,”-g”,”daemon off;”
EXPOSE 80
```
#### LABEL

You can add labels in the dockerfile to manage projects, add license information, or any other reason. You can add more than one label in the dockerfile. The following example shows the use of label keywords.
```
LABEL com.example.version="0.0.1-beta"
LABEL vendor1="ACME Incorporated"
LABEL vendor2=ZENITH\\ Incorporated
LABEL com.example.release-date="2015-02-12"
LABEL com.example.version.is-production=""
```
#### USER

Use user instructions to change a non-root user. It is always good not to run any services with the root user.

We can also use RUN or CMD instructions along with theUSER command.

#### VOLUME

`VOLUME` Instruction is used to expose any database storage, configuration storage, or files/folders created by your docker container. It is always encouraged to use `VOLUME` for any mutable user-serviceable parts of your image.

#### WORKDIR

You can set up a working directory by using WORKDIR instructions. For reliability and clarity, always use the absolute path for your WORKDIR. The following example shows the use of WORKDIR.
```
WORKDIR /go/src/project/ #Absolute path
```
Now we have a pretty good idea about what various instructions are in the dockerfile. Let’s proceed further and build a docker image using dockerfile

Docker file example
-------------------

In this session, we will be deploying a docker container using a dockerfile.

### Dockerfile alpine example

In this example, we will be creating a docker container using an alpine image, and then we will print the content of /etc/passwd file.

create a folder name dockerfile\_example1, and inside that create a blank file and name it dockerfile
```
mkdir dockerfile\_example1
cd dockerfile\_example1
touch dockerfile
```
Paste the below code into the dockerfile
```
FROM alpine
MAINTAINER naiveskill ([\[email protected\]](/cdn-cgi/l/email-protection))
ENTRYPOINT \["/bin/cat"\]
CMD \["/etc/passwd"\]
```
The explanation for the above dockerfile:

*   From instruction is used to specify the base image which we have used. In this case, we have used alpine as a base image.
*   Maintainer instruction is used to set up the image maintainer name. It’s free to text, and you can type anything in the maintainer.
*   The entrypoint command is used to define the default app you wish to run when the container starts. In this case, we wish to run the cat command
*   With the CMD command, we can specify the list of parameters to the entrypoint command. Here we wish to read the content of /etc/passwd file.

Now go inside the folder where the dockerfile is present and type the below command to build the docker image.
````
docker build -t my-dockerfile1 .
[+] Building 0.7s (5/5) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                   0.1s
 => => transferring dockerfile: 149B                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                                                                                                        0.0s
 => [1/1] FROM docker.io/library/nginx                                                                                                                                                                 0.3s
 => exporting to image                                                                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                                                                0.0s
 => => writing image sha256:ff7a403e93223e6820e919f0e2576921b4957aa8b3237831f9412027ffaf7abd                                                                                                           0.0s
 => => naming to docker.io/library/my-dockerfile1  
````
\-t flag is used to tag the image. In the above example, we have tagged the image with the my-dockerfile1 name.

. at the end of the command signifies that dockerfile is present in the current path.

Now let’s verify if the image gets successfully created by typing the below command.
```
docker images
REPOSITORY       TAG       IMAGE ID       CREATED       SIZE
my-dockerfile1   latest    b2e435c3294c   13 days ago   5.6MB
```
Build the image and run a container as follows:
```
docker run -it my-dockerfile1
root:x:0:0:root:/root:/bin/ash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/mail:/sbin/nologin
news:x:9:13:news:/usr/lib/news:/sbin/nologin
uucp:x:10:14:uucp:/var/spool/uucppublic:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
man:x:13:15:man:/usr/man:/sbin/nologin
postmaster:x:14:12:postmaster:/var/mail:/sbin/nologin
cron:x:16:16:cron:/var/spool/cron:/sbin/nologin
ftp:x:21:21::/var/lib/ftp:/sbin/nologin
sshd:x:22:22:sshd:/dev/null:/sbin/nologin
at:x:25:25:at:/var/spool/cron/atjobs:/sbin/nologin
squid:x:31:31:Squid:/var/cache/squid:/sbin/nologin
xfs:x:33:33:X Font Server:/etc/X11/fs:/sbin/nologin
games:x:35:35:games:/usr/games:/sbin/nologin
cyrus:x:85:12::/usr/cyrus:/sbin/nologin
vpopmail:x:89:89::/var/vpopmail:/sbin/nologin
ntp:x:123:123:NTP:/var/empty:/sbin/nologin
smmsp:x:209:209:smmsp:/var/spool/mqueue:/sbin/nologin
guest:x:405:100:guest:/dev/null:/sbin/nologin
nobody:x:65534:65534:nobody:/:/sbin/nologin
```
### Dockerfile httpd example

This example will use centos as a base image and deploy the httpd service in that container.

Now, create a folder name dockerfile\_example2, and inside that, create a blank file and name it dockerfile
```
mkdir dockerfile\_example2
cd dockerfile\_example2
touch dockerfile
```
Paste the below code into the dockerfile,
```
FROM centos
RUN yum install httpd -y
COPY index.html /var/www/html/

CMD \["/usr/sbin/httpd","-D", "FOREGROUND"\]
EXPOSE 80
```
create another file called index.html and paste the below content in that file.
```
<!DOCTYPE html>
<html>
<body>

<h1>Dockerfile tutorial</h1>
<p>Naiveskill</p>

</body>
</html>
```
Verify if the dockerfile\_example2 folder contains the below files:
```
ls -ltr
total 16
-rw-r--r--  1 XXX  staff  122 Jun 29 23:06 dockerfile
-rw-r--r--  1 XXX  staff   95 Jun 29 23:10 index.html
```
An explanation for the above dockerfile:

*   From instruction is used to specify the base image which you have used. In this case, we have used a centos base image.
*   With RUN instruction we are installing the httpd web service into the docker container.
*   With COPY instruction we are copying the index.html file from local to /var/www/html/ path in the container
*   With the CMD command, we are starting the httpd web service in the background
*   EXPOSE instruction is used to expose port 80 of the container.

Now let’s go inside the dockerfile\_example2 folder and run the below command to build the docker image.
```
docker build -t my-dockerfile2 .
[+] Building 11.3s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                   0.0s
 => => transferring dockerfile: 36B                                                                                                                                                                    0.0s
 => [internal] load .dockerignore                                                                                                                                                                      0.0s
 => => transferring context: 2B                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/centos:latest                                                                                                                                      11.0s
 => [internal] load build context                                                                                                                                                                      0.0s
 => => transferring context: 31B                                                                                                                                                                       0.0s
 => [1/3] FROM docker.io/library/[[email protected]](/cdn-cgi/l/email-protection):5528e8b1b1719d34604c87e11dcd1c0a20bedf46e83b5632cdeac91b8c04efc1                                                                                        0.0s
 => CACHED [2/3] RUN yum install httpd -y                                                                                                                                                              0.0s
 => CACHED [3/3] COPY index.html /var/www/html/                                                                                                                                                        0.0s
 => exporting to image                                                                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                                                                0.0s
 => => writing image sha256:3fad6b6f2f7ab0a5f04d42a574dfbf20d0712fb9ea44fd7521c6adeb97c2b173                                                                                                           0.0s
 => => naming to docker.io/library/my-dockerfile2                                                                                                                                                      0.0s
```
\-t flag is used to tag the image. In the above example, we have tagged the image with the my-dockerfile2 name.

. at the end of the command signifies that dockerfile is present in the current path.

Now let’s verify if the image gets successfully created by typing the below command
```
docker images
REPOSITORY       TAG       IMAGE ID       CREATED          SIZE
my-dockerfile2   latest    a4ca21f02823   3 minutes ago    252MB
```
Now, Run the docker container by typing the below command:
```
docker run -d -p 8081:80 my-dockerfile2
c63f5db298dd6656037892c520b6798cb260024c5944d3ea140e338f6e699b5e
```
\-d flag is used to run the container in the background.

\-p flag is used to forward the request from container port 80 to localhost port 8081.

type the docker ps command to verify if the container is running:
```
docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED         STATUS         PORTS                                   NAMES
c63f5db298dd   my-dockerfile2   "/usr/sbin/httpd -D …"   4 minutes ago   Up 4 minutes   0.0.0.0:8081->80/tcp, :::8081->80/tcp   funny\_babbage
```
Now go to localhost:8081 to access the httpd web UI.

If you are getting the below message in the web console, it means your container is working as expected.

![](/images/image-20.png)

Now you have a pretty good idea about how to write a dockerfile. Let’s proceed further and understand the best practice to write a dockerfile

Dockerfile Best practice
------------------------

Writing the docker file is not enough; the recommendation is to write the dockerfile with best practices to improve image quality. There are a few important steps that you should keep in mind while writing a dockerfile:

### Minimize the no of layers in the docker

While writing a dockerfile, make sure to minimize the no of steps in the dockerfile or club one or more steps together to reduce the no of layers in the image. You can read my blog [about the docker layers](https://naiveskill.com/docker-layer/) to understand better how layers affect your image quality.

So instead of writing multiple ENV commands in dockerfile:
```
FROM alpine:3.4

ENV MY\_NAME="John Doe"
ENV MY\_DOG=Rex\\ The\\ Dog
ENV MY\_CAT=fluffy
```
club similar commands together.
```
FROM alpine:3.4

ENV MY\_NAME="John Doe" MY\_DOG=Rex\\ The\\ Dog \\
    MY\_CAT=fluffy
```
### Choose a docker base image with utmost care

Every dockerfile starts with a base image, and the recommendation is to use the lightweight base image for your dockerfile. You can read this blog to get a clear idea about [which base image to use while creating a dockerfile](https://naiveskill.com/docker-base-image/).

### Use a .dockerignore file

If you have unnecessary files/folders in your directory which are not needed by your build. It is always good to have a `.dockerignore` file that works similarly to `.gitignor` that will exclude the files from the docker build. In .gitignor, you can specify the list of folders and files that should be ignored in the build context.

### Keep the instruction on top of the dockerfile which are less likely to change

Docker will build the container from the cache if the steps are not changed. The moment it finds some change in the dockerfile, it will start building the image from that point, ignoring the cached layer. So it is highly recommended to keep the instruction on top of the dockerfile, which is less likely to change, which will ultimately improve your container build time.

Wrap up
-------

Finally, we have come to an end to this lengthy tutorial. We have started with the dockerfile definition and understand the various components of the dockerfile. We also built and deployed some docker containers using our custom dockerfile, and finally, we understood some best practices for writing a dockerfile.

I hope you like this tutorial. Please do let me know if you found this tutorial useful.