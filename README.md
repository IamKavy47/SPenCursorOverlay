# SPenCursorOverlay

**A Magisk module for Galaxy Tab devices running AOSP-based ROMs.**  
Restores a proper arrow pointer for OTG/Bluetooth mouse use, while keeping the OneUI S Pen hover dot as the tap indicator. 

> Requires **"Show taps"** to be enabled in Developer Options.


## What This Module Does
- Flags the S Pen device type as a touchscreen input
- Turns the `pointer_arrow` image into a mouse arrow again
- Replaces `pointer_spot_hover` with a OneUI-style S Pen dot
- Makes `pointer_spot_touch` transparent, so nothing appears when your finger touches the screen


## Installation

1. Download the latest `.zip` from [Releases](../../releases).
2. Open **Magisk** → Modules → Install from storage.
3. Select the downloaded zip.
4. Follow the instructions and select the desired cursor color theme.
5. Reboot.


## Known Limitations

- **"Show taps" must be on** — the S Pen hover dot relies on the tap indicator system and cannot be shown without enabling it globally.
- **S Pen contact hides the dot** — `pointer_spot_touch` is intentionally transparent, so no indicator appears when the tip touches the screen.
- **Finger touches are also invisible** — a side effect of the transparent `pointer_spot_touch`; tap indicators are hidden even with "Show taps" on.
- **Changing the cursor theme requires a reinstall** — resource overlays cannot be reloaded while the system is running.


## Compatibility

| ROM | Status |
|-----|--------|
| LineageOS 23 | ✅ Tested |
| DerpFest 16 | ✅ Tested |
| Other AOSP ROMs with S Pen patch | ⚠️ Likely works, untested |
| Stock OneUI | ❌ Not supported |

Tested on: **gta4xlve (SM-P619)**


## Credits

- **LineageOS & DerpFest community**