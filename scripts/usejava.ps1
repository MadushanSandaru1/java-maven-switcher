# Java Maven Switcher - PowerShell Version

$USEJAVA_HOME = Split-Path -Parent $PSScriptRoot
$CONFIG_FILE = Join-Path $USEJAVA_HOME "config\versions.conf"

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
        "add" { Add-Version $arg1 $arg2 $arg3 }
        "remove" { Remove-Version $arg1 }
        default { Switch-Version $cmd }
    }
}

function Show-Help {
    Write-Host ""
    Write-Host "Java Maven Switcher (PowerShell)"
    Write-Host "-------------------------------------"
    Write-Host "usejava <version>"
    Write-Host "usejava list"
    Write-Host "usejava active"
    Write-Host "usejava add <version> <jdk> <mvn>"
    Write-Host "usejava remove <version>"
    Write-Host ""
}

function Show-List {
    Write-Host ""
    Write-Host "Configured Versions:"
    Write-Host "-------------------------------------"

    Get-Content $CONFIG_FILE | ForEach-Object {
        if ($_ -and -not $_.StartsWith("#")) {
            $parts = $_ -split "\|"
            Write-Host "$($parts[0])"
            Write-Host "  JAVA_HOME  = $($parts[1])"
            Write-Host "  MAVEN_HOME = $($parts[2])"
            Write-Host ""
        }
    }
}

function Show-Active {
    Write-Host ""
    Write-Host "Active Environment:"
    Write-Host "JAVA_HOME  = $env:JAVA_HOME"
    Write-Host "MAVEN_HOME = $env:MAVEN_HOME"
    Write-Host ""

    java -version
    ""
    mvn -version
}

function Switch-Version {
    param ($version)

    $line = Get-Content $CONFIG_FILE | Where-Object { $_ -match "^$version\|" }

    if (-not $line) {
        Write-Host "Version not found: $version"
        return
    }

    $parts = $line -split "\|"
    $javaHome = $parts[1]
    $mavenHome = $parts[2]

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
    ""
    mvn -version
}

function Add-Version {
    param ($version, $jdk, $mvn)

    if (-not $version -or -not $jdk -or -not $mvn) {
        Write-Host "Usage: usejava add <version> <jdk> <mvn>"
        return
    }

    $exists = Get-Content $CONFIG_FILE | Where-Object { $_ -match "^$version\|" }

    if ($exists) {
        Write-Host "Version already exists: $version"
        return
    }

    Add-Content $CONFIG_FILE "$version|$jdk|$mvn"
    Write-Host "Added version: $version"
}

function Remove-Version {
    param ($version)

    if (-not $version) {
        Write-Host "Usage: usejava remove <version>"
        return
    }

    $lines = Get-Content $CONFIG_FILE
    $filtered = $lines | Where-Object { $_ -notmatch "^$version\|" }

    Set-Content $CONFIG_FILE $filtered
    Write-Host "Removed version: $version"
}