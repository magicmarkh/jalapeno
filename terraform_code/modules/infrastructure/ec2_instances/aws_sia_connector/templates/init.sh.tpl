#!/bin/bash

FLAG="/var/log/sia_init_done"
SCRIPT_DIR="/opt/sia"
NEW_HOSTNAME="${hostname}"

if [ ! -f "$FLAG" ]; then
  echo "[init] First boot detected. Setting up connector..."

  mkdir -p "$SCRIPT_DIR"

  # Write init.sh to disk
  cat <<'EOF' > "$SCRIPT_DIR/init.sh"
${init_script}
EOF

  chmod +x "$SCRIPT_DIR/init.sh"

  # Run it with the hostname
  "$SCRIPT_DIR/init.sh" "$NEW_HOSTNAME"

  # Mark init complete
  touch "$FLAG"
else
  echo "[init] Already initialized. Skipping."
fi
