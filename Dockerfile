FROM hashicorp/terraform:0.11.7

LABEL MAINTAINER="Aurelien PERRIER <a.perrier89@gmail.com>"
LABEL APP="terraform"

VOLUME [ "/data" ]
WORKDIR /data

ENTRYPOINT [ "./exec.sh" ]