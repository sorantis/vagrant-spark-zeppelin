#!/usr/bin/env bash

# APACHE ZEPPELIN

export ZEPPELIN_VERSION=0.7.0
export ZEPPELIN_HOME=/usr/zeppelin
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook
export ZEPPELIN_PORT=8080

apt-get install -y git wget net-tools unzip python npm

# Fixing Debian/Jessie 8.2 has changed "node" to "nodejs"
ln -fs /usr/bin/nodejs /usr/bin/node

mkdir ${ZEPPELIN_HOME}
wget -c "http://apache.mirrors.spacedump.net/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz"
tar zxvf zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz
mv zeppelin-${ZEPPELIN_VERSION}-bin-all/* ${ZEPPELIN_HOME}
cd ${ZEPPELIN_HOME}

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
CONF

echo "Copying Notebooks ..."
cp -vR /vagrant/notebook/* /usr/zeppelin/notebook/

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start

sudo echo 'export SPARK_HOME=/usr/spark' >> /usr/zeppelin/conf/zeppelin-env.sh

echo "Restarting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh restart
