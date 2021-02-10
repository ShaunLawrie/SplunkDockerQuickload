param (
    [switch] $SuppressBrowserOpen,
    [switch] $StopContainersOnly
)

. .\Variables.ps1

$defaultForeground = "Yellow"

Write-Host "Killing $($VARIABLES.ContainerName)" -ForegroundColor $defaultForeground
docker stop $VARIABLES.ContainerName | Out-Null
docker rm $VARIABLES.ContainerName | Out-Null

if(!$StopContainersOnly) {
    Write-Host "Starting new container" -ForegroundColor $defaultForeground
    docker run -d --name "$($VARIABLES.ContainerName)" -p "$($VARIABLES.SplunkWebPort):$($VARIABLES.SplunkForwardedPort)" "$($VARIABLES.Image)"

    Start-Sleep -Seconds 3
    docker ps

    Write-Host "Container $($VARIABLES.ContainerName) will be listening on: " -NoNewline -ForegroundColor $defaultForeground
    Write-Host "$($VARIABLES.SplunkForwardedPort)" -ForegroundColor "Cyan"

    if(!$SuppressBrowserOpen) {
        $url = "http://127.0.0.1:$($VARIABLES.SplunkForwardedPort)"
        Write-Host "Opening '$url' in default browser"
        Start-Process $url
    }
} else {
    Write-Host "Destroyed $($VARIABLES.ContainerName)"
}

docker logs -f "$($VARIABLES.ContainerName)"
