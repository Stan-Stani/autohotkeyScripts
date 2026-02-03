# autohotkeyScripts

https://github.com/Stan-Stani/autohotkeyScripts

## Scripts

### ipToFromLocalhost.ah2

Toggles a URL in your clipboard between your LAN IP and localhost.

- Hotkey: Ctrl+Alt+I
- Examples:
  - https://192.168.11.49:3004/foo -> http://localhost:3004/foo
  - http://localhost:3004/foo -> https://192.168.11.49:3004/foo
- Notes:
  - Preserves port, path, query, and fragment.
  - Update `LAN_IP` inside the script if your LAN IP changes.
