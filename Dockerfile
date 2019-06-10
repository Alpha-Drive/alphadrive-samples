FROM alphadrive/cli:0.7.0
COPY *.py /home/carla/user-agent/

USER carla
ENTRYPOINT  ["python", "-u"]
CMD ["example_agent.py"]
