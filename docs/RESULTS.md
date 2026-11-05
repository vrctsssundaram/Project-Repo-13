# Verification record

Date: 05 November 2026
Source revision tested: `693d4defacf91ad55647ef116f948bf07ca88dbb`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-13/actions/runs/41900975749

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | two shared reads, two cross-client write invalidations, response sequencing after snoop acknowledgment, grant and invalidation counts |
| Generic Yosys synthesis | **PASS**; 356 technology-independent cells |

**Evidence:** Tool-reported Icarus Verilog regression and Yosys synthesis results for the source revision cited above.
