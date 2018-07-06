# communityMQTT [![Build Status](https://travis-ci.org/linsong/sedona-mqtt.svg?branch=master)](https://travis-ci.org/linsong/sedona-mqtt) 

## What is communityMQTT kit ?
The communityMQTT kit is a [MQTT](http://mqtt.org/) client kit in [Sedona Framework](https://linsong.github.io/sedona/ "Sedona Framework"), it can transfer data between sedona and MQTT broker, so that it is easy to integrate sedona powered device with other system. 

This kit is developed as part of the [community version of Sedona Framework](https://linsong.github.io/sedona/). Sedona Framework is a trademark of Tridium. 

Note: this kit is a native kit, that means you will need to compile its native codes into svm, you can find more details [here](https://linsong.github.io/sedona/doc/nativeMethods.html).

## How does the kit work?
There are 3 types of components: 

+ service component: must be the root of all other component
   - MQTTService
 
+ worker component: must be child of service component
   - Publisher
   - Subscriber
 
+ message component: must be child of worker component
   - FloatMessage
   - IntMessage
   - BoolMessage
   - StrMessage
 
The service component is the logical root object for all MQTT worker objects, otherwise it does not do much work. 

The worker component is the key component within the kit, it will establish connection with MQTT broker, and loop over all its children to publish/subscribe data with MQTT broker. One worker object represents a connection session to a MQTT broker. You can have multiple worker objects to the same or different MQTT brokers at the same time.

The message component is the data endpoint, you can config the MQTT data topic, how often to publish/subscribe data, the quality of service of data transfer etc. It must be child of a worker component, and under one worker component, you can create multiple message objects.

## How to use it ?

The overall setup steps: 
+ create MQTTService object
create an object of communityMQTT::MQTTService component. Where the object is created doesn't matter, but we recommend the 'services' folder.

+ create worker object within MQTTService object
Create a communityMQTT::Publisher or CommunityMQTT::Subscriber object just under the MQTTService object, then you will need to config the MQTT broker connection information. The following configs must be set: 

    - host (MQTT broker host, for example: test.mosquitto.org)
    - port  (MQTT default port is 1883)
    - clientid (unique id to identify this publisher)
    - username (optional)
    - password (optional)

  There are some slots to indicate the state of the worker object: 

    - error: if there is any error in config data, the error message will be displayed here
    - status: the MQTT connection status(Disconnected, Connected)

+ create message object within worker object
  You can create message objects within a worker object(create under Publisher worker to publish data to a MQTT topic, under Subscriber worker object to subscribe a MQTT topic data). There are 4 data types supported for now: Float, Integer, Boolean and String. 

  There are common slots in every message object: 
    - topic: MQTT topic, for example: `room1/temp`
    - payload: the actual data payload
    - QoS: Quality of Service, there are 3 levels: QoS0(FireAndForget), QoS1(GuaranteeReceived), QoS2(GuaranteeReceivedOnce). Note not every broker support all these levels. 
    - publishInterval: How often to publish data to MQTT broker, in millisecond. Only valid when publishing data to MQTT broker.
    - updateInterval: How often to fetch and update local data from MQTT broker, in millisecond. Only valid when subscribing data from MQTT broker
    - error: error message if something wrong

+ wire data slots between message object and other sedona object to make data links

## How to build under Linux/Mac platform:
- if you don't have a working sedona source folder, then check out a copy from [here](https://github.com/linsong/sedona, "Sedona Community Version"), and make sure you can build sedonac and svm successfully
- clone a copy of this kit under "sedona/src/kits" folder
- make sure current directory is "sedona", then run script "src/kits/communityMQTT/setup_env.sh". it will set up the sedona environment before building the kit. Note, you only need to run this script *once*.
- run "sedonac src/kits/communityMQTT/kit.xml" to build this kit
- run "makeunixvm" to rebuild svm since this kit is native kit

## Dependecy
* [MQTT Embedded C Library](https://github.com/eclipse/paho.mqtt.embedded-c) (dual licensed under the EPL and EDL)
* [uthash](https://github.com/troydhanson/uthash) (BSD)
* [log.c](https://github.com/rxi/log.c) (MIT)

All these dependecy libraries have been included in the kit repository already, you don't need to download them again.

## LICENSE
This kit is free software; you can redistribute it and/or modify it under the terms of the MIT license. See [LICENSE](https://github.com/linsong/sedona-mqtt/blob/master/LICENSE) for details.

