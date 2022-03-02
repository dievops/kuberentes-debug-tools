### Shitty dockerfile ###
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
### OS PACKAGE ###
RUN apt install -y \
		wget \
		curl \
		htop \ 
		atop \ 
		nload \ 
		tar \ 
		tcpdump \ 
		nano \ 
		vim \ 
		strace \ 
		ltrace \ 
		ethtool \ 
		gcc \ 
		git \ 
		iotop \ 
		less \ 
		telnet \ 
		net-tools \ 
		netsniff-ng \ 
		screen \ 
		tar \ 
		docker \ 
		python3 \ 
		python3-pip \ 
		ansible \ 
		zip \ 
		tzdata \
		iputils-ping

### HELM ###
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add -
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update
RUN apt-get install helm -y

## KUSTOMIZE
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv ./kustomize /usr/local/bin/kustomize

### EKS CTL ###
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/local/bin

## AWS CLI 2 ###

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

#awsiamauthenticator

RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN mv ./aws-iam-authenticator /usr/local/bin

### TERRAFORM ###
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN echo "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/terraform.list
RUN apt update
RUN apt-get install terraform -y

#envsubst
RUN apt-get install gettext-base -y