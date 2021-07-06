# Android SDK requires jdk 11 at this point of time
FROM openjdk:9-jdk as staging

# Installs i386 architecture required for running 32 bit Android tools
# rm -rf /var/lib/apt/lists/* && \
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 expect unzip && \
    apt-get autoremove -y && \
    apt-get clean

# This is a workaround for android-sdk not working properly with Java 9,10
# Note that jdk 11 does not have this module anymore -- Google knew this would happen since 2017
# but they don't give a shit about that
ENV JAVA_OPTS="-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee"

# Install android sdk related tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

ENV YESS /opt/tools/android-accept-licenses.sh
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
ENV ANDROID_HOME /opt/android-sdk-linux
ENV CMDLINE_TOOLS $ANDROID_HOME/cmdline-tools

RUN mkdir -p $CMDLINE_TOOLS

# Install Android SDK
# chown -R root.root android-sdk-linux && \
RUN cd /opt && \
    wget --output-document=android-sdk.zip --quiet $ANDROID_SDK_URL && \
    unzip android-sdk.zip -d $CMDLINE_TOOLS && \
    mv $CMDLINE_TOOLS/cmdline-tools $CMDLINE_TOOLS/latest && \
    rm -f android-sdk.zip

# Setup environment
ENV PATH ${PATH}:$CMDLINE_TOOLS/latest/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin
ENV SDKMANAGER=$CMDLINE_TOOLS/latest/bin/sdkmanager

# Check installation
RUN which sdkmanager

#RUN $YESS sdkmanager "ndk-bundle"
RUN $YESS $SDKMANAGER "extras;intel;"
RUN $SDKMANAGER "tools" "platform-tools"
RUN $YESS $SDKMANAGER "emulator"
RUN $YESS $SDKMANAGER "system-images;android-23;default;x86"
RUN $YESS $SDKMANAGER "extras;android;m2repository;"
RUN $YESS $SDKMANAGER "extras;google;m2repository"
RUN $YESS $SDKMANAGER "extras;google;google_play_services"
RUN $YESS $SDKMANAGER "platforms:android-22"
RUN $YESS $SDKMANAGER "platforms;android-23"
RUN $YESS $SDKMANAGER "platforms;android-25"
RUN $YESS $SDKMANAGER "platforms;android-26"
RUN $YESS $SDKMANAGER "build-tools;22.0.1"
RUN $YESS $SDKMANAGER "build-tools;23.0.1"
RUN $YESS $SDKMANAGER "build-tools;23.0.3"
RUN $YESS $SDKMANAGER "build-tools;25.0.2"
RUN $YESS $SDKMANAGER "build-tools;25.0.3"
RUN $YESS $SDKMANAGER "build-tools;26.0.2"
RUN $YESS $SDKMANAGER "build-tools;27.0.3"
RUN $YESS $SDKMANAGER "build-tools;28.0.2"
RUN $YESS $SDKMANAGER "platforms;android-28"
RUN $YESS $SDKMANAGER "build-tools;28.0.3"
RUN $YESS $SDKMANAGER "platforms;android-29"
RUN $YESS $SDKMANAGER "platforms;android-30"
RUN $YESS $SDKMANAGER --licenses

FROM openjdk:11.0.11-jdk-buster

MAINTAINER Viacheslav Blinov "blinov.vyacheslav@gmail.com"

# Installs i386 architecture required for running 32 bit Android tools
# rm -rf /var/lib/apt/lists/* && \
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 expect unzip && \
    apt-get autoremove -y && \
    apt-get clean

# This is a workaround for android-sdk not working properly with Java 9,10
# Note that jdk 11 does not have this module anymore -- Google knew this would happen since 2017
# but they don't give a shit about that
ENV JAVA_OPTS="-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee"

# Install android sdk related tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

ENV YESS /opt/tools/android-accept-licenses.sh
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
ENV ANDROID_HOME /opt/android-sdk-linux
ENV CMDLINE_TOOLS $ANDROID_HOME/cmdline-tools

# Setup environment
ENV PATH ${PATH}:$CMDLINE_TOOLS/latest/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin
ENV SDKMANAGER=$CMDLINE_TOOLS/latest/bin/sdkmanager

COPY --from=staging $ANDROID_HOME $ANDROID_HOME

# create emulator to run tests:
# RUN echo "no" | android create avd \
#                 --force \
#                 --device "Nexus 5" \
#                 --name test \
#                 --target android-23 \
#                 --abi x86 \
#                 --skin WVGA800 \
#                 --sdcard 512M

# start this emulator:
# RUN emulator -avd test && /opt/tools/android-wait-emulator.sh

# Check android sdk packages installation
RUN which adb

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
