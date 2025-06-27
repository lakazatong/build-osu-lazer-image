FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update && \
	apt-get install -y libgl1-mesa-dri libgl1-mesa-glx libglew-dev alsa-utils \
	git xvfb fluxbox x11-utils

RUN git clone https://github.com/lakazatong/osu-server
RUN git clone https://github.com/lakazatong/osu-framework-server

ENV DISPLAY=:99

EXPOSE 8080

COPY init.sh /init.sh
COPY warmup.sh /warmup.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
