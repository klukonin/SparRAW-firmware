/* lmac_mbox__is_full @ 0x8d85cc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__dband_beacon_ind
 * Зовёт сам: ring__is_full_8db1ec
 */
	.section .text.lmac_mbox__is_full,"ax",@progbits
	.global lmac_mbox__is_full
lmac_mbox__is_full:
	.global L_8d85cc
L_8d85cc:
	push_s blink
L_8d85ce:
	mov_s r0,0x803e3c
L_8d85d4:
	bl L_8db1ec
L_8d85d8:
	sub.f r0,r0,0x0
L_8d85dc:
	mov.ne r0,0x1
L_8d85e0:
	pop_s blink
L_8d85e2:
	j_s [blink]
