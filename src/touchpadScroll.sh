  #!/bin/bash
  set -e
  DEV="i2c-ELAN0522:01"
  echo -n "$DEV" > "/sys/bus/i2c/devices/$DEV/driver/unbind"
  sleep 1
  echo -n "$DEV" > "/sys/bus/i2c/drivers/i2c_hid_acpi/bind"
  echo "Done. Try two-finger scrolling now."
