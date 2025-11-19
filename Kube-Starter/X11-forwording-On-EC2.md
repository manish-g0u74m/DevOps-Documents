# X11 Forwarding on EC2 (Ubuntu & Amazon Linux) + Running a Browser

This guide explains how to enable X11 forwarding on **Ubuntu EC2** and **Amazon Linux EC2**, verify it using `xclock`, and run a working graphical browser through MobaXterm or any X11 client.

---

# 1. Requirements

- MobaXterm installed on your local machine  
- X11 server in MobaXterm must be running (green icon at top-right)  
- SSH session must have **X11 Forwarding** enabled  
- EC2 security group must allow SSH (22)

---

# 2. Enable X11 Forwarding in MobaXterm

1. Open MobaXterm  
2. Create or edit your SSH session  
3. Go to **Advanced SSH settings**  
4. Enable: **X11-Forwarding**  
5. Set **Remote environment: Interactive shell**  
6. Save  
7. Start the X11 server (green “X” icon)  
8. Connect to EC2  
9. MobaXterm uses `ssh -Y` (trusted) internally

---

# 3. Ubuntu EC2: Enable and Verify X11

## 3.1 Install xauth

```bash
sudo apt update
sudo apt install xauth -y
```

## 3.2 Edit sshd_config
```bash
sudo nano /etc/ssh/sshd_config
```

Ensure these lines exist:

```
X11Forwarding yes
X11UseLocalhost yes
X11DisplayOffset 10
```

Restart SSH:

```bash
sudo systemctl restart ssh
```

## 3.3 Verify X11
```bash
echo $DISPLAY
sudo apt install x11-apps -y
xclock
```

If a clock window appears on your computer → X11 forwarding works.

# 4. Amazon Linux EC2: Enable and Verify X11
## 4.1 Install X11 tools and xauth

For Amazon Linux 2:

```bash
sudo yum install xorg-x11-xauth xorg-x11-apps -y
sudo yum groupinstall "X Window System" -y
```

## 4.2 Edit sshd_config
```bash
sudo nano /etc/ssh/sshd_config
```

Ensure these lines are present:

```
X11Forwarding yes
X11UseLocalhost yes
X11DisplayOffset 10
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

## 4.3 Verify X11
```bash
echo $DISPLAY
xclock
```

If the clock window appears, X11 is working.

# 5. Installing a Browser (Ubuntu & Amazon Linux)
## 5.1 Why not the default browser?

Ubuntu uses snap-based Chromium, which does not work well with X11 forwarding.
So we install the APT version.

Amazon Linux has no browser by default, so we install one through yum.

# 6. Install Chromium (APT Version – Ubuntu Only)

Add PPA:

```bash
sudo add-apt-repository ppa:xtradeb/apps -y
sudo apt update
```

Install Chromium:

```bash
sudo apt install chromium -y
```

Run:

```bash
chromium
```

# 7. Install Firefox (Amazon Linux)

For Amazon Linux 2:

```bash
sudo yum install firefox -y
```

Run:

```bash
firefox
```

# 8. Optional: Install Fonts (Better Rendering)

Ubuntu:

```bash
sudo apt install fontconfig fonts-dejavu-core -y
```

Amazon Linux:

```bash
sudo yum install dejavu-sans-fonts -y
```

# 9. Optional: Silent Chromium Warnings
```bash
chromium --disable-gpu --no-sandbox --disable-dev-shm-usage
```
