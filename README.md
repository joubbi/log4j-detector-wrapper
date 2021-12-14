# log4j-detector-wrapper
A wrapper for https://github.com/mergebase/log4j-detector that finds java.

1. Get the latest version of [log4j-detector](https://github.com/mergebase/log4j-detector)
2. Modify the variable `LOG4JDETECTOR`in [log4j-detector-wrapper.sh](log4j-detector-wrapper.sh) accordingly.
3. Run log4j-detector-wrapper preferably as root.

The wrapper will do it's best to find a java executable and run log4j-detector with it.
All you need is the jar file from log4j-detector and the wrapper script.

___

Licensed under the [__Apache License Version 2.0__](https://www.apache.org/licenses/LICENSE-2.0)

Written by __farid@joubbi.se__

