# ⚡ Java Maven Switcher

<p align="center">
  <b>Dynamic Java & Maven Version Manager for Windows CMD, Git Bash & PowerShell</b><br/>
  Switch, manage, and control multiple JDK & Maven versions with ease.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-windows-blue" />
  <img src="https://img.shields.io/badge/shell-cmd%20%7C%20gitbash%20%7C%20powershell-green" />
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
- 🧩 Works on **CMD**, **Git Bash**, and **PowerShell**
- 🛡️ Safe (no permanent system changes)

---

## 📦 Installation

### Clone Repository

```bash
git clone https://github.com/MadushanSandaru1/java-maven-switcher.git
```

---

## 📁 Project Structure

```
java-maven-switcher/
├─ config/
│  └─ versions.conf
├─ scripts/
│  ├─ usejava.bat
│  ├─ usejava.sh
│  └─ usejava.ps1
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

## 🧩 Configuration

File:

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

### 1. Open `.bashrc`

```bash
nano ~/.bashrc
```

---

### 2. Add Script

```bash
source "/c/path/to/java-maven-switcher/scripts/usejava.sh"
```

---

### 3. Reload

```bash
source ~/.bashrc
```

---

### 4. Test

```bash
usejava help
usejava list
usejava 17
```

---

# 🪟 Windows CMD Setup

### 1. Place Project

Example:

```
C:\Tools\java-maven-switcher
```

---

### 2. Add Scripts Folder to PATH

```
C:\Tools\java-maven-switcher\scripts
```

Steps:

- Open "Environment Variables"
- Edit system environment variables
- Environment Variables
- Under "System variables" → Path → Edit
- Click "New"
- Add the path above
- Click OK

---

### 3. Restart CMD

Close all CMD windows and open a new one.

---

### 4. Test

```cmd
usejava help
usejava list
usejava 17
```

---

### ⚠️ Notes for CMD

- Works only per session
- Run `usejava` again in new CMD windows

---

# 🟦 PowerShell Setup

### 1. Load Script

```powershell
. "C:\Tools\java-maven-switcher\scripts\usejava.ps1"
```

---

### 2. Run Commands

```powershell
usejava help
usejava list
usejava 17
```

---

### ⚠️ Execution Policy Fix

If script is blocked:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

---

### 💡 Make It Permanent

```powershell
notepad $PROFILE
```

Add:

```powershell
. "C:\Tools\java-maven-switcher\scripts\usejava.ps1"
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

## Active Environment

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

# ⚠️ Important Notes

- Changes apply **only to current terminal session**
- No permanent system changes are made
- Run `usejava` again in new terminals

---

# 💡 Example Workflow

```
usejava list
usejava 17
mvn clean install
usejava 8
java -version
```

---

# 🚀 Roadmap

- [ ] PowerShell auto-load installer
- [ ] Default version command (`usejava default`)
- [ ] Auto-detect installed JDKs
- [ ] Interactive CLI mode
- [ ] Global config support

---

# 🤝 Contributing

Contributions are welcome!

1. Fork the repo  
2. Create your feature branch  
3. Commit your changes  
4. Push and open a PR  

---

# 📜 License

MIT License © 2026 Madhushan Sandaruwan

---

# ⭐ Support

If you found this useful:

- ⭐ Star the repo  
- 🍴 Fork it  
- 🧠 Share improvements  

---