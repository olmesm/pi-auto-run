#! /bin/sh

directory=/boot/auto-run
file_name=wifi.config
file=$directory/$file_name

# Check if file exists
if [ -f "$file" ]
then
    # Create backup
    cat /etc/wpa_supplicant/wpa_supplicant.conf > "$directory/backup_$file_name"
    
    # Update wifi config
    cat $file > /etc/wpa_supplicant/wpa_supplicant.conf
    
    # Remove the update file
    rm $file

    # Restart the Wifi
    sleep 5
    wpa_cli -i wlan0 reconfigure
fi

cat /etc/wpa_supplicant/wpa_supplicant.conf > "$directory/current_$file_name"