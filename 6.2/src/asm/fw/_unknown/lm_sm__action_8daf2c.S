/* lm_sm__action_8daf2c @ 0x8daf2c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: conn__get_cid, lmac_if_trigger_bf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8daf2c
lm_sm__action_8daf2c:
	.global L_8daf2c
L_8daf2c:
	push_s blink
L_8daf2e:
	bl.d L_8cbed0
L_8daf32:
	ld_s r0,[r0,0x8]
L_8daf34:
	extb_s r0,r0
L_8daf36:
	bl.d L_8dc228
L_8daf3a:
	mov_s r1,0x0
L_8daf3c:
	pop_s blink
L_8daf3e:
	j_s [blink]
