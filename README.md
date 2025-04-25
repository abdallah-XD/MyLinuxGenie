# MyLinuxGenie

*A Bash project crafted with care by Abdullah Elmallah (Abdallah-XD)*

A fun and fearless Bash script that checks system health, updates your OS, saves command history, downloads YouTube videos, and even plays a risky number game—with colors, logs, and a whole lot of character. MyLinuxGenie makes the terminal anything but boring! 🎮🐧

## 🧠 MyLinuxGenie - Your Bash Buddy in the Linux Universe 😎

**MyLinuxGenie** is a fun and functional Bash script packed with helpful tools, playful vibes, and a hint of chaos—all wrapped in a charming terminal UI. Whether you're checking your system or playing a guessing game that *may or may not restart your PC*, it's got your back.

---

### 🚀 Features

#### 🔍 1. **System Health Check**

With a single click, get a quick overview of your machine:

- **CPU load**
- **Memory usage**
- **Free disk space**\
  And yes, it's all logged like a pro.

---

#### ⬆️ 2. **System Update**

Running a Debian-based system? MyLinuxGenie lets you run full system updates with a quick confirmation prompt—no surprises here (well… maybe just one 😅).

---

#### 👵️ 3. **Command History**

- Automatically saves your Bash history to a tidy file in `~/Downloads`
- Shows the last 10 commands
- Opens it in `gedit` if you're feeling graphical

---

#### 🎮 4. **Number Guessing Game**

A terminal game that dares you to guess a number between 1–15.\
Win? You're a legend.\
Lose? Say goodbye... **literally** (⚠️ triggers a system reboot!)

---

#### 📅 5. **YouTube Video Downloader**

Download videos or audio from YouTube using `yt-dlp` + `ffmpeg`. Choose the quality, paste the link, and let MyLinuxGenie do the magic. Files are saved cleanly to `~/Downloads/YT_downloads`.

---

#### 📜 6. **Log Viewer**

Every action is logged in `linux_bash.log`, and you can view it from the main menu.

---

### 🛠️ Built With:

- 100% Pure Bash
- Colorful terminal UI
- Friendly error handling
- Humor included (free of charge)

---
### 🧪 How to Use
Run the script in your terminal:

```bash
   ./mylinuxgenie.sh
 OR
bash mylinuxgenie.sh

### ⚠️ Notes:

- Don’t run as root. MyLinuxGenie will yell at you.
- Designed for Debian/Ubuntu-based systems.
- Internet connection needed for some features (like `yt-dlp` installation).

---
```
### 🤖 Why MyLinuxGenie?

> “If your terminal was a movie, MyLinuxGenie would be the comic relief hero that still saves the day.” 🎮

