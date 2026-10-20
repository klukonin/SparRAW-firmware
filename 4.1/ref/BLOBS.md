# Вендорские образы

Образы лежат в `../blobs/` (приватный SparRAW-firmware, см. `../blobs/README.md`).
Здесь — контрольные суммы исходного образа.

| что | размер | sha256 |
|---|---|---|
| `wil6210.fw` FW 4.1.0.1000 | 476552 | `ffa9df23ccd790e2286c85f2d8319669b35e40fbc95a6e2e87851d8786ec93d3` |

Происхождение: RouterOS 6.42.1, wireless-6.42.1-arm.npk -> lib/firmware/wil6210.fw

Как получить заново: распаковать соответствующий npk
(`SparRAW-tools/re/npk_unpack.py`, при необходимости `npk_decrypt.py --auto`).
