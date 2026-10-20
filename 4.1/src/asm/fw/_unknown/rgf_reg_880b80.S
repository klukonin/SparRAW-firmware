/* rgf_reg_880b80 @ 0x8d1448, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2
 * Зовёт сам: SDP__hwd_sdp_is_int_ctrl_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.rgf_reg_880b80,"ax",@progbits
	.global rgf_reg_880b80
rgf_reg_880b80:
	.global L_8d1448
L_8d1448:
	push_s blink
L_8d144a:
	bl L_8c02c4
L_8d144e:
	mov_s r13,r0
L_8d1450:
	mov_s r14,r1
L_8d1452:
	bl.d L_8d1510
L_8d1456:
	mov_s r0,r1
L_8d1458:
	sub_s r14,r14,0xa
L_8d145a:
	extb_s r14,r14
L_8d145c:
	mov_s r1,0x880b80
L_8d1462:
	ld_s r2,[r1,0x34]
L_8d1464:
	mov r0,-0x1
L_8d1468:
	asl_s r0,r0,r14
L_8d146a:
	bic_s r2,r2,r0
L_8d146c:
	asl_s r13,r13,r14
L_8d146e:
	or_s r13,r13,r2
L_8d1470:
	st_s r13,[r1,0x34]
L_8d1472:
	b L_8c0334
L_8d1476:
	nop_s
