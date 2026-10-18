# Third-party archives

Place externally obtained dependency archives in this directory.

For AutoHotInterception (AHI), save the release ZIP here and commit the ZIP itself, for example:

`AutoHotInterception-v0.9.2.zip`

Before committing an archive:

- Confirm the release/version and source URL.
- Review the dependency's license and redistribution terms.
- Record the archive's SHA-256 checksum and acquisition date in the dependency record.
- Do not place extracted files here; extracted dependencies belong under `vendor/`, which is ignored by Git.

The archive is intentionally not included by this commit. The project maintainer will add it manually after obtaining and reviewing it.
