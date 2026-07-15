#!/usr/bin/env bash

USEJAVA_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$(cygpath -w "$USEJAVA_HOME/config/versions.json")"

_to_gitbash_path() {
  echo "$1" | sed 's#\\#/#g' | sed -E 's#^([A-Za-z]):#/\L\1#'
}

_read_json_value() {
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-Content '$CONFIG_FILE' -Raw | ConvertFrom-Json; $1" | tr -d '\r'
}

usejava() {
  local cmd="$1"

  case "$cmd" in
    ""|help|-h|--help)
      _usejava_help
      ;;
    list)
      _usejava_list
      ;;
    active)
      _usejava_active
      ;;
    doctor)
      _usejava_doctor
      ;;
    default)
      _usejava_default "$2"
      ;;
    add)
      _usejava_add "$2" "$3" "$4"
      ;;
    remove)
      _usejava_remove "$2"
      ;;
    *)
      _usejava_switch "$cmd"
      ;;
  esac
}

_usejava_help() {
  cat <<EOF

Java Maven Switcher v3
-------------------------------------
usejava help
usejava list
usejava active
usejava doctor
usejava default <version>
usejava <version>
usejava add <version> <JAVA_HOME> <MAVEN_HOME>
usejava remove <version>

EOF
}

_usejava_list() {
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$c=Get-Content '$CONFIG_FILE' -Raw | ConvertFrom-Json;
    Write-Host '';
    Write-Host 'Configured Versions';
    Write-Host '-------------------------------------';
    Write-Host ('Default: ' + \$c.default);
    Write-Host '';
    \$c.versions.PSObject.Properties | ForEach-Object {
      Write-Host \$_.Name;
      Write-Host ('  JAVA_HOME  = ' + \$_.Value.javaHome);
      Write-Host ('  MAVEN_HOME = ' + \$_.Value.mavenHome);
      Write-Host '';
    }
  "
}

_usejava_active() {
  echo ""
  echo "Active Environment"
  echo "-------------------------------------"
  echo "JAVA_HOME  = $JAVA_HOME"
  echo "MAVEN_HOME = $MAVEN_HOME"
  echo ""
  java -version 2>/dev/null
  echo ""
  mvn -version 2>/dev/null
}

_usejava_doctor() {
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$c=Get-Content '$CONFIG_FILE' -Raw | ConvertFrom-Json;
    Write-Host '';
    Write-Host 'Doctor Check';
    Write-Host '-------------------------------------';
    \$hasIssue=\$false;
    \$c.versions.PSObject.Properties | ForEach-Object {
      \$version=\$_.Name;
      \$javaHome=\$_.Value.javaHome;
      \$mavenHome=\$_.Value.mavenHome;
      Write-Host '';
      Write-Host ('Version: ' + \$version);
      if(Test-Path \$javaHome){ Write-Host ('  JAVA_HOME  OK      ' + \$javaHome) } else { Write-Host ('  JAVA_HOME  BROKEN  ' + \$javaHome); \$hasIssue=\$true }
      if(Test-Path \$mavenHome){ Write-Host ('  MAVEN_HOME OK      ' + \$mavenHome) } else { Write-Host ('  MAVEN_HOME BROKEN  ' + \$mavenHome); \$hasIssue=\$true }
    }
    Write-Host '';
    if(\$hasIssue){ Write-Host 'Result: Some paths are broken.' } else { Write-Host 'Result: All configured paths look good.' }
  "
}

_usejava_switch() {
  local version="$1"

  local java_home_win
  local maven_home_win

  java_home_win=$(_read_json_value "\$v=\$c.versions.PSObject.Properties['$version']; if(\$v){ \$v.Value.javaHome }")
  maven_home_win=$(_read_json_value "\$v=\$c.versions.PSObject.Properties['$version']; if(\$v){ \$v.Value.mavenHome }")

  if [ -z "$java_home_win" ]; then
    echo "Version not found: $version"
    echo "Run: usejava list"
    return 1
  fi

  local java_home
  local maven_home

  java_home=$(_to_gitbash_path "$java_home_win")
  maven_home=$(_to_gitbash_path "$maven_home_win")

  if [ ! -d "$java_home" ]; then
    echo "JAVA_HOME not found: $java_home"
    return 1
  fi

  if [ ! -d "$maven_home" ]; then
    echo "MAVEN_HOME not found: $maven_home"
    return 1
  fi

  PATH=$(echo "$PATH" | tr ':' '\n' | grep -vi "/Program Files/Java/" | grep -vi "/Program Files/Maven/" | paste -sd ':' -)

  export JAVA_HOME="$java_home"
  export MAVEN_HOME="$maven_home"
  export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

  echo ""
  echo "Switched to Java $version"
  echo "JAVA_HOME  = $JAVA_HOME"
  echo "MAVEN_HOME = $MAVEN_HOME"
  echo ""
  java -version
  echo ""
  mvn -version
}

_usejava_default() {
  local version="$1"

  if [ -z "$version" ]; then
    echo "Usage: usejava default <version>"
    return 1
  fi

  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$file='$CONFIG_FILE';
    \$c=Get-Content \$file -Raw | ConvertFrom-Json;
    \$v=\$c.versions.PSObject.Properties['$version'];
    if(-not \$v){ Write-Host 'Version not found: $version'; exit 1 }
    \$c.default='$version';
    \$c | ConvertTo-Json -Depth 10 | Set-Content \$file;
    Write-Host 'Default version set to: $version';
  "
}

_usejava_add() {
  local version="$1"
  local java_home="$2"
  local maven_home="$3"

  if [ -z "$version" ] || [ -z "$java_home" ] || [ -z "$maven_home" ]; then
    echo "Usage: usejava add <version> <JAVA_HOME> <MAVEN_HOME>"
    return 1
  fi

  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$file='$CONFIG_FILE';
    \$c=Get-Content \$file -Raw | ConvertFrom-Json;
    if(\$c.versions.PSObject.Properties['$version']){ Write-Host 'Version already exists: $version'; exit 1 }
    \$c.versions | Add-Member -MemberType NoteProperty -Name '$version' -Value @{ javaHome='$java_home'; mavenHome='$maven_home' };
    \$c | ConvertTo-Json -Depth 10 | Set-Content \$file;
    Write-Host 'Added version: $version';
  "
}

_usejava_remove() {
  local version="$1"

  if [ -z "$version" ]; then
    echo "Usage: usejava remove <version>"
    return 1
  fi

  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$file='$CONFIG_FILE';
    \$c=Get-Content \$file -Raw | ConvertFrom-Json;
    if(-not \$c.versions.PSObject.Properties['$version']){ Write-Host 'Version not found: $version'; exit 1 }
    \$c.versions.PSObject.Properties.Remove('$version');
    if(\$c.default -eq '$version'){ \$c.default='' }
    \$c | ConvertTo-Json -Depth 10 | Set-Content \$file;
    Write-Host 'Removed version: $version';
  "
}
