/* sdp__init_int_ctrl @ 0x8d1430, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2
 * Зовёт сам: SDP__hwd_sdp_is_int_ctrl_sdp, __ld_r13_ret, sdp__program_880b00
 */
	.section .text.sdp__init_int_ctrl,"ax",@progbits
	.global sdp__init_int_ctrl
sdp__init_int_ctrl:
	.global L_8d1430
L_8d1430:
	push_s blink
L_8d1432:
	push_s r13
L_8d1434:
	bl.d L_8d1510
L_8d1438:
	mov_s r13,r0
L_8d143a:
	bl.d L_8d16b8
L_8d143e:
	add r0,r13,0xb
L_8d1442:
	b L_8c033c
L_8d1446:
	nop_s
