/* lmac_if__send_bcon_del_0b @ 0x8db304, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_bcon__del_bcon
 * Зовёт сам: field_set_0x00__8db2fc, lmac_if__post_cmd, mem_pool__alloc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_bcon_del_0b
lmac_if__send_bcon_del_0b:
	.global L_8db304
L_8db304:
	push_s blink
L_8db306:
	mov_s r0,0x804280
L_8db30c:
	bl L_8c33d0
L_8db310:
	mov.f r2,r0
L_8db314:
	beq_s L_8db32c
L_8db316:
	mov_s r0,0x0
L_8db318:
	st_s r0,[r2,0x50]
L_8db31a:
	bl.d L_8db2fc
L_8db31e:
	mov_s r0,r2
L_8db320:
	mov_s r0,r2
L_8db322:
	mov_s r1,0xb
L_8db324:
	mov_s r2,0x70
L_8db326:
	bl.d L_8e5204
L_8db32a:
	mov_s r3,0x0
	.global L_8db32c
L_8db32c:
	pop_s blink
L_8db32e:
	j_s [blink]
