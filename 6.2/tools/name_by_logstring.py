#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Имя блока по его собственной лог-строке.

Главный рычаг покрытия. Прошивка печатает
диагностику, и очень часто строка начинается именем самой функции:

    'bf_clear_all_sta() tail: %d, head: %d'   -> bf_clear_all_sta
    'bf_init_sm cmd_type:%u cid:%u'           -> bf_init_sm
    'l2_mgr::aborting_scan'                   -> l2_mgr__aborting_scan
    'HH brp_responder_transmission_flow l_rx' -> brp_responder_transmission_flow

Берётся только то, что доказано: идентификатор должен стоять В НАЧАЛЕ
строки (с точностью до известных префиксов вроде 'HH ') или прямо перед
'()'. Имя, вытащенное из середины фразы, — уже догадка, и такие не
принимаются. Если строк несколько и они дают разных кандидатов,
выигрывает кандидат, встретившийся в большинстве строк; при ничьей блок
пропускается.
"""
import argparse, collections, json, re

# приставки, которые вендор ставит перед именем функции в логе
PREFIX = re.compile(r'^(?:\*{2,}\s*|\[[A-Za-z_]{2,8}\]\s*|'
                    r'(?:HH|DBG|ERR|WRN|INF|TRACE|ASSERT)[: ]\s*)', re.I)
# идентификатор: snake_case или класс::метод
# Идентификатор. Заглавные буквы разрешены ТОЛЬКО когда в строке есть
# «::»: вендор пишет класс верхним регистром (STREAM_MGR::ready_for_modify,
# PS_ASSOC_MGR::…), и без этого послабления такие имена терялись — из 45
# безымянных блоков со строками две трети были именно такими. Без «::»
# заглавные не берём: «PROBE RESP no external…» — фраза, а не имя.
IDENT = re.compile(r'^([a-z_][a-z0-9_]{3,}(?:::[A-Za-z_][A-Za-z0-9_]*)*)')
IDENT_CLS = re.compile(r'^([A-Za-z_][A-Za-z0-9_]{2,}::[A-Za-z_][A-Za-z0-9_]*)')
# слова, которые сами по себе именем функции не бывают
STOP = {'error', 'failed', 'failure', 'warning', 'assert', 'invalid', 'illegal',
        'cannot', 'unknown', 'unsupported', 'timeout', 'state', 'start', 'stop',
        'reason', 'bad', 'got', 'set', 'get', 'the', 'and', 'for', 'not',
        'none', 'null', 'true', 'false', 'done', 'init', 'exit', 'enter'}


def candidate(s):
    s = PREFIX.sub('', s.strip())
    m = IDENT_CLS.match(s) if '::' in s[:64] else None
    if m is None:
        m = IDENT.match(s)
    if not m:
        return None
    nm = m.group(1)
    rest = s[len(nm):]
    if '::' in nm:
        return nm.replace('::', '__')
    if '::' not in nm:
        # одиночное слово без подчёркивания — не улика, а обычная фраза
        if '_' not in nm or len(nm) < 6:
            return None
        if nm.lower() in STOP or nm.startswith('g_'):
            return None   # g_* — глобал, а не функция
    # доказательство, что это заголовок записи лога, а не середина фразы:
    # либо скобки вызова, либо дальше идёт формат/разделитель
    if rest[:1] in ('(', ':', ';') or rest == '':
        return nm.replace('::', '__')
    if rest[0] in ' \t-,' and ('%' in rest or ':' in rest or '=' in rest):
        return nm.replace('::', '__')
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--anno', required=True)
    ap.add_argument('--blocks', required=True)
    ap.add_argument('--out', required=True, help='дописать в этот NAMES-EXTRA')
    ap.add_argument('--tag', default='uc')
    a = ap.parse_args()

    anno = json.load(open(a.anno))
    blocks = json.load(open(a.blocks))
    addr = {}
    for b in blocks['blocks']:
        addr[b['name']] = b['addr']

    taken = set()
    for l in open(a.out):
        q = l.split()
        if len(q) >= 2 and q[0].startswith('0x'):
            taken.add(q[1])

    out, skipped = [], collections.Counter()
    for nm, v in sorted(anno.items()):
        if nm not in addr or not nm.startswith(('sub_', 'blk_', 'FUN_')):
            continue
        ss = v.get('strings') or []
        if not ss:
            continue
        cands = collections.Counter(c for c in (candidate(s) for s in ss) if c)
        if not cands:
            skipped['строка не называет функцию'] += 1
            continue
        top, n = cands.most_common(1)[0]
        if len(cands) > 1 and n == cands.most_common(2)[1][1]:
            skipped['ничья кандидатов'] += 1
            continue
        if top in taken:
            # то же имя уже занято другим сегментом: функция с таким
            # именем есть и в прошивке, и в микрокоде (вендор собирает
            # общие исходники дважды). Линковщику нужны разные символы.
            if top + '_' + a.tag in taken:
                skipped['имя уже занято'] += 1
                continue
            top += '_' + a.tag
        taken.add(top)
        out.append((addr[nm], top, n, len(ss), ss[0][:60]))

    with open(a.out, 'a') as f:
        f.write('\n# --- имена по собственным лог-строкам (%s), '
                'name_by_logstring.py ---\n' % a.tag)
        for ad, nm, n, tot, s in sorted(out):
            f.write('0x%08x %s # строка %d/%d: %s\n' % (ad, nm, n, tot, s))
    print('%s: принято %d имён; пропущено: %s'
          % (a.out, len(out), dict(skipped)))


if __name__ == '__main__':
    main()
