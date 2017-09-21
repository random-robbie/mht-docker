FROM ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install bash -y
ADD build.sh /build.sh
EXPOSE 80 3000 8089
ENTRYPOINT ["/bin/bash"]
