FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update && \
	apt-get install -y libgl1-mesa-dri libgl1-mesa-glx libglew-dev alsa-utils git

RUN git clone https://github.com/lakazatong/osu-server
RUN git clone https://github.com/lakazatong/osu-framework-server

EXPOSE 8080

CMD ["bash"]

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
