FROM jenkins/inbound-agent

USER root

# Install dependencies and tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        zdbsp \
        zip \
        unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and install zdoom ACC
# The URL should be updated to the latest version if needed
RUN mkdir /opt/acc && \
    wget -q https://github.com/ZDoom/acc/releases/download/1.60/acc-1.60-linux64.zip -O /tmp/acc.zip && \
    unzip /tmp/acc.zip -d /opt/acc && \
    rm /tmp/acc.zip && \
    chmod +x /opt/acc/acc

USER jenkins

# Set the PATH to include the ACC binary
ENV PATH="/opt/acc:${PATH}"