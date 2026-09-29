# SparRAW-firmware

Прошивки чипа Qualcomm/Wilocity **Sparrow** (wil6210, 60 ГГц 802.11ad) в виде
исходников, которые собираются тулчейном ARC обратно в образ.

| каталог | версия | состояние |
|---|---|---|
| `4.1/` | FW 4.1.0.1000 | все блоки fw и ucode названы; часть блоков переписана на C/C++; образ собирается из дерева |
| `6.2/` | FW 6.2.0.1000 | вендорская прошивка: все блоки fw и ucode названы; `make fw` даёт вендорский образ **побайтово** |
| `6.4/` | FW 6.4.0.1 | открытая прошивка на основе 6.2: блоки на C/C++, патчи quilt к дереву 6.2, два варианта — `apsta` (AP, STA, PBSS) и `mesh` (DMG IBSS) |
| `docs/` | — | документация: общие для версий темы; версионные — в `4.1/docs`, `6.2/docs` (оглавление — [docs/README.md](docs/README.md)) |
| `images/` | — | готовые образы и board-файлы: вендорские оригиналы, наши сборки, годные для OpenWrt (см. [images/README.md](images/README.md)) |
| `blobs/` | — | входы разбора и сборки: сегменты образов, листинги, таблицы лог-строк (см. `blobs/README.md`) |

## Быстрый старт

```sh
tools/get-toolchain.sh          # ARC GNU 2021.03 в ./toolchain (или ссылка на готовый)
cd 6.2 && make fw               # вендорская 6.2.0.1000 → build/wil6210-selfbuilt.fw, сверка с images/openwrt/fw
cd ../6.4 && make fw VARIANT=apsta   # → build/wil6210-6.4-apsta.fw
make fw VARIANT=mesh                 # → build/wil6210-6.4-mesh.fw
make release                         # оба варианта → ../images/sparraw/
```

Проверки после любой правки дерева 6.2: `make tree && make rebuild && make fw`,
`python3 tools/audit_names.py`, `python3 tools/mechmap.py fw|uc`, `make regs`.

## Соседние репозитории

Раскладка — рядом друг с другом в одном каталоге:

* `SparRAW-driver` — драйвер wil6210 для OpenWrt с патчами проекта;
* `SparRAW-tools` — хостовые и стендовые скрипты (на них ссылаются `tools/*.sh`);
* `SparRAW-docs` — описание чипа.

## Лицензия

Код проекта — GNU AGPL v3 или новее ([LICENSE](LICENSE)) с дополнительным
разрешением на сборку с вендорской прошивкой wil6210; документация — CC BY 4.0.
Вендорская прошивка, её дизассемблер и данные (`*/src/asm`, `*/src/data`,
`blobs/`, `images/vendor`, `images/openwrt` и др.) лицензией проекта не
покрываются. Подробно — [COPYING.md](COPYING.md).
