/* ba_sm__on_addbareq_tx_complete @ 0x8c2930, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.ba_sm__on_addbareq_tx_complete,"ax",@progbits
	.global ba_sm__on_addbareq_tx_complete
ba_sm__on_addbareq_tx_complete:
L_8c2930:
	add_s r0,r0,0x2c
L_8c2932:
	cmp_s r1,0x1
L_8c2934:
	mov_s r1,0x3
L_8c2936:
	mov.ne r1,0x4
L_8c293a:
	mov_s r2,0x0
L_8c293c:
	mov_s r3,r2
L_8c293e:
	b.d L_8d6a1c
L_8c2942:
	mov_s r4,r2
