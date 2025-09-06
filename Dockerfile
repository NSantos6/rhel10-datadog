FROM redhat/ubi10:10.0

ARG DD_API_KEY
ARG DD_SITE=datadoghq.com

ENV DD_API_KEY=${DD_API_KEY}
ENV DD_SITE=${DD_SITE}
ENV DD_HOSTNAME="meu-host-rhel10"

RUN yum install -y wget procps

RUN wget https://s3.amazonaws.com/yum.datadoghq.com/stable/7/x86_64/datadog-agent-7.70.0-1.x86_64.rpm && \
    rpm -ivh datadog-agent-7.70.0-1.x86_64.rpm 


#RUN sed -i "s/^# api_key:.*$/api_key: ${DD_API_KEY}/" /etc/datadog-agent/datadog.yaml && \
#    sed -i "s/^# site:.*$/site: ${DD_SITE}/" /etc/datadog-agent/datadog.yaml

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]