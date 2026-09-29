/* lmac_mbox__is_full @ 0x8db948, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__dband_beacon_ind
 * Зовёт сам: ring__is_full_8db1ec
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_mbox__is_full
lmac_mbox__is_full:
	.global L_8db948
L_8db948:
	push_s blink
L_8db94a:
	mov_s r0,0x804280
L_8db950:
	bl L_8df49c
L_8db954:
	sub.f r0,r0,0x0
L_8db958:
	mov.ne r0,0x1
L_8db95c:
	pop_s blink
L_8db95e:
	j_s [blink]
