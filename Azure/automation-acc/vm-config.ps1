Configuration VmConfig 
{
    Import-DscResource -ModuleName xStorage
    Import-DscResource -ModuleName xWebAdministration
    Import-DscResource -ModuleName cChoco

    Node 'localhost'
    {
        # Wait for Disk2
        xWaitforDisk Disk2 
        {
            DiskId = 2
            RetryIntervalSec = 60
            RetryCount = 60
        }

        # Create F volume
        xDisk FVolume
        {
            DiskId = 2
            DriveLetter = 'F'
            FSLabel = 'Data'
        }

        # Install WebServer
        WindowsFeature InstallWebServer
        {
            Ensure = 'Present'
            Name = 'Web-Server'
        }

        # Stop default website
        xWebsite DefaultSite
        {
            Ensure = 'Absent'
            Name = 'Default Web Site'
            PhysicalPath = 'C:\inetpub\wwwroot'
            DependsOn = '[WindowsFeature]InstallWebServer'
        }

        # Install chocolatey
        cChocoInstaller InstallChoco
        {
            InstallDir = 'C:\choco'
        }

        # Install core SDK
        cChocoPackageInstaller core_sdk
        {
            Name = 'dotnetcore-sdk'
            DependsOn = '[cChocoInstaller]InstallChoco'
        }

        # Install core runtime
        cChocoPackageInstaller core_runtime
        {
            Name = 'dotnetcore-windowshosting'
            DependsOn = '[cChocoInstaller]InstallChoco'
        }
    }
}

VmConfig