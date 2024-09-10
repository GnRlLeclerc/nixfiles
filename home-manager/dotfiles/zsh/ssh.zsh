# SSH completion for my custom folder
hosts=()
config_files=(~/.ssh/config ~/.ssh/config-br/config)

extract_hosts() {
    # Read the file content and process each line
    while IFS= read -r line || [[ -n $line ]]; do
        # Remove carriage return characters that might have been included from Windows-style line endings
        line="${line//$'\r'/}"
        # Check if the line starts with "Host" and process it
        if [[ "$line" =~ ^Host[[:space:]]+ ]]; then
            # Extract the host name by removing 'Host ' and trim any leading or trailing whitespace
            host_name=${line#Host }
            host_name=${host_name%%*( )}
            hosts+=("$host_name")
        fi
    done < $1
}

# Extract host names from all SSH configuration files
for config_file in $config_files; do
    if [[ -f $config_file ]]; then
        extract_hosts $config_file
    fi
done

# Set up command-line completion for ssh if hosts are gathered
if (( ${#hosts} > 0 )); then
    zstyle ':completion:*:ssh:*' hosts $hosts
    zstyle ':completion:*:slogin:*' hosts $hosts
fi
