# Place tgz app packages here to have them installed in the Splunk docker container

For example drop splunk-machine-learning-toolkit_510.tgz here and it will be automatically installed when the Build.ps1 script is run.

If an application downloaded from SplunkBase has the *.spl extension rename it to *.tgz for auto installation to work.

Custom applications in the ../AppSource/ directory will be converted to a tgz package for installation when Build.ps1 is run.