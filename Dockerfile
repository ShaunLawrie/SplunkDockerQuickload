FROM splunk/splunk:8.0.3

ARG splunk_password

RUN mkdir /tmp/splunkconf && mkdir /tmp/splunkapps && mkdir /tmp/splunkdata

COPY Data/* /tmp/splunkdata/

COPY Configuration/Splunk/*.conf /tmp/splunkconf/
COPY Configuration/Splunk/AppPackages/*.tgz /tmp/splunkapps/

COPY Configuration/Ansible/default.yml /tmp/defaults/
COPY Configuration/Ansible/override.yml /tmp/

# Additional args required for some Splunk versions:
# 7.1.x --gen-and-print-passwd
ENV SPLUNK_START_ARGS="--accept-license"

ENV SPLUNK_PASSWORD="$splunk_password"
