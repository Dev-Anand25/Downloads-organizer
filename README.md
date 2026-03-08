**Make it executable**
```
chmod +x organize_downloads_boot.sh
```
**Run Automatically After Boot**  *(Using systemd)*

Create a user service:
```
nano ~/.config/systemd/user/download-organizer.service
```
Paste:
```
[Unit]
Description=Organize Downloads After Boot

[Service]
Type=oneshot
ExecStart=/home/$USER/organize_downloads_boot.sh

[Install]
WantedBy=default.target
```
Enable it:
```
systemctl --user daemon-reload
systemctl --user enable download-organizer
```
Now the script runs once every time the system boots
