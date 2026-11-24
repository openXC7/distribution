# k325-hr-diff — differential input on a high-range bank

## What it probes

An `IBUFDS` with `LVDS_25` on bank 14 of `xc7k325tffg676`. The pair is
D23/D24 (`IO_L11P/N_T1_SRCC_14`, tile `LIOB33_X0Y127`), which is a
high-range bank. The clock is F22, a single-ended `LVCMOS33` pad on the
same bank, and the LED is J26.

The August database gap that kept kintex7 out of the manifest was the
high-performance differential input (`RIOB18`). Genesys2 now completes.
This one asks the high-range question on its own. The constraints file
is this test's: the harness default only constrains the clock and the LED,
and the differential ports then stay unconstrained.

## Expected result

Routes and produces a bitstream, with one `IBUFDS`. The FASM of the
pair carries `LVDS_25_SSTL135_SSTL15.IN_DIFF` on the high-range tile.
