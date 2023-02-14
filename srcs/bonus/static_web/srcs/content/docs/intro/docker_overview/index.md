---
title: 'Docker Overview'
date: 2019-02-11T19:27:37+10:00
weight: 5
---

Overview
========

Welcome! We’re excited that you want to learn Docker.

This guide contains step-by-step instructions on how to get started with Docker. Some of the things you’ll learn and do in this guide are:

*   Build and run an image as a container
*   Share images using Docker Hub
*   Deploy Docker applications using multiple containers with a database
*   Run applications using Docker Compose

Before you get to the hands on part of the guide, you should learn about containers and images.

What is a container?
--------------------

Simply put, a container is a sandboxed process on your machine that is isolated from all other processes on the host machine. That isolation leverages [kernel namespaces and cgroups](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504), features that have been in Linux for a long time. Docker has worked to make these capabilities approachable and easy to use. To summarize, a container:

*   is a runnable instance of an image. You can create, start, stop, move, or delete a container using the DockerAPI or CLI.
*   can be run on local machines, virtual machines or deployed to the cloud.
*   is portable (can be run on any OS).
*   is isolated from other containers and runs its own software, binaries, and configurations.

What is a container image?
--------------------------

When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container’s filesystem, it must contain everything needed to run an application - all dependencies, configurations, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

You’ll dive deeper into images later on in this guide, covering topics such as layering, best practices, and more.

> **Note**
> 
> If you’re familiar with `chroot`, think of a container as an extended version of `chroot`. The filesystem is simply coming from the image. But, a container adds additional isolation not available when simply using chroot.


