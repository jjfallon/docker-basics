# docker-learn

## Vaguely learning about docker

Docker is often described as a light-weight virutal machine but [this stackoverflow post](https://stackoverflow.com/questions/16047306/how-is-docker-different-from-a-normal-virtual-machine) discusses the differences between virtual machines and containers. In short, virtual are hardware virtualisation, they (via a hypervisor) interacts with hardware so this it appears as though multiple operating systems are running. Containers share an operating system kernel and can be considered OS virtualisation. Sharing the same kernel means that containers can be lighter-weight than VMs but they are less isolated. It also means that if you want to run a container of one OS on top of another OS (e.g. Linux contaiers on Windows) you need a VM in order to have the right kernel. 

## Under the hood

These technologies are often mentioned as underpinning how containers work:
* Isolating the file systems (similiar to *chroot*)
* Controlling how much resource given processes can use (along the lines of *cgroups*) 
* Isolating sets of processes (using linux namespaces) so that they can't see one another

# Isolating file systems
The *chroot* command can be used to make a different folder appear to a new process as being the root folder. These processes cannot see files/folders outside of this new file system, isolating it from the full file system.

In pratice (on Linux) this means that the new folder needs to have a similar strucutre to / and all the binaries and libraries need for those processes

This is explored on [nixCraft](https://www.cyberciti.biz/faq/unix-linux-chroot-command-examples-usage-syntax/) and the script _create_sandbox.sh_ is a rough script that implements these ideas to create the right file structure with a few simple command line tools present in it.

Usage:
```bash
 ./create_sandbox.sh <folder_name></code>
 ```
 And then this command would start a process in the new sandboxed file system:
 ```
 sudo chroot <folder_name> /bin/bash
 ``` 

[This post](https://ericchiang.github.io/post/containers-from-scratch/) further explores these ideas and has a great demo of why file system isolation is not enough to create an isolated environment, you need process isolation (shown using the unshare command line tool).
