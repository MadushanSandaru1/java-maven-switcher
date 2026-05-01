# Java Maven Switcher ⚡

A simple and lightweight **Java + Maven version switcher** for:

* 🪟 Windows CMD
* 🐧 Git Bash

Switch between multiple JDK and Maven versions instantly using a single command:

```bash
usejava 8
usejava 17
```

---

## 🚀 Features

* 🔄 Quickly switch Java & Maven versions
* ⚡ Works in both CMD and Git Bash
* 🧩 No installation required
* 🛠 Easy to customize paths
* 🎯 Session-based switching (safe, no global changes)

---

## 📁 Project Structure

```txt
java-maven-switcher/
├─ scripts/
│  ├─ usejava.bat      # Windows CMD script
│  └─ usejava.sh       # Git Bash script
├─ .gitignore
├─ README.md
└─ LICENSE
```

---

## ⚙️ Supported Versions

| Command      | Java Version | Maven Version |
| ------------ | ------------ | ------------- |
| `usejava 8`  | JDK 8        | Maven 3.6.3   |
| `usejava 17` | JDK 17       | Maven 3.9.11  |

---

## 🧪 1. Git Bash Setup

### Step 1: Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/java-maven-switcher.git
```

---

### Step 2: Update `.bashrc`

Open your `.bashrc`:

```bash
nano ~/.bashrc
```

Add this line:

```bash
source "/c/path/to/java-maven-switcher/scripts/usejava.sh"
```

Example:

```bash
source "/c/Users/YourName/java-maven-switcher/scripts/usejava.sh"
```

---

### Step 3: Set Default Version (Optional)

```bash
usejava 17
```

---

### Step 4: Reload Bash

```bash
source ~/.bashrc
```

---

### Step 5: Use Command

```bash
usejava 8
```

```bash
usejava 17
```

---

## 🪟 2. Windows CMD Setup

### Step 1: Copy Script

Place `usejava.bat` somewhere like:

```txt
C:\Tools\java-maven-switcher\scripts
```

---

### Step 2: Add to PATH

Add this folder to your **Environment Variables → Path**:

```txt
C:\Tools\java-maven-switcher\scripts
```

---

### Step 3: Use Command

Open new CMD and run:

```cmd
usejava 8
```

```cmd
usejava 17
```

---

## 🛠 Customize Paths (IMPORTANT)

Before using, update paths based on your system.

### 🔹 Git Bash (`usejava.sh`)

```bash
export JAVA_HOME="/c/Program Files/Java/jdk-17"
export MAVEN_HOME="/c/Program Files/Maven/apache-maven-3.9.11"
```

---

### 🔹 Windows CMD (`usejava.bat`)

```bat
set "JDK17=C:\Program Files\Java\jdk-17"
set "MAVEN3911=C:\Program Files\Maven\apache-maven-3.9.11"
```

---

## 🔍 Verify Setup

```bash
java -version
mvn -version
```

---

## ⚠️ Notes

* Changes apply **only to current terminal session**
* No permanent system changes are made
* You must run `usejava` again in new terminals

---

## 💡 Future Improvements

* Support for more JDK versions (11, 21, etc.)
* PowerShell script support
* Auto-detect installed JDKs
* Interactive CLI menu

---

## 📜 License

MIT License © 2026 Madushan Sandaruwan

---

## ⭐ Support

If this project helped you:

* ⭐ Star the repo
* 🍴 Fork it
* 🧠 Improve it

---
