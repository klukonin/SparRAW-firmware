/* sdp__set_level_and_init @ 0x8f8510, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_cfg__set_8004fc_and_levels
 * Зовёт сам: SDP__sdp_init__2, bits__set32_s0_w5
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__set_level_and_init
sdp__set_level_and_init:
	.global L_8f8510
L_8f8510:
	push_s blink
L_8f8512:
	mov_s r2,r0
L_8f8514:
	bmsk_s r1,r1,0x4
L_8f8516:
	mov_s r0,0x800c34
L_8f851c:
	add2_s r0,r0,r2
L_8f851e:
	bl L_8ed37c
L_8f8522:
	bl.d L_8f83c0
L_8f8526:
	mov_s r0,r2
L_8f8528:
	pop_s blink
L_8f852a:
	j_s [blink]
