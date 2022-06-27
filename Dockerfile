FROM amazonlinux:2
RUN yum update -y \
  && yum install -y less glibc groff unzip \
  && yum clean all

RUN yum remove awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install --update
RUN ./aws/install --update -i /usr/local/aws-cli -b /usr/local/bin
WORKDIR /aws

RUN curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl
RUN curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl.sha256
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

RUN mkdir -p /root/.kube
RUN mkdir -p /root/.aws

RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN aws --version
RUN kubectl version --client
