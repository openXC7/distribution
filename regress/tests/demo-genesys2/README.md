# demo-genesys2 — kintex7 HP differential clock, positive

**Status (2026-11-24): the tripwire has tripped.** The design routes and
`fasm2frames` writes the bitstream. The FASM carries `IBUFDS_BANK_GLUE`,
`LVDS_SSTL12_SSTL135_SSTL15.IN_DIFF` and `SSTL12_SSTL135_SSTL15.IN_DIFF`,
the features that used to be rejected.

## The gap, closed

Until 2026-08-05 this was an expected failure: `fasm2frames` rejected the
RIOB18 differential-input features, the kintex7 HP-bank bits had not been
fuzzed, and the family left the manifest. With the k325 chipdb in the
package the same design completes. The expected-fail guard was flipped.

## Original probe description

## What it probes

The upstream openXC7/demo-projects blinky for the Digilent Genesys2,
untouched, on `xc7k325tffg900` (the only speed grade the db carries is
-2 — the harness resolves it from the part dir). Beyond being the first
kintex7 coverage, this design enters through an **LVDS differential
clock** (`clk_p`/`clk_n` → IBUFDS), a clock-input path no other test in
the catalogue exercises.

## Why it exists

Batch-2 family expansion (ZedBoard + kintex7 ffg900). Everything
kintex7-specific runs for the first time here: its chipdb (462 MB bin,
the largest we ship), its prjxray-db, its tile mix. KC705 shares the
part; the ZedBoard footprint is covered by the constant sweep.

## Expected result

Routes and produces a bitstream; a counter (`FDRE >= 20`); IBUFDS
inferred for the clock pair.

## Reading a failure

- **Only this fails, artix7/zynq7 green** — kintex7-specific packaging
  or the IBUFDS path; check `constant/xc7k325tffg900` to scope which.
- **SKIP** — run `scripts/fetch-demos.sh`.
