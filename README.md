# ⚡ Java Maven Switcher

<p align="center">
  <b>Dynamic Java & Maven Version Manager for Windows CMD, Git Bash & PowerShell</b><br/>
  Switch, manage, and validate multiple JDK & Maven versions with ease.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-windows-blue" />
  <img src="https://img.shields.io/badge/shell-cmd%20%7C%20gitbash%20%7C%20powershell-green" />
  <img src="https://img.shields.io/badge/config-json-orange" />
  <img src="https://img.shields.io/badge/license-MIT-black" />
</p>

---

## ✨ Features

- 🔄 Switch Java & Maven versions instantly
- ⚙️ JSON-based configuration
- ⭐ Set default Java version
- 🩺 Doctor command to detect broken paths
- ➕ Add versions dynamically
- ❌ Remove versions dynamically
- 📋 List configured versions
- 🔍 Check active Java/Maven environment
- 🧩 Works on CMD, Git Bash, and PowerShell
- 🛡️ Safe session-based switching

---

## 📁 Project Structure

```txt
java-maven-switcher/
├─ config/
│  └─ versions.json
├─ scripts/
│  ├─ usejava.bat
│  ├─ usejava.sh
│  └─ usejava.ps1
├─ .gitignore
├─ README.md
└─ LICENSE
```

---

## 📦 Installation

```bash
git clone https://github.com/MadushanSandaru1/java-maven-switcher.git
```

Example location:

```txt
C:\Tools\java-maven-switcher
```

---

## 🧩 Configuration

Config file:

```txt
config/versions.json
```

Example:

```json
{
  "default": "17",
  "versions": {
    "8": {
      "javaHome": "C:\\Program Files\\Java\\jdk1.8.0_202",
      "mavenHome": "C:\\Program Files\\Maven\\apache-maven-3.6.3"
    },
    "17": {
      "javaHome": "C:\\Program Files\\Java\\jdk-17",
      "mavenHome": "C:\\Program Files\\Maven\\apache-maven-3.9.11"
    }
  }
}
```

---

## ⚙️ Commands

```bash
usejava help
usejava list
usejava active
usejava doctor
usejava default 17
usejava 8
usejava 17
usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
usejava remove 21
```

---

# 🐧 Git Bash Setup

## 1. Open `.bashrc`

```bash
nano ~/.bashrc
```

## 2. Add Script

```bash
source "/c/Tools/java-maven-switcher/scripts/usejava.sh"
```

## 3. Reload

```bash
source ~/.bashrc
```

## 4. Test

```bash
usejava help
usejava list
usejava doctor
usejava 17
```

---

# 🪟 Windows CMD Setup

## 1. Add Scripts Folder to PATH

Add this folder to your Windows PATH:

```txt
C:\Tools\java-maven-switcher\scripts
```

Steps:

```txt
Windows Search → Environment Variables
→ Edit the system environment variables
→ Environment Variables
→ System variables → Path → Edit
→ New
→ C:\Tools\java-maven-switcher\scripts
→ OK
```

## 2. Open New CMD

Close old CMD windows and open a new one.

## 3. Test

```cmd
usejava help
usejava list
usejava doctor
usejava 17
```

---

# 🟦 PowerShell Setup

## 1. Load Script

```powershell
. "C:\Tools\java-maven-switcher\scripts\usejava.ps1"
```

## 2. Run Commands

```powershell
usejava help
usejava list
usejava doctor
usejava 17
```

## 3. Execution Policy Fix

If PowerShell blocks the script:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## 4. Make It Permanent

Open PowerShell profile:

```powershell
notepad $PROFILE
```

Add this line:

```powershell
. "C:\Tools\java-maven-switcher\scripts\usejava.ps1"
```

---

# 🩺 Doctor Command

Use doctor to detect missing or broken Java/Maven paths:

```bash
usejava doctor
```

Example output:

```txt
Doctor Check
-------------------------------------

Version: 17
  JAVA_HOME  OK      C:\Program Files\Java\jdk-17
  MAVEN_HOME OK      C:\Program Files\Maven\apache-maven-3.9.11

Version: 21
  JAVA_HOME  BROKEN  C:\Program Files\Java\jdk-21
  MAVEN_HOME OK      C:\Program Files\Maven\apache-maven-3.9.11

Result: Some paths are broken.
```

---

# ⭐ Default Version

Set default version:

```bash
usejava default 17
```

This updates:

```json
"default": "17"
```

---

# 🔍 Active Environment

```bash
usejava active
```

Shows:

```txt
JAVA_HOME
MAVEN_HOME
java -version
mvn -version
```

---

# ➕ Add Version

```bash
usejava add 21 "C:\Program Files\Java\jdk-21" "C:\Program Files\Maven\apache-maven-3.9.11"
```

Then switch:

```bash
usejava 21
```

---

# ❌ Remove Version

```bash
usejava remove 21
```

---

# 💡 Example Workflow

```bash
usejava doctor
usejava list
usejava default 17
usejava 17
mvn clean install
usejava 8
java -version
```

---

# ⚠️ Important Notes

- Changes apply only to the current terminal session.
- No permanent system environment variables are changed.
- CMD and Git Bash use PowerShell internally to read JSON.
- Run `usejava doctor` after editing `versions.json`.
- Use double backslashes in JSON paths.

---

# 🚀 Roadmap

- [ ] Auto-detect installed JDKs
- [ ] Interactive menu mode
- [ ] Installer script
- [ ] Global config support
- [ ] npm-style CLI package

---

# 🤝 Contributing

Contributions are welcome.

1. Fork the repo
2. Create your feature branch
3. Commit your changes
4. Push and open a PR

---

# 📜 License

MIT License © 2026 Madhushan Sandaruwan

---

# ⭐ Support

If this project helped you:

- Star the repo
- Fork it
- Share improvements

---