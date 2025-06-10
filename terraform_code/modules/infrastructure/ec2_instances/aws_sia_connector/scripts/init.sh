Great — to make the hostname dynamic and passed via Terraform, you’ll want to use a `templatefile()` function so that Terraform can inject the value into your `init_connector.sh` script.

---

### ✅ Step 1: Create a Terraform variable

#### `variables.tf`

```hcl
variable "sia_hostname" {
  description = "Hostname for the SIA connector EC2 instance"
  type        = string
}
```

---

### ✅ Step 2: Update your Terraform module call

#### `main.tf`

```hcl
module "sia" {
  source = "github.com/magicmarkh/murphys_lab//terraform_code/modules/infrastructure/ec2_instances/aws_sia_connector?ref=main"

  computer_name = "connector_1"

  user_data = templatefile("${path.module}/scripts/init_connector.sh.tpl", {
    hostname = var.sia_hostname
  })
}
```

---

### ✅ Step 3: Rename and update the user data script template

Rename your current `init_connector.sh` to `init_connector.sh.tpl` and replace the hardcoded hostname:

#### `scripts/init_connector.sh.tpl`

```bash
#!/bin/bash

FLAG="/var/log/sia_init_done"
SCRIPT_DIR="/opt/sia"
NEW_HOSTNAME="${hostname}"

if [ ! -f "$FLAG" ]; then
  echo "First boot: configuring SIA connector..."

  mkdir -p "$SCRIPT_DIR"

  ########## Section 1: Rename Hostname ##########
  echo "Setting hostname to $NEW_HOSTNAME"
  hostnamectl set-hostname "$NEW_HOSTNAME"

  # Update /etc/hosts
  if grep -q '^127\.0\.1\.1' /etc/hosts; then
    sed -i "s/^127\.0\.1\.1.*/127.0.1.1 $NEW_HOSTNAME/" /etc/hosts
  else
    echo "127.0.1.1 $NEW_HOSTNAME" >> /etc/hosts
  fi

  ########## Section 2: Register CyberArk Connector ##########
  echo "Registering CyberArk SIA connector..."
  # Placeholder for actual registration logic

  ########## Done ##########
  echo "SIA setup complete."
  touch "$FLAG"
else
  echo "SIA connector already initialized. Skipping setup."
fi
```

---

Now the hostname will be dynamically injected by Terraform at plan/apply time.

Let me know if you want to include other variables like registration tokens, region, or connector IDs.
