$ErrorActionPreference = "Stop"

$IMAGE_NAME = "osu-server"
$WARMUP = $false

function Show-Help {
	Write-Host "Usage: $0 [options]"
	Write-Host ""
	Write-Host "Options:"
	Write-Host "  --name <image_name>    Set the name of the Docker image (default: osu-server)"
	Write-Host "  -w, --warmup           Build and warm up the container"
	Write-Host "  -h, --help             Show this help message"
	Write-Host ""
	Write-Host "Example usage:"
	Write-Host "  $0 --name custom-image-name -w"
}

while ($args.Count -gt 0) {
	switch ($args[0]) {
		"--name" {
			$IMAGE_NAME = $args[1]
			$args = $args[2..$args.Length]
		}
		"-w" {
			$WARMUP = $true
			$args = $args[1..$args.Length]
		}
		"--warmup" {
			$WARMUP = $true
			$args = $args[1..$args.Length]
		}
		"-h" {
			Show-Help
			exit 0
		}
		"--help" {
			Show-Help
			exit 0
		}
		default {
			Write-Host "Unknown option: $($args[0])"
			exit 1
		}
	}
}

docker build -t $IMAGE_NAME .

if ($WARMUP) {
	docker rm -f temp-osu 2>$null
	docker run -e MODE=warmup --name temp-osu $IMAGE_NAME
	docker commit temp-osu "$IMAGE_NAME:prewarmed"
	docker rm temp-osu
}
