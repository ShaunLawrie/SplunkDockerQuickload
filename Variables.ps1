# If you change the app name update it in ./Configuration/Splunk/user-prefs.conf
# These are used mainly by Build.ps1 and Run.ps1

$VARIABLES = @{
    # Docker image to create and run from
    Image = "splunkquickloadimage";
    # Docker container name to run as
    ContainerName = "splunkquickload";
    # The port Splunk is listening on inside the container
    SplunkWebPort = 8000;
    # The port on localhost to forward to the Splunk internal port
    SplunkForwardedPort = 8000;
    # The default app to load in the Splunk UI. The Splunk default is "launcher"
    SplunkDefaultNamespace = "dashexample"
}

Write-Host "Using VARIABLES:"
$VARIABLES