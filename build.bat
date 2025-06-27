@echo off
setlocal enabledelayedexpansion

set IMAGE_NAME=osu-server
set WARMUP=false

:parse_args
set i=1
:loop
if "%~1"=="" goto after_args
if "%~1"=="--name" (
	shift
	set IMAGE_NAME=%~1
) else if "%~1"=="-w" (
	set WARMUP=true
) else if "%~1"=="--warmup" (
	set WARMUP=true
) else if "%~1"=="-h" (
	goto show_help
) else if "%~1"=="--help" (
	goto show_help
)
shift
goto loop

:after_args
docker build -t %IMAGE_NAME% .

if !WARMUP! == true (
	docker rm -f temp-osu >nul 2>&1
	docker run -e MODE=warmup --name temp-osu %IMAGE_NAME%
	docker commit temp-osu %IMAGE_NAME%:prewarmed
	docker rm temp-osu
)

goto :eof

:show_help
echo Usage: build.bat [options]
echo.
echo Options:
echo   --name ^<image_name^>    Set the name of the Docker image (default: osu-server)
echo   -w, --warmup             Also builds ^<image_name^>:prewarmed
echo   -h, --help               Show this help message
echo.
echo Example usage:
echo   build.bat --name custom-image-name -w
pause
exit /b
