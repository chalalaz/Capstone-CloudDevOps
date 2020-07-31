# Cloud DevOps Capstone Project

This project is intended to set up a pipeline that allows us to lint the target code, build the correponding Docker container, and deploy it to a [kubernetes](https://kubernetes.io/) cluster. Blue/green deployment is also used.

## AWS EKS - VPC
![1.eks-diagram](/screenshots/1.eks-diagram.png)

## Table of Contents

* [Project Overview](#project-overview)
* [Getting Started](#getting-started)
* [Repository Files](#repository-files)


## Project Overview
* Test application code using linting.
* Build a Docker image that containerizes the application, a simple Nginx one.
* Push a Docker image that we just create.
* Remove Docker file from host.
* Create a configuration file for the kubectl cluster.
* Set the current kubctl context to the cluster.
* Create the green replication controller with its Docker image.
* Wait until the user gives the instruction to continue.
* Update the service to redirect to green by changing the selector to app=green.
* Create the blue replication controller with its Docker image.
* Wait until the user gives the instruction to continue.
* Create the service in the Kubernetes cluster to the blue replication controller.
* Check the application deployed in the cluster and its correct deployment.

Apart from the steps in the pipeline, it is necessary to previously configure Kubernetes and create a Kubernetes cluster.

## Getting Started

In this section, it can be seen how the pipeline works as designed.

### Creating the Kubernetes cluster

As a first previous step, the Kubernetes cluster is created.

![2.create-stack-cmd](/screenshots/2.create-stack-cmd.png)
![3.console-stack-result](/screenshots/3.console-stack-result.png)
![4.eks-console-active](/screenshots/4.eks-console-active.png)
![5.eks-console-active2](/screenshots/5.eks-console-active2.png)
![6.eks-console-nodegroup](/screenshots/6.eks-console-nodegroup.png)
![7.eks-console-nodegroup2](/screenshots/7.eks-console-nodegroup2.png)
![8.ec2-console](/screenshots/8.ec2-console.png)
![9.eks-cluster-cmd](/screenshots/9.eks-cluster-cmd.png)

### Running the pipeline

From now on, the pipeline itself is run, and its stages are shown below.

* Test application code using linting. Below, both a failed Linting screenshot and a successful Linting screenshot are shown.
![10.pipeline-linting1](/screenshots/10.pipeline-linting1.png)
![11.pipeline-linting2](/screenshots/11.pipeline-linting2.png)
* Build a Docker image that containerizes the application, a simple Nginx one.
![12.pipeline-buildimage1](/screenshots/12.pipeline-buildimage1.png)
![13.pipeline-buildimage2](/screenshots/13.pipeline-buildimage2.png)
* Push a Docker image to DockerHub,
![14.pipeline-pushimage1](/screenshots/14.pipeline-pushimage1.png)
* Remove a Docker image from Host,
![15.pipeline-removeimage](/screenshots/15.pipeline-removeimage.png)
* Create a configuration file for the kubectl cluster.Set the current kubctl context to the cluster and create a green replication controller.
![16.pipeline-deploy-green1](/screenshots/16.pipeline-deploy-green1.png)
![17.pipeline-deploy-green2](/screenshots/17.pipeline-deploy-green2.png)
* Inform user to approve green deploy status
![18.pipeline-user-approve](/screenshots/18.pipeline-user-approve.png)
* Create the service in the Kubernetes cluster to the green replication controller.
![19.pipeline-deploy-service](/screenshots/19.pipeline-deploy-service.png)
![20.pipeline-depoly-service2](/screenshots/20.pipeline-depoly-service2.png)
![20.green-result](/screenshots/20.green-result.png)
* Create the blue replication controller with its Docker image.
![21.pipeline-deploy-blue1](/screenshots/21.pipeline-deploy-blue1.png)
![22.pipeline-deploy-blue2](/screenshots/22.pipeline-deploy-blue2.png)
* Inform user to approve blue deploy status
![23.pipeline-user-approve](/screenshots/23.pipeline-user-approve.png)
* Create the service in the Kubernetes cluster to the blue replication controller.
![24.pipeline-deploy-service](/screenshots/24.pipeline-deploy-service.png)
![31.blue-result](/screenshots/31.blue-result.png)

## Repository Files

In this section, the repository files are described:

* *Jenkinsfile*: this is a Jenkins file which implements a pipeline.
* *k8s-script/blue-controller.json*: this file specifies the replication controller blue pod.
* *k8s-script/blue-service.json*: this file specifies the blue service.
* *source/blue&green/Dockerfile*: contains all the commands to assemble the image.
* *k8s-script/green-controller.json*: this file specifies the replication controller green pod.
* *k8s-script/green-service.json*: this file specifies the green service.
* *source/blue&green/index.html*: simple html file that makes up the application.
* */screenshots*: this folder contains a number of screenshots to show the correct workings of the project.
