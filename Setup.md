# Environment Setup
## Overview
Virtual machine running **Ubuntu 22.04 LTS** :
  * 8 GB of RAM 
  * 4 cores
  * 150 GB of memory

## Tools
### Java 1.8
```bash
$ sudo apt install openjdk-8-jdk

# Setting the JAVA_HOME environment variable 
$ sudo nano /etc/environment                    # Open the /etc/environment
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"   # Add this line to the end of the file
$ source /etc/environment                       # To take effect the changes
$ sudo reboot                                   # Restart the system
$ echo $JAVA_HOME                               # To verify is the variable is set correctly
```

### Maven 3.6
```bash
sudo apt-get -y install maven
```

### Hadoop 3.3.5
```bash
$ git clone https://github.com/apache/hadoop.git --branch rel/release-3.3.5 --single-branch
```

### Native libraries
```bash
sudo apt-get -y install build-essential autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev libsasl2-dev
```

### Protocol Buffers 3.7.1
 It is required to build native code
```bash
curl -L -s -S https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protobuf-java-3.7.1.tar.gz -o protobuf-3.7.1.tar.gz
mkdir protobuf-3.7-src
tar xzf protobuf-3.7.1.tar.gz --strip-components 1 -C protobuf-3.7-src && cd protobuf-3.7-src
./configure
make -j$(nproc)
sudo make install
```
### Other Packages
* Snappy compression 
(only used for hadoop-mapreduce-client-nativetask)
```bash
sudo apt-get install snappy libsnappy-dev
```
* Bzip2
```bash
sudo apt-get install bzip2 libbz2-dev
```
* Linux FUSE
```bash
sudo apt-get install fuse libfuse-dev
```
* ZStandard compression
```bash
sudo apt-get install libzstd1-dev
```

### SSH and PDSH
* Install : 
```bash
$ sudo apt-get install ssh
$ sudo apt-get install pdsh
```
* Setup passphraseless ssh

```bash
# Check that you can ssh to the localhost without a passphrase
 $ ssh localhost

# If you cannot ssh to localhost without a passphrase, execute the following commands
$ ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
$ chmod 0600 ~/.ssh/authorized_keys
```

## Build ???'
```bash
$ mvn package -Pdist -Dtar -DskipTests
$ mvn compile -Pdist -Dtar -DskipTests
$ mvn package -Pdist,native -DskipTests -Dtar   # https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/NativeLibraries.html
```