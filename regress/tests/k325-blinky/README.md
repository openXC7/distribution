# k325-blinky — the first kintex7 design through the toolchain

## What it probes

A 24-bit counter blinky on `xc7k325tffg676` (the QMTech Kintex-7 part),
with generated constraints. First kintex7 coverage in the suite that is
expected to produce a bitstream. The Genesys2 design is the differential
clock on an HP bank; `k325-hr-diff` is the high-range receiver.

## Expected result

Routes and produces a bitstream; `FDRE >= 24`.

## Reading a failure

- **Only this fails, artix7 green** — kintex7 packaging or the k325t
  chipdb. The part has one speed grade, `-1`.
