# SparRAW-firmware / 6.4 — открытая прошивка на основе 6.2

Прошивка 6.4.0.1 для чипа Sparrow (wil6210, 60 ГГц 802.11ad): вендорская 6.2.0.1000
([../6.2](../6.2/README.md)) плюс код на C/C++ и правки по 802.11-2020. Версия в образе —
`6.4.0.1-<вариант>-EWM`, автор — запись образа «Author: klukonin (Evil Wireless Man)».

## Сборка

    make fw VARIANT=apsta   # build/wil6210-6.4-apsta.fw
    make fw VARIANT=mesh    # build/wil6210-6.4-mesh.fw
    make fw VARIANT=fix     # build/wil6210-6.2-fix.fw — вендорская 6.2 + только исправления ошибок
    make release            # apsta и mesh → ../images/sparraw/, fix → ../images/openwrt/fw/
    make tree VARIANT=…     # только копия дерева 6.2 с патчами варианта (build/tree)

`make fw` копирует дерево `../6.2/src/{asm,data}` в `build/tree`, накладывает на копию
серию патчей варианта, компилирует блоки на C/C++ и собирает образ. Дерево 6.2 при этом
не меняется. Тулчейн, ключи, справочники и инструменты сборки — из `../6.2`
(`config.mk`, `ref/`, `tools/`).

## Варианты

Всё в одну прошивку не помещается, поэтому их две:

| вариант | режимы | состав |
|---|---|---|
| `apsta` | AP, STA, PBSS | всё, кроме перечисленного в `variants/apsta.txt` (безролевой линк, DMG IBSS) |
| `mesh` | DMG IBSS | всё, кроме перечисленного в `variants/mesh.txt` (AP/STA-функции: PS без графика, ESE, переассоциация, split MAC) |
| `fix` | как у вендора | вендорская 6.2.0.1000 и только исправления ошибок: ТОЛЬКО перечисленное в `variants/fix.txt` (строка `only`); версия `6.2.0.1000-fix-EWM` |

## Состав

| путь | что |
|---|---|
| `src/c/fw`, `src/c/uc` | блоки дерева 6.2, переписанные на C/C++ (заменяют блок того же имени) |
| `src/c/*/new` | новые функции (вызываются из вставок патчей и блоков на C) |
| `src/include` | заголовки: общие ячейки fw↔ucode, структуры, константы |
| `src/strings/fw.txt` | новые строки журнала прошивки (дописываются за вендорской таблицей) |
| `patches/` | патчи quilt к дереву 6.2 (`series` — порядок; `series-<вариант>` генерируется) |
| `variants/` | что исключено из варианта |

Как устроены замены блоков и патчи — [../docs/REWRITING.md](../docs/REWRITING.md);
соответствие стандарту — [../docs/STANDARD-MAPPING.md](../docs/STANDARD-MAPPING.md);
mesh — [../docs/MESH-IBSS.md](../docs/MESH-IBSS.md); ESE — [../docs/ESE.md](../docs/ESE.md).
