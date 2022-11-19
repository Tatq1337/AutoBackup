#!/bin/sh

ans=$(zenity --list \
  --title="" \
  --column="ID" --column="Mode"\
    1 "Local computer" \
    2 "SSH" )

delete=$(zenity --list \
  --title="Delete from directory?" \
  --column="ID" --column="Option" \
    1 "Yes" \
    2 "No")
    

if ((delete == 1)); then
	var="-avu --delete"
	
elif ((delete == 2)); then
	var="-avu"
	
fi

if ((ans == 1)); then
	Source=$(zenity  --file-selection --title="Choose a directory to backup"  --directory)
	Destination=$(zenity  --file-selection --title="Choose a destination"  --directory)
	echo $Source
	echo $Destination
	rsync $var --progress $Source $Destination 

else
	Source=$(zenity  --file-selection --title="Choose a directory to backup"  --directory)
	if ssh_address=$(zenity --entry \
	--title="" \
	--text="Type SSH address" \
	--entry-text "username@192.168.56.100:~/Destination")
	
	  then 
	  	echo $ssh_address
	  else 
	  	echo "Input empty!"
	fi
	rsync $var --progress $Source $ssh_address
fi





