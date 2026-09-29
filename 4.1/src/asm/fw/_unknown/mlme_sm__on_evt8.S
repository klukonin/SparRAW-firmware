/* mlme_sm__on_evt8 @ 0x8ea9cc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __st_r14_to_r13
 */
	.section .text.mlme_sm__on_evt8,"ax",@progbits
	.global mlme_sm__on_evt8
mlme_sm__on_evt8:
L_8ea9cc:
	push_s blink
L_8ea9ce:
	bl.d L_8c02c4
L_8ea9d2:
	mov_s r1,0x2
