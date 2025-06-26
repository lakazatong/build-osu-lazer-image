docker build -t osu-server . && docker run --name temp-osu osu-server && docker commit temp-osu osu-server:prewarmed
