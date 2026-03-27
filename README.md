# SPenCursorOverlay

**A Magisk module for Galaxy Tab devices running AOSP-based ROMs.**  
Restores a proper arrow pointer for OTG/Bluetooth mouse use, while keeping the OneUI S Pen hover dot as the tap indicator — without polluting every finger touch with a visible spot.

> Requires **"Show taps"** to be enabled in Developer Options.

---

## Background

When running a stock OneUI ROM, Galaxy Tab's S Pen is recognized as a dedicated stylus input. On AOSP-based custom ROMs like LineageOS and DerpFest, that layer is gone — the S Pen falls back to being detected as a plain touchscreen device, making it completely invisible on screen.

To fix this, LineageOS and DerpFest developers flag the S Pen as a **mouse input device** and replace the default `pointer_arrow` with a small, hollow OneUI-style dot. This works well if you only use the S Pen — but the moment you plug in an OTG or Bluetooth mouse, you're stuck navigating with a tiny, nearly invisible dot instead of a proper arrow cursor.

---

## What This Module Does

| Change | Effect |
|--------|--------|
| Reverts S Pen input flag | S Pen is recognized as touchscreen again (invisible unless "Show taps" is on) |
| Restores `pointer_arrow` | OTG/Bluetooth mouse shows a standard arrow cursor |
| Replaces `pointer_spot_hover` | S Pen hover/tap shows the OneUI-style dot (requires "Show taps") |
| Makes `pointer_spot_touch` invisible | Finger touches don't show a dot even with "Show taps" enabled |

**Trade-off:** When the S Pen tip physically touches the screen, the dot disappears — but since the tip is already on the screen, you always know where it is. The hover indicator still appears before contact.

---

## Requirements

- Android device: **Samsung Galaxy Tab** with S Pen support
- Custom ROM: **LineageOS**, **DerpFest**, or another AOSP-based ROM that applies the S Pen mouse flag patch
- Root: **Magisk** (v20.4+) or **KernelSU**
- Developer Options → **Show taps**: must be **enabled**

---

## Installation

1. Download the latest `.zip` from [Releases](../../releases).
2. Open **Magisk** → Modules → Install from storage.
3. Select the downloaded zip.
4. During installation, use your **Volume Keys** to select your theme:
   - **Volume Up (+)** = **Light** Theme (White arrow)
   - **Volume Down (-)** = **Dark** Theme (Black arrow)
   - **Note:** The installer will automatically default to the **Dark Theme** if no input is detected within 30 seconds.
5. Reboot.

---

## Options

### Pointer Theme (Chosen at Install Time)
The installer prompts you to pick a cursor style suited to your preference using the device hardware keys.

* **Light Theme:** Optimized for dark wallpapers or dark mode interfaces.
* **Dark Theme:** Optimized for light wallpapers or standard light mode interfaces.

To change your selection later, simply reinstall the module and choose the alternative option during the key-press window.

---

## Known Limitations

- **"Show taps" must be on.** The S Pen hover dot relies on the tap indicator system; there is currently no way to show the S Pen dot without enabling it globally.
- **S Pen contact hides the dot.** When the S Pen tip touches the screen, `pointer_spot_touch` is intentionally transparent, so no indicator appears at the contact point. This is by design.
- **Finger touches are invisible.** As a side effect of making `pointer_spot_touch` transparent, finger tap indicators are also hidden even with "Show taps" on. This is the intended behavior.
- **ROM-specific.** This module targets ROMs that already apply the S Pen-as-mouse patch (LineageOS, DerpFest). It may have no effect or behave unexpectedly on stock OneUI.

---

## Compatibility

| ROM | Status |
|-----|--------|
| LineageOS 23 (Android 16) | ✅ Tested |
| DerpFest | ✅ Tested |
| Other AOSP ROMs with S Pen patch | ⚠️ Likely works, untested |
| Stock OneUI | ❌ Not supported |

Tested on: *Samsung Galaxy Tab S6 Lite 2022*

---

## Credits

- **LineageOS & DerpFest contributors** — for the original S Pen mouse flag patch and OneUI dot design that this module builds on
- Inspired by the pointer customization work in AOSP `frameworks/base`

---

## License

[MIT](LICENSE)