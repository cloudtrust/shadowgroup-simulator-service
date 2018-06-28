FROM cloudtrust-baseimage:f27

WORKDIR /opt
#Get dependencies and create user
RUN dnf install -y java java-1.8.0-openjdk-devel git maven; dnf clean all; \
    git clone git@github.com:cloudtrust/shadowgroup-simulator.git; \
    git clone git@github.com:cloudtrust/shadowgroup-simulator-service.git; \
    groupadd SOresource; \
    useradd -m -s /sbin/nologin -g SOresource SOresource

#Build shadowgroup-simulator
WORKDIR /opt/shadowgroup-simulator
RUN	git checkout test; \
	mvn clean package; \
        mkdir /opt/shadowgroup-simulator-run; \
	mv target/shadowgroup-simulator.jar /opt/shadowgroup-simulator-run/shadowgroup-simulator.jar; \
	chown -R SOresource:SOresource /opt/shadowgroup-simulator-run

#config
WORKDIR /opt/shadowgroup-simulator-service
RUN install -v -o root -g root -m 644 -d /etc/systemd/system/shadowgroup-simulator.service.d; \
    install -v -o root -g root -m 644 deploy/common/etc/systemd/system/shadowgroup-simulator.service /etc/systemd/system/shadowgroup-simulator.service; \
    install -v -o SOresource -g SOresource -m 755 deploy/common/opt/runShadowgroupSimulator.sh /opt/runShadowgroupSimulator.sh
	
#Enable service
RUN systemctl enable shadowgroup-simulator.service
