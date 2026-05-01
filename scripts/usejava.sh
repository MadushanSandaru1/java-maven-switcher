# Java + Maven Version Switcher for Git Bash

usejava() {
  local version="$1"

  case "$version" in
    8)
      export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_202"
      export MAVEN_HOME="/c/Program Files/Maven/apache-maven-3.6.3"
      ;;
    17)
      export JAVA_HOME="/c/Program Files/Java/jdk-17"
      export MAVEN_HOME="/c/Program Files/Maven/apache-maven-3.9.11"
      ;;
    *)
      echo "Usage: usejava 8 | 17"
      return 1
      ;;
  esac

  if [ ! -d "$JAVA_HOME" ]; then
    echo "ERROR: JAVA_HOME not found: $JAVA_HOME"
    return 1
  fi

  if [ ! -d "$MAVEN_HOME" ]; then
    echo "ERROR: MAVEN_HOME not found: $MAVEN_HOME"
    return 1
  fi

  PATH=$(echo "$PATH" | tr ':' '\n' | grep -vi "/Program Files/Java/" | grep -vi "/Program Files/Maven/" | paste -sd ':' -)

  export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

  echo ""
  echo "====================================="
  echo "Active Java + Maven Environment"
  echo "====================================="
  echo "JAVA_HOME  = $JAVA_HOME"
  echo "MAVEN_HOME = $MAVEN_HOME"
  echo ""
  java -version
  echo ""
  mvn -version
}