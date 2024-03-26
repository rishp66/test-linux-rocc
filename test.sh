
#!/bin/bash

# Function to display a menu and prompt for user input
display_menu() {
  echo "==== Networking Workshop Menu ===="
  echo "1. Ping a host"
  echo "2. Trace the route to a host"
  echo "3. Display network interface information"
  echo "4. Configure a static IP address (Linux only)"
  echo "5. Quit"
  read -p "Enter your choice [1-5]: " choice
}

# Function to ping a host
ping_host() {
  read -p "Enter the hostname or IP address to ping: " host
  ping -c 4 "$host"
}

# Function to trace the route to a host
traceroute_host() {
  read -p "Enter the hostname or IP address to trace: " host
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    traceroute "$host"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    traceroute -q 1 "$host"
  else
    echo "Unsupported operating system."
  fi
}

# Function to display network interface information
display_interfaces() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ip addr show
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    ifconfig
  else
    echo "Unsupported operating system."
  fi
}

# Function to configure a static IP address (Linux only)
configure_static_ip() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    read -p "Enter the network interface (e.g., eth0): " interface
    read -p "Enter the static IP address (e.g., 192.168.1.100): " ip_address
    read -p "Enter the subnet mask (e.g., 255.255.255.0): " subnet_mask
    read -p "Enter the default gateway: " gateway

    sudo ip addr add "$ip_address"/"$subnet_mask" dev "$interface"
    sudo ip route add default via "$gateway"
    echo "Static IP configured successfully!"
  else
    echo "Static IP configuration is only supported on Linux."
  fi
}

# Main loop
while true; do
  display_menu
  case $choice in
    1) ping_host ;;
    2) traceroute_host ;;
    3) display_interfaces ;;
    4) configure_static_ip ;;
    5) echo "Exiting..."; break ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
  echo
done
```

Please note that the static IP configuration function is still marked as "Linux only" since it uses the `ip` command, which is specific to Linux. Configuring a static IP on macOS would require a different approach.

This modified script should be more compatible and run without issues on both Linux and macOS systems.
