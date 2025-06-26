docker build -t osulazer . && docker run --name temp-osu osulazer && docker commit temp-osu osulazer:prewarmed
