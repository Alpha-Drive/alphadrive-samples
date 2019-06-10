FROM alphadrive/cli:0.7.0
COPY *.py /home/carla

USER carla
CMD ["python", "example_agent.py"]
