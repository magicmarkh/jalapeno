#!/bin/bash
FLAG="/var/log/sia_init_done"
SCRIPT_DIR="/opt/sia"
NEW_HOSTNAME="${hostname}"

if [ ! -f "$FLAG" ]; then
  echo "First boot: configuring SIA connector..."

  mkdir -p "$SCRIPT_DIR"

  # --- Write rename-hostname.sh ---
  cat <<'EOF' > "$SCRIPT_DIR/rename-hostname.sh"
${rename_hostname_script}
EOF

  chmod +x "$SCRIPT_DIR/rename-hostname.sh"
  "$SCRIPT_DIR/rename-hostname.sh" "$NEW_HOSTNAME"

  echo "Registering connector with CyberArk..."
  # TODO: add CyberArk registration logic here

  touch "$FLAG"
else
  echo "SIA connector already initialized. Skipping."
fi
