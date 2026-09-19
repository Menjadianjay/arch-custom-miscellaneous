  Resets the ELAN touchpad by unbinding and rebinding its I2C-HID driver. Fixes cases where two-finger scroll or the touchpad in general stops responding — commonly after
  suspend/resume.

  What it does

  1. Unbinds the device i2c-ELAN0522:01 from its current driver.
  2. Waits 1 second.
  3. Rebinds it to the i2c_hid_acpi driver.

  Usage

  sudo ./fix-touchpad.sh

  Requires root — the script writes to /sys/bus/i2c/devices/.../driver/unbind and /sys/bus/i2c/drivers/i2c_hid_acpi/bind, which are only writable by root.

  Notes

  - The device name i2c-ELAN0522:01 is specific to this machine's touchpad hardware. Confirm it still applies after any hardware/firmware change with:
  ls /sys/bus/i2c/devices/ | grep -i elan
  - Currently not executable (chmod +x not set) — run via bash fix-touchpad.sh or chmod +x it first.
  - Consider wiring this to run automatically on resume-from-suspend via an Omarchy hook, if the touchpad issue recurs every time.
