# z030-hp-oddr — ODDR on a Zynq HP bank

## What it probes

An `ODDR` clocked via a `BUFG` from pad `G7` and driving pad `B5` (`IOB_X1Y110`,
HP bank 34, `LVCMOS18`) on `xc7z030fbg676`. Pad `B5` is paired with tile
`RIOI_X79Y109`, site `OLOGIC_Y0`. A single toggling flip-flop (`d <= ~d`)
drives `ODDR.D1`, giving the design a register-to-register path on `clk` so
`--report` carries an `fmax` (the same pattern as `oserdes-t1low`).

`primitives` locks that synthesis keeps the `ODDR` and `BUFG`. `artifacts`
holds that the full chain produces a non-empty bitstream. `fasm_contains`
checks the four `RIOI_X79Y109` features that show the `ODDR` was placed in
`OLOGIC_Y0` and routed onto pad `B5`:

- `RIOI_X79Y109.OLOGIC_Y0.ODDR_TDDR.IN_USE`
- `RIOI_X79Y109.OLOGIC_Y0.OQUSED`
- `RIOI_X79Y109.OLOGIC_Y0.OSERDES.DATA_RATE_OQ.DDR`
- `RIOI_X79Y109.RIOI_O0.RIOI_OLOGIC0_OQ`

The 45 s per-step timeout also guards against an unbounded IOLOGIC site walk.

## Why it exists

In `nextpnr-xilinx-meta` up to `8a3f5a09`, the four Zynq HP IOLOGIC site types
were absent from the `xc7z030`, `xc7z045` and `xc7z100` chipdb files
(`openXC7/nextpnr#227`). Any `ODDR` or `IDDR` driving a Zynq HP pad found no
`OLOGIC`/`ILOGIC` BEL next to its `IOB`. Before `openXC7/nextpnr#229`, the site
walk did not stop at the IO column and timed out (or exhausted memory); after
`#229`, it stops with a clear error when the chipdb lacks the site types.
`openXC7/nextpnr#238` advances `nextpnr-xilinx-meta` to `6a354586`, populating
those sites so HP-bank `ODDR`/`IDDR` designs place, route and assemble.

## Expected result

Routes and produces a bitstream with the four `RIOI_X79Y109` FASM lines above.
With nextpnr `7077312a` and yosys `0.71+77`, on linux and on windows: fmax
1043.8 MHz, 1 LUT, 2 FFs (the slice flip-flop and `OLOGICE2_OUTFF`), 0 BRAMs,
0 DSPs, bitstream 5980020 bytes.

## Reading a failure

- **`nextpnr-xilinx` times out (45 s) or errors with no OLOGIC site connected
  to the pad** — the `xc7z030` chipdb was built without the Zynq HP IOLOGIC
  site types (missing `nextpnr-xilinx-meta` `6a354586`), or the site walk
  regressed.
- **`fasm_contains` fails** — the `ODDR` did not land on
  `RIOI_X79Y109.OLOGIC_Y0` or did not emit the expected `OLOGIC_Y0`/`RIOI_O0`
  FASM lines.
- **`fasm2frames` fails** — a Zynq HP `RIOI` / `OLOGIC` feature name emitted by
  the FASM writer is missing from `prjxray-db`.
