# docker-basics

## What is docker?

Docker is often described as a light-weight virutal machine but [this stackoverflow post](https://stackoverflow.com/questions/16047306/how-is-docker-different-from-a-normal-virtual-machine) discusses the differences between virtual machines and containers. In short, virtual are hardware virtualisation, they (via a hypervisor) interacts with hardware so this it appears as though multiple operating systems are running. Containers share an operating system kernel and can be considered OS virtualisation. Sharing the same kernel means that containers can be lighter-weight than VMs but they are less isolated. It also means that if you want to run a container of one OS on top of another OS (e.g. Linux contaiers on Windows) you need a VM in order to have the right kernel. 

## Under the hood

These technologies are often mentioned as underpinning how containers work:
* Isolating the file systems (similiar to *chroot*)
* Controlling how much resource given processes can use (along the lines of *cgroups*) 
* Isolating sets of processes (using linux namespaces) so that they can't see one another

### Isolating file systems
The *chroot* command can be used to make a different folder appear to a new process as being the root folder. These processes cannot see files/folders outside of this new file system, isolating it from the full file system.

In pratice (on Linux) this means that the new folder needs to have a similar strucutre to / and all the binaries and libraries need for those processes

This is explored on [nixCraft](https://www.cyberciti.biz/faq/unix-linux-chroot-command-examples-usage-syntax/) and the script _create_sandbox.sh_ is a rough script that implements these ideas to create the right file structure with a few simple command line tools present in it.

Usage:
```bash
 ./create_sandbox.sh <folder_name>
 ```
 And then this command would start a process in the new sandboxed file system:
 ```
 sudo chroot <folder_name> /bin/bash
 ``` 

[This post](https://ericchiang.github.io/post/containers-from-scratch/) further explores these ideas and has a great demo of why file system isolation is not enough to create an isolated environment, you need process isolation (shown using the unshare command line tool).

## When should I use docker for data science?

Docker allows isolated environments which is useful for deployment on cloud services. Containers mean that the same environment can be obtained regardless of where the prgram is run (assuming you specify versions in your Dockerfile).

Is it worth using docker on a personal laptop? On the one hand using docker means you can spin up a container, install random packages and if these break anything you haven't destroyed your local system. Using virtual environments (*packrat* in R or *venv* in Python) allows you to have isolated environments for a single language only but often packages are only wrappers for command line utilities that have to be installed seperately (and probably have a long list of dependencies). On the other hand, docker images do have a tendency to eat up your hard drive if you are not careful and there is a steep learning curve. 

I have found it is particularly useful for when you are using CUDA (using [nvidia-docker](https://github.com/NVIDIA/nvidia-docker) and I found [this page](http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux) helpful for installing the necessary drivers). Python tends to work fine either using *venv* or *conda* to ensure you do not interfer with the system Python, but occassionaly having a dockerised version does prove useful and a simple image (mostly for my reference) can be found in the *python-image* folder. My experience of R on the other hand is that seems to work for a while, then you upgrade packages and weird errors creep in, often due to conflicts between R version of system libraries and the system libraries themselves. I now prefer to use the [rocker](https://hub.docker.com/u/rocker/) R docker images for R. 




