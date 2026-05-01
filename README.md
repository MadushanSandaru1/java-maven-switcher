# Java Maven Switcher ⚡

A lightweight **dynamic Java + Maven version manager** for Windows CMD and Git Bash.

Switch, list, add, remove, and check active Java/Maven versions using one simple command:

```
usejava 17
```

---

## 🚀 Features

- Switch Java + Maven versions instantly
- Works with Windows CMD
- Works with Git Bash
- Dynamic config file (no script edits needed)
- Add/remove versions easily
- List available versions
- Show active environment
- Safe (session-based, no permanent changes)

---

## 📁 Project Structure

```
java-maven-switcher/
├─ config/
│  └─ versions.conf
├─ scripts/
│  ├─ usejava.bat
│  └─ usejava.sh
├─ .gitignore
├─ README.md
└─ LICENSE
```

---

## ⚙️ Commands

```
usejava help
usejava list
usejava active
usejava 8
usejava 17
usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
usejava remove 21
```

---

## 🧩 Config File

Location:

```
config/versions.conf
```

Format:

```
version|JAVA_HOME|MAVEN_HOME
```

Example:

```
8|C:\Program Files\Java\jdk1.8.0_202|C:\Program Files\Maven\apache-maven-3.6.3
17|C:\Program Files\Java\jdk-17|C:\Program Files\Maven\apache-maven-3.9.11
21|C:\Program Files\Java\jdk-21|C:\Program Files\Maven\apache-maven-3.9.11
```

---

# 🐧 Git Bash Setup

### 1. Clone Repository

```
git clone https://github.com/MadushanSandaru1/java-maven-switcher.git
```

---

### 2. Open `.bashrc`

```
nano ~/.bashrc
```

---

### 3. Add This Line

```
source "/c/Tools/java-maven-switcher/scripts/usejava.sh"
```

(Adjust path based on your location)

---

### 4. Reload

```
source ~/.bashrc
```

---

### 5. Test

```
usejava help
usejava list
usejava 17
```

---

# 🪟 Windows CMD Setup

### 1. Place Repo

Example:

```
C:\Tools\java-maven-switcher
```

---

### 2. Add to PATH

Add this:

```
C:\Tools\java-maven-switcher\scripts
```

Steps:

- Search "Environment Variables"
- Edit system environment variables
- Open "Environment Variables"
- Edit "Path"
- Add new entry above path

---

### 3. Open New CMD

Then run:

```
usejava help
usejava list
usejava 17
```

---

# 🧪 Usage Guide

## Show Help

```
usejava help
```

---

## List Versions

```
usejava list
```

---

## Switch Version

```
usejava 17
usejava 8
```

---

## Active Version

```
usejava active
```

---

## Add Version

```
usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
```

---

## Remove Version

```
usejava remove 21
```

---

# 🔍 Verify

```
java -version
mvn -version
```

---

# ⚠️ Notes

- Only affects current terminal session
- No permanent system changes
- Run `usejava` again in new terminals
- Git Bash auto converts Windows paths

---

# 💡 Example Workflow

```
usejava list
usejava 17
usejava active
mvn clean install
usejava 8
java -version
```

---

# 📜 License

MIT License © 2026 Madhushan Sandaruwan