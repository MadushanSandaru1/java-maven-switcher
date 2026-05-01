# ⚡ Java Maven Switcher

<p align="center">
  <b>Dynamic Java & Maven Version Manager for Windows CMD and Git Bash</b><br/>
  Switch, manage, and control multiple JDK & Maven versions with ease.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-windows-blue" />
  <img src="https://img.shields.io/badge/shell-cmd%20%7C%20gitbash-green" />
  <img src="https://img.shields.io/badge/license-MIT-black" />
  <img src="https://img.shields.io/badge/status-active-success" />
</p>

---

## ✨ Features

- 🔄 Switch Java & Maven versions instantly
- ⚙️ Dynamic configuration (no script edits required)
- ➕ Add / ❌ Remove versions on the fly
- 📋 List all configured versions
- 🔍 Check active environment
- 🧩 Works on **Windows CMD** and **Git Bash**
- 🛡️ Safe (no permanent system changes)

---

## 📦 Installation

### 1. Clone Repository

```bash
git clone https://github.com/MadushanSandaru1/java-maven-switcher.git
```

---

## 🐧 Git Bash Setup

### Step 1: Open `.bashrc`

```bash
nano ~/.bashrc
```

---

### Step 2: Add Script

```bash
source "/c/path/to/java-maven-switcher/scripts/usejava.sh"
```

---

### Step 3: Reload

```bash
source ~/.bashrc
```

---

### Step 4: Test

```bash
usejava help
```

---

## 🪟 Windows CMD Setup

### Step 1: Place Project

Example:

```
C:\Tools\java-maven-switcher
```

---

### Step 2: Add Scripts Folder to PATH

```
C:\Tools\java-maven-switcher\scripts
```

---

### Step 3: Restart CMD

Open a new CMD window.

---

### Step 4: Test

```cmd
usejava help
```

---

## ⚙️ Commands

```bash
usejava help
usejava list
usejava active
usejava 8
usejava 17
```

### ➕ Add Version

```bash
usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
```

### ❌ Remove Version

```bash
usejava remove 21
```

---

## 📁 Project Structure

```
java-maven-switcher/
├─ config/
│  └─ versions.conf
├─ scripts/
│  ├─ usejava.bat
│  └─ usejava.sh
├─ README.md
└─ LICENSE
```

---

## 🧩 Configuration

Edit:

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
```

---

## 🔍 Verify

```bash
java -version
mvn -version
```

---

## ⚠️ Important Notes

- Changes apply **only to current terminal session**
- No permanent system changes are made
- Run `usejava` again in new terminals

---

## 💡 Example Workflow

```bash
usejava list
usejava 17
mvn clean install
usejava 8
java -version
```

---

## 🚀 Roadmap

- [ ] PowerShell support
- [ ] Default version command (`usejava default`)
- [ ] Auto-detect installed JDKs
- [ ] Interactive CLI mode
- [ ] Global config support

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo
2. Create your feature branch
3. Commit your changes
4. Push and open a PR

---

## 📜 License

MIT License © 2026 Madhushan Sandaruwan

---

## ⭐ Support

If you found this useful:

- ⭐ Star the repo  
- 🍴 Fork it  
- 🧠 Share improvements  

---