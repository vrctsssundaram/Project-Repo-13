# Technical design

One outstanding request is processed through IDLE, SNOOP and RESPONSE states. Read requests add their requesting cache to the sharer mask. Writes that conflict with another sharer issue a targeted invalidation snoop and hold the response until acknowledgment; otherwise ownership changes immediately. The datapath models directory ownership, sharer masks and control-message sequencing.

## Integration profile

Clean-line sharer masks drive serialized directory reads and targeted invalidation acknowledgment on write ownership transitions.
