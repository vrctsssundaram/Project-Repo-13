# Interface summary

| Field | Definition |
|---|---|
| Requesters | Two valid/ready clients; read/write bit and two-bit line index each |
| Snoop | Valid, one-hot target, two-bit line index and one-hot acknowledgment |
| Responses | One-hot valid/ready response, serialized per request |
| Directory | Four lines, each with two-bit sharer mask |
| Status | Completed grant and acknowledged invalidation counters |

## Assumptions and limits

Assumes clean shared lines. This does not implement MESI states, dirty-owner writeback, snoop-data forwarding, atomicity, cache line data, or a full coherency protocol.
