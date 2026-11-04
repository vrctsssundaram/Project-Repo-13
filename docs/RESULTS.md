# Verification record

Date: 05 November 2026
Source revision tested: `693d4defacf91ad55647ef116f948bf07ca88dbb`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-13/actions/runs/41900975749

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | two shared reads, two cross-client write invalidations, no response before snoop acknowledgment, grant and invalidation counts |
| Generic Yosys synthesis | **PASS**; 356 technology-independent cells |
| FPGA/ASIC technology-specific utilization | Not measured |
| Static timing, maximum clock, power | Not measured |
| Physical hardware throughput | Not measured |

The synthesis count is taken from the top-level `stat` section of the hosted generic Yosys run, not a device-mapped area estimate. The directed testbench is bounded and does not constitute exhaustive or formal verification. No artificial waveform, timing, area, or power result is presented as a measurement.
