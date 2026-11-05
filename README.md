# Two-client cache coherence directory

Two-requester, four-line write-invalidate directory controller.

## Features

- Directory tracks two-bit sharer masks over four line indices
- Serialized reads add clean-data sharers
- Write ownership waits for other sharer invalidation acknowledgment
- Round-robin request selection and grant/invalidation counters

## Verification

Run `make test` for the self-checking regression or `make synth` for a synthesis check. See `docs/` for the design, interface, procedure and recorded results.

**Architecture:** Two-requester write-invalidate directory with four line indices and acknowledgment sequencing.

Project owner: Sundaram S S.
