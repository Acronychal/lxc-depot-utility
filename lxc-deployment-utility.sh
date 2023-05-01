#! /bin/bash
clear
# Lookup available distribution templates
DISTRO_LIST=($(ls /var/lib/vz/template/cache ))

# Display the list of distros with corresponding numbers
echo "Please select a distribution:"
for i in "${!DISTRO_LIST[@]}"; do
    echo "$((i+1)). ${DISTRO_LIST[$i]}"
done

# Prompt the user for their choice
read -p "Enter the number of your choice: " choice

# Validate the user's choice
if (( choice >= 1 && choice <= ${#DISTRO_LIST[@]} )); then
    SELECTED_DISTRO="${DISTRO_LIST[choice-1]}"
    echo "You selected: $SELECTED_DISTRO"
else
    echo "Invalid choice. Please try again."
fi

# Prompt the user to select the container size
echo "Please select lxc container size:"
echo "SM 2 Cores & 2gb RAM | MD 4 Cores & 4gb RAM | LG 4 Cores & 8gb RAM"
read -p "Enter container size : " CHOICE

# Define the options and corresponding sizes
SM=("2" "2048")
MD=("4" "4096")
LG=("8" "8192")

# Validate the user's choice and assign the size variables
case "$CHOICE" in
    "SM")
        CORES="${SM[0]}"
        RAM="${SM[1]}"
        ;;
    "MD")
        CORES="${MD[0]}"
        RAM="${MD[1]}"
        ;;
    "LG")
        CORES="${LG[0]}"
        RAM="${LG[1]}"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Print the selected container size variables
echo "Selected container size: cores = $CORES, RAM = $RAM"

# Prompt the user for additional parameters
read -p "Container Name : " CTNAME
read -p "Container ID : " CTID
read -p "Container Disk Size : " CTDISK
read -sp "Container Root Password : " ROOTPASSWD

#checkpoint
echo $CTNAME, $CTID,$CORES,$RAM,$SELECTED_DISTRO, $CTDISK

# Create container
pct create $CTID /var/lib/vz/template/cache/$SELECTED_DISTRO \
    --cores $CORES \
    --description "medium 4 core 4gb debian lxc container" \
    --hostname $CTNAME \
    --memory $RAM \
    --password "$ROOTPASSWD" \
    --storage local-lvm \
    --net0 name=eth0,bridge=vmbr0,ip='192.168.1.128/24',gw='192.168.1.1' \
    --rootfs local-lvm:$CTDISK \
    --features nesting=1 \
    --unprivileged 1 \
    --timezone host