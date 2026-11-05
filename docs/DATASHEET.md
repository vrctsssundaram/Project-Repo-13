# Interface summary

| Field | Definition |
|---|---|
| Requesters | Two valid/ready clients; read/write bit and two-bit line index each |
| Snoop | Valid, one-hot target, two-bit line index and one-hot acknowledgment |
| Responses | One-hot valid/ready response, serialized per request |
| Directory | Four lines, each with two-bit sharer mask |
| Status | Completed grant and acknowledged invalidation counters |

## Integration profile

Clean-line sharer masks drive serialized directory reads and targeted invalidation acknowledgment on write ownership transitions.
