# shim-crtl
If you don't want to install the control software of Pimoroni's fan SHIM on your device directly, you can just boot up this container via the provided docker-compose file and have it running instantly. You can also make adjustments to the temperature configuration in said file.<br/>
Furthermore, when you stop the container, the **service is also stopped**. But beware that this **only goes for stopping** the container. If you kill it, the fan'll keep its configuration.

> Notice: The docker-compose file was created for a debian-based system. If you're using e.g. ubuntu, you might need to adjust the systemctl access in the docker-compose file (see [here](https://askubuntu.com/a/1297227)).

## Sources
The way the container accesses systemctrl was provided by [this answere](https://askubuntu.com/a/1311339) and the template for the startup script that made it possible to disable the fan's control when the container is stopped is from [Grigorii Chudnov's medium post](https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86).
