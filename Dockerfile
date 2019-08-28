FROM carlasim/carla:0.9.5 as builder

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
USER root
RUN apt-get update && apt-get -y install sudo python-setuptools python-pip python3 python3-pip python3-setuptools libpng16-16 libjpeg8 libjpeg-turbo8 libtiff5 iputils-ping curl unzip python-pygame fontconfig

RUN mkdir /home/carla
WORKDIR /home/carla

RUN useradd -m carla
RUN chown -R carla:carla /home/carla
RUN apt-get -y install sudo

RUN echo "carla:carla" | chpasswd && adduser carla sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER carla

COPY --from=builder /home/carla/PythonAPI ./PythonAPI
RUN ln -s PythonAPI/agents .

RUN mkdir -p /home/carla/.local/lib/python3.5/site-packages

RUN sudo easy_install /home/carla/PythonAPI/carla/dist/carla-0.9.5-py2.7-linux-x86_64.egg
RUN sudo easy_install3 /home/carla/PythonAPI/carla/dist/carla-0.9.5-py3.5-linux-x86_64.egg
WORKDIR /home/carla/user-agent

# Python dependencies for carla agents
RUN pip3 install --user numpy pygame networkx  py_trees==0.8.3
RUN pip install --user numpy==1.16.4 pygame networkx  py_trees==0.8.3

USER root
RUN chmod -R a+rwx /home/carla
USER carla

COPY manual_control.py example_agent.py mapview.py /home/carla/user-agent/

CMD ["python", "-u", "example_agent.py"]
