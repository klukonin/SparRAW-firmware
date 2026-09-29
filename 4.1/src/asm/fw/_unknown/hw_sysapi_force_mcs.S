/* hw_sysapi_force_mcs @ 0x8cb754, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_force_mcs(): sta_id = %d, force_en = %d, mcs = %d
 *   sta_id [%d] out of range
 *   mcs [%d] is not supported
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit3, lmac_if_send_cmd_0x30
 */
	.section .text.hw_sysapi_force_mcs,"ax",@progbits
	.global hw_sysapi_force_mcs
hw_sysapi_force_mcs:
	.global L_8cb754
L_8cb754:
	push_s blink
L_8cb756:
	bl L_8c02bc
L_8cb75a:
	mov_s r13,r0
L_8cb75c:
	mov_s r16,r1
L_8cb75e:
	mov_s r15,r2
L_8cb760:
	mov_s r2,0x1016714
L_8cb766:
	mov_s r0,0x5
L_8cb768:
	mov_s r1,0x2
L_8cb76a:
	mov_s r3,r13
L_8cb76c:
	mov r4,r16
L_8cb770:
	bl.d L_8ee034
L_8cb774:
	mov_s r5,r15
L_8cb776:
	brlt r13,0x8,L_8cb78e
L_8cb77a:
	mov_s r2,0x1016750
L_8cb780:
	mov_s r0,0x5
L_8cb782:
	mov_s r1,0x0
L_8cb784:
	bl.d L_8edfcc
L_8cb788:
	mov_s r3,r13
L_8cb78a:
	mov_s r0,0x0
L_8cb78c:
	b_s L_8cb7bc
	.global L_8cb78e
L_8cb78e:
	mov_s r0,0x1dde
L_8cb794:
	mov_s r14,0x1
L_8cb796:
	bbit1 r0,r15,L_8cb7b0
L_8cb79a:
	mov_s r2,0x101676c
L_8cb7a0:
	mov_s r0,0x5
L_8cb7a2:
	mov_s r13,0x0
L_8cb7a4:
	mov_s r1,r13
L_8cb7a6:
	bl.d L_8edfcc
L_8cb7aa:
	mov_s r3,r15
L_8cb7ac:
	mov_s r0,r13
L_8cb7ae:
	b_s L_8cb7bc
	.global L_8cb7b0
L_8cb7b0:
	mov_s r0,r13
L_8cb7b2:
	mov_s r1,r16
L_8cb7b4:
	bl.d L_8d852c
L_8cb7b8:
	mov_s r2,r15
L_8cb7ba:
	mov_s r0,r14
	.global L_8cb7bc
L_8cb7bc:
	b L_8c0324
