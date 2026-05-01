$USEJAVA_HOME = Split-Path -Parent $PSScriptRoot
$CONFIG_FILE = Join-Path $USEJAVA_HOME "config\versions.json"

function usejava {
    param (
        [string]$cmd,
        [string]$arg1,
        [string]$arg2,
        [string]$arg3
    )

    switch ($cmd) {
        "" { Show-Help }
        "help" { Show-Help }
        "list" { Show-List }
        "active" { Show-Active }
        "doctor" { Show-Doctor }
        "default" { Set-Default $arg1 }
        "add" { Add-Version $arg1 $arg2 $arg3 }
        "remove" { Remove-Version $arg1 }
        default { Switch-Version $cmd }
    }
}

function Read-Config {
    if (-not (Test-Path $CONFIG_FILE)) {
        Write-Host "Config file not found: $CONFIG_FILE"
        return $null
    }

    return Get-Content $CONFIG_FILE -Raw | ConvertFrom-Json
}

function Save-Config {
    param ($config)

    $config | ConvertTo-Json -Depth 10 | Set-Content $CONFIG_FILE
}

function Show-Help {
    Write-Host ""
    Write-Host "Java Maven Switcher v3"
    Write-Host "-------------------------------------"
    Write-Host "usejava help"
    Write-Host "usejava list"
    Write-Host "usejava active"
    Write-Host "usejava doctor"
    Write-Host "usejava default <version>"
    Write-Host "usejava <version>"
    Write-Host "usejava add <version> <JAVA_HOME> <MAVEN_HOME>"
    Write-Host "usejava remove <version>"
    Write-Host ""
}

function Show-List {
    $config = Read-Config
    if (-not $config) { return }

    Write-Host ""
    Write-Host "Configured Versions"
    Write-Host "-------------------------------------"
    Write-Host "Default: $($config.default)"
    Write-Host ""

    $config.versions.PSObject.Properties | ForEach-Object {
        Write-Host "$($_.Name)"
        Write-Host "  JAVA_HOME  = $($_.Value.javaHome)"
        Write-Host "  MAVEN_HOME = $($_.Value.mavenHome)"
        Write-Host ""
    }
}

function Show-Active {
    Write-Host ""
    Write-Host "Active Environment"
    Write-Host "-------------------------------------"
    Write-Host "JAVA_HOME  = $env:JAVA_HOME"
    Write-Host "MAVEN_HOME = $env:MAVEN_HOME"
    Write-Host ""

    java -version
    Write-Host ""
    mvn -version
}

function Show-Doctor {
    $config = Read-Config
    if (-not $config) { return }

    Write-Host ""
    Write-Host "Doctor Check"
    Write-Host "-------------------------------------"

    $hasIssue = $false

    $config.versions.PSObject.Properties | ForEach-Object {
        $version = $_.Name
        $javaHome = $_.Value.javaHome
        $mavenHome = $_.Value.mavenHome

        Write-Host ""
        Write-Host "Version: $version"

        if (Test-Path $javaHome) {
            Write-Host "  JAVA_HOME  OK      $javaHome"
        } else {
            Write-Host "  JAVA_HOME  BROKEN  $javaHome"
            $hasIssue = $true
        }

        if (Test-Path $mavenHome) {
            Write-Host "  MAVEN_HOME OK      $mavenHome"
        } else {
            Write-Host "  MAVEN_HOME BROKEN  $mavenHome"
            $hasIssue = $true
        }
    }

    Write-Host ""

    if ($hasIssue) {
        Write-Host "Result: Some paths are broken."
    } else {
        Write-Host "Result: All configured paths look good."
    }
}

function Switch-Version {
    param ($version)

    $config = Read-Config
    if (-not $config) { return }

    $target = $config.versions.PSObject.Properties[$version]

    if (-not $target) {
        Write-Host "Version not found: $version"
        Write-Host "Run: usejava list"
        return
    }

    $javaHome = $target.Value.javaHome
    $mavenHome = $target.Value.mavenHome

    if (-not (Test-Path $javaHome)) {
        Write-Host "JAVA_HOME not found: $javaHome"
        return
    }

    if (-not (Test-Path $mavenHome)) {
        Write-Host "MAVEN_HOME not found: $mavenHome"
        return
    }

    $env:JAVA_HOME = $javaHome
    $env:MAVEN_HOME = $mavenHome
    $env:PATH = "$javaHome\bin;$mavenHome\bin;" + $env:PATH

    Write-Host ""
    Write-Host "Switched to Java $version"
    Write-Host "JAVA_HOME  = $env:JAVA_HOME"
    Write-Host "MAVEN_HOME = $env:MAVEN_HOME"
    Write-Host ""

    java -version
    Write-Host ""
    mvn -version
}

function Set-Default {
    param ($version)

    if (-not $version) {
        Write-Host "Usage: usejava default <version>"
        return
    }

    $config = Read-Config
    if (-not $config) { return }

    $target = $config.versions.PSObject.Properties[$version]

    if (-not $target) {
        Write-Host "Version not found: $version"
        return
    }

    $config.default = $version
    Save-Config $config

    Write-Host "Default version set to: $version"
}

function Add-Version {
    param ($version, $jdk, $mvn)

    if (-not $version -or -not $jdk -or -not $mvn) {
        Write-Host "Usage: usejava add <version> <JAVA_HOME> <MAVEN_HOME>"
        return
    }

    $config = Read-Config
    if (-not $config) { return }

    if ($config.versions.PSObject.Properties[$version]) {
        Write-Host "Version already exists: $version"
        return
    }

    $config.versions | Add-Member -MemberType NoteProperty -Name $version -Value @{
        javaHome = $jdk
        mavenHome = $mvn
    }

    Save-Config $config

    Write-Host "Added version: $version"
}

function Remove-Version {
    param ($version)

    if (-not $version) {
        Write-Host "Usage: usejava remove <version>"
        return
    }

    $config = Read-Config
    if (-not $config) { return }

    if (-not $config.versions.PSObject.Properties[$version]) {
        Write-Host "Version not found: $version"
        return
    }

    $config.versions.PSObject.Properties.Remove($version)

    if ($config.default -eq $version) {
        $config.default = ""
    }

    Save-Config $config

    Write-Host "Removed version: $version"
}