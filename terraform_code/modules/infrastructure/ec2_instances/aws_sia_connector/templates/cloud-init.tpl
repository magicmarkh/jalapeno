#cloud-config

# 1) Make sure /opt/sia exists before write_files runs
bootcmd:
  - mkdir -p /opt/sia

write_files:
  - path: /opt/sia/init.sh
    owner: root:root
    permissions: '0755'
    content: |
      #!/usr/bin/env bash
      set -euo pipefail
      IFS=$'\n\t'

      # your init script (expects NEW_HOSTNAME as $1)
      ${init_script}

  - path: /opt/sia/register-connector.sh
    owner: root:root
    permissions: '0755'
    content: |
      #!/usr/bin/env bash
      set -euo pipefail
      IFS=$'\n\t'

      # inject Terraform variables
      export AWS_REGION="${aws_region}"
      export PLATFORM_SECRET_ARN="${platform_secret_arn}"
      export IDENTITY_TENANT_ID="${identity_tenant_id}"
      export PLATFORM_TENANT_NAME="${platform_tenant_name}"
      export CONNECTOR_POOL_NAME="${connector_pool_name}"

      # your register script
      ${register_script}

runcmd:
  - bash -lc "/opt/sia/init.sh ${hostname} && /opt/sia/register-connector.sh"
