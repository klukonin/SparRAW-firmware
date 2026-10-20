# Licensing

Copyright (C) 2026 Kirill Lukonin

## Code: GNU AGPL, version 3 or later

The original code of this repository is free software: you can redistribute
it and/or modify it under the terms of the GNU Affero General Public License
as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version. See [LICENSE](LICENSE).

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License
for more details.

This covers, in particular:

* code in C/C++ and assembly written for this project: `*/src/c`,
  `*/src/include`, `*/src/ext`, `*/src/pending`, `6.4/src/strings`;
* build files and tools: `*/Makefile`, `*/config.mk`, `*/ld`, `*/tools`,
  `6.4/variants`;
* the changes made by the patches in `6.4/patches` (see below);
* annotations and data produced by this project in `*/ref`, except for the
  files listed under "Not covered".

Source files carry an `SPDX-License-Identifier: AGPL-3.0-or-later` line.

### Additional permission under GNU AGPL version 3 section 7

A firmware image for the wil6210 (Sparrow) chip is built by combining the
code of this project with the chip vendor's firmware. Therefore:

If you modify this Program, or any covered work, by combining it with the
firmware of the Qualcomm/Wilocity wil6210 (Sparrow) chip, or with code or
data derived from that firmware (including its disassembly), the licensors
of this Program grant you additional permission to convey the resulting
work. Corresponding Source for a non-source form of such a combination shall
include the source code for the parts of this Program used, but need not
include the vendor firmware or the material derived from it.

This permission applies to every file in this repository licensed under the
GNU AGPL.

## Documentation: CC BY 4.0

Documentation (`docs/`, `*/docs`, `README.md` files) is licensed under the
Creative Commons Attribution 4.0 International License. See
[LICENSES/CC-BY-4.0.txt](LICENSES/CC-BY-4.0.txt).

## Not covered

The following is the vendor's material or is derived from it. It is not
licensed by this project and remains the property of its respective owners:

* `*/src/asm`, `*/src/data` — disassembly and data of the vendor firmware;
* `*/ref/strings-*.bin`, `*/ref/RAW-*.txt`, `*/ref/ASM-REFSET.txt`,
  `*/ref/traces` — string tables, instruction bytes, instruction listings and
  logs of the vendor firmware;
* `blobs/` — vendor firmware images and material extracted from them;
* `images/vendor`, `images/openwrt` — vendor firmware and board files;
* the context lines of the patches in `6.4/patches`, which are vendor
  disassembly (only the changes the patches make are covered);
* in the firmware images in `images/sparraw` and
  `images/openwrt/fw/*-fix.fw`, the parts that come from the vendor firmware
  (the parts built from this project's code are covered, under the
  additional permission above).
