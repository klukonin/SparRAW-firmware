/* ucode_cmd_0x04_handler @ 0x935410, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, txrx_api_step_c
 */
	.section .text.ucode_cmd_0x04_handler,"ax",@progbits
	.global ucode_cmd_0x04_handler
ucode_cmd_0x04_handler:
	.global L_935410
L_935410:
	push_s blink
L_935412:
	bl L_920214
L_935416:
	mov_s r14,r0
L_935418:
	mov_s r13,0x0
L_93541a:
	b_s L_93542e
	.global L_93541c
L_93541c:
	asl_s r1,r13,0x2
L_93541e:
	add1_s r1,r1,r1
L_935420:
	ld_s r0,[r14,r1]
L_935422:
	cmp_s r0,0x4
L_935424:
	bl.cs.d L_9319e8
L_935428:
	add.cs r1,r1,r14
L_93542c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_93542e
L_93542e:
	brlo r13,0x4,L_93541c
L_935432:
	b L_920284
L_935436:
	nop_s
