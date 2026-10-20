# Вендорские образы

Образы лежат в `../blobs/` (приватный SparRAW-firmware, см. `../blobs/README.md`).
Здесь — контрольные суммы исходного образа.

| что | размер | sha256 |
|---|---|---|
| `wil6210.fw` FW 6.2.0.1000 | 561252 | `fd7dbc4dd9260b5662ee15b1dec2e03cda08358e98286673e613280d33979516` |

Происхождение: MikroTik RouterOS wireless-*.npk (расшифрованный), а также UBNT airFiber 6.2.0.225

Как получить заново: распаковать соответствующий npk
(`SparRAW-tools/re/npk_unpack.py`, при необходимости `npk_decrypt.py --auto`).
