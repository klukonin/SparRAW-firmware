/* ba_td_subsm__on_delba_tx_complete @ 0x8de73c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: tail_basic_sm__defer_event
 */
	.section .text.ba_td_subsm__on_delba_tx_complete,"ax",@progbits
	.global ba_td_subsm__on_delba_tx_complete
ba_td_subsm__on_delba_tx_complete:
L_8de73c:
	mov_s r4,r3
L_8de73e:
	ldw_s r3,[r0,0x2e]
L_8de740:
	mov_s r1,0x9
L_8de742:
	ld_s r0,[r0,0x34]
L_8de744:
	b.d L_8e2118
