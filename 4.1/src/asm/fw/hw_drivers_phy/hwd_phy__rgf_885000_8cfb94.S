/* hwd_phy__rgf_885000_8cfb94 @ 0x8cfb94, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_a, calib_sar__enable_path
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_phy__rgf_885000_8cfb94,"ax",@progbits
	.global hwd_phy__rgf_885000_8cfb94
hwd_phy__rgf_885000_8cfb94:
	.global L_8cfb94
L_8cfb94:
	push_s blink
L_8cfb96:
	bl L_8c02c0
L_8cfb9a:
	mov_s r14,r4
L_8cfb9c:
	mov_s r15,0x885000
L_8cfba2:
	mov_s r13,r5
L_8cfba4:
	brne_s r0,0,L_8cfbac
L_8cfba6:
	ld_s r0,[r15]
L_8cfba8:
	bclr_s r0,r0,0x0
L_8cfbaa:
	b_s L_8cfbc0
	.global L_8cfbac
L_8cfbac:
	st_s r14,[r15,0x8]
L_8cfbae:
	st_s r13,[r15,0xc]
L_8cfbb0:
	asl_s r1,r1
L_8cfbb2:
	add_s r0,r1,0x1
L_8cfbb4:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_8cfbb6:
	add_s r0,r0,r2
L_8cfbb8:
	/* asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8cfbba:
	add_s r0,r0,r3
L_8cfbbc:
	add r0,r0,0x80
	.global L_8cfbc0
L_8cfbc0:
	st_s r0,[r15]
L_8cfbc2:
	b L_8c032c
L_8cfbc6:
	nop_s
