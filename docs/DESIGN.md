# Technical design

One outstanding request is processed through IDLE, SNOOP and RESPONSE states. Read requests add their requesting cache to the sharer mask. Writes that conflict with another sharer issue a targeted invalidation snoop and hold the response until acknowledgment; otherwise ownership changes immediately. Only directory state and control messages are modeled, not cache-line storage or data transfer.

## Scope boundary

Assumes clean shared lines. This does not implement MESI states, dirty-owner writeback, snoop-data forwarding, atomicity, cache line data, or a full coherency protocol.
