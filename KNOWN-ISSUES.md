<!-- Known issues included in dated release notes by scripts/release-body.py.
     Edit this file before each stable release; leave it empty (or with only
     HTML comments) to omit the "Known issues" section. -->
- **Kintex-7 HP bank ODDR clock forwarding ([openXC7/nextpnr#222](https://github.com/openXC7/nextpnr/issues/222)):** an ODDR-forwarded clock on a Kintex-7 HP bank has been reported dead on hardware; the root cause is not yet established. This release includes [openXC7/nextpnr#228](https://github.com/openXC7/nextpnr/pull/228), which sets the clock-row `ACTIVE` bits that Vivado writes, pending hardware verification.
