#Requires -Version 7
param (
    [Parameter(Mandatory=$true)]
    [SecureString] $SplunkPassword,
    [switch] $PullFromDocker
)

. .\Variables.ps1

$customAppsSourceDir = ".\Configuration\Splunk\AppSource\"
$appPackageDir = "$PSScriptRoot\Configuration\Splunk\AppPackages\"
$zipper = "C:\Program Files\7-Zip\7z.exe"
$customApps = Get-ChildItem -Path $customAppsSourceDir -Directory

if($PullFromDocker) {
    Write-Host "Pulling the latest working copy of custom Splunk apps from $($VARIABLES.ContainerName)"
    ForEach ($app in $customApps) {
        Write-Host "Copying $($app.Name) from docker container back to $customAppsSourceDir"
        docker cp "$($VARIABLES.ContainerName):/opt/splunk/etc/apps/$($app.Name)" $customAppsSourceDir
    }
}

if($IsMacOS) {
    Write-Host "Packing latest version of custom Splunk apps [$($customApps.Name)]"
    Write-Host "Removing custom app tgz archives"
    ForEach ($app in $customApps) {
        $filename = ".\Configuration\Splunk\AppPackages\$($app.Name).tgz"
        Write-Host "Removing $filename"
        Remove-Item $filename -Force -ErrorAction SilentlyContinue
        Write-Warning "App tar-gzipping hasn't been configured for Mac OS"
    }
} else {
    if(Test-Path $zipper) {
        Write-Host "Packing latest version of custom Splunk apps [$($customApps.Name)]"
        Write-Host "Removing custom app tgz archives"
        ForEach ($app in $customApps) {
            $filename = ".\Configuration\Splunk\AppPackages\$($app.Name).tgz"
            Write-Host "Removing $filename"
            Remove-Item $filename -Force -ErrorAction SilentlyContinue
            Start-Process .\Tools\PackageSplunkApp.cmd -ArgumentList @("$($app.Name)", $customAppsSourceDir, $appPackageDir) -Wait -NoNewWindow
        }
    } else {
        Write-Warning "7Zip needs to be installed to compress the $customApps Splunk app.`nTried to run it from $($zipper)`nThe last version of the apps *.tgz will be used"
    }
}

docker build --tag="$($VARIABLES.Image)" --build-arg splunk_password="$(ConvertFrom-SecureString -SecureString $SplunkPassword -AsPlainText)" .
