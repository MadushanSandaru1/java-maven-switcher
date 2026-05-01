#!/usr/bin/env bash

USEJAVA_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$USEJAVA_HOME/config/versions.conf"

_to_gitbash_path() {
  echo "$1" | sed 's#\\#/#g' | sed 's#^\([A-Za-z]\):#/\L\1#'
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

Java Maven Switcher v2

Usage:
  usejava <version>                  Switch Java/Maven version
  usejava list                       List configured versions
  usejava active                     Show active Java/Maven
  usejava add <version> <jdk> <mvn>  Add new version
  usejava remove <version>           Remove version
  usejava help                       Show help

Examples:
  usejava 17
  usejava add 21 "C:\\Program Files\\Java\\jdk-21" "C:\\Program Files\\Maven\\apache-maven-3.9.11"
  usejava remove 8

EOF
}

_usejava_list() {
  echo ""
  echo "Configured Java/Maven Versions:"
  echo "--------------------------------"

  grep -v '^#' "$CONFIG_FILE" | grep -v '^$' | while IFS='|' read -r version java_home maven_home; do
    echo "$version"
    echo "  JAVA_HOME  = $java_home"
    echo "  MAVEN_HOME = $maven_home"
    echo ""
  done
}

_usejava_active() {
  echo ""
  echo "Active Environment:"
  echo "JAVA_HOME  = $JAVA_HOME"
  echo "MAVEN_HOME = $MAVEN_HOME"
  echo ""
  java -version 2>/dev/null
  echo ""
  mvn -version 2>/dev/null
}

_usejava_switch() {
  local version="$1"
  local line

  line=$(grep -v '^#' "$CONFIG_FILE" | grep "^$version|")

  if [ -z "$line" ]; then
    echo "Version not found: $version"
    echo "Run: usejava list"
    return 1
  fi

  IFS='|' read -r version java_home_win maven_home_win <<< "$line"

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

_usejava_add() {
  local version="$1"
  local java_home="$2"
  local maven_home="$3"

  if [ -z "$version" ] || [ -z "$java_home" ] || [ -z "$maven_home" ]; then
    echo "Usage: usejava add <version> <JAVA_HOME> <MAVEN_HOME>"
    return 1
  fi

  if grep -q "^$version|" "$CONFIG_FILE"; then
    echo "Version already exists: $version"
    return 1
  fi

  echo "$version|$java_home|$maven_home" >> "$CONFIG_FILE"
  echo "Added Java version: $version"
}

_usejava_remove() {
  local version="$1"

  if [ -z "$version" ]; then
    echo "Usage: usejava remove <version>"
    return 1
  fi

  if ! grep -q "^$version|" "$CONFIG_FILE"; then
    echo "Version not found: $version"
    return 1
  fi

  grep -v "^$version|" "$CONFIG_FILE" > "$CONFIG_FILE.tmp"
  mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

  echo "Removed Java version: $version"
}