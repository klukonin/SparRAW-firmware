/* ut_hw_drivers_cmd_0x50b @ 0x8d0704, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: hwd_rfc_read_rgf
 */
	.section .text.ut_hw_drivers_cmd_0x50b,"ax",@progbits
	.global ut_hw_drivers_cmd_0x50b
ut_hw_drivers_cmd_0x50b:
	.global L_8d0704
L_8d0704:
	mov_s r1,0x889100
L_8d070a:
	ld_s r0,[r1,0x18]
L_8d070c:
	bclr_s r0,r0,0x4
L_8d070e:
	st_s r0,[r1,0x18]
L_8d0710:
	mov_s r0,0x3a980
L_8d0716:
	mov lp_count,r0
L_8d071a:
	nop_s
L_8d071c:
	lp L_8d0724
L_8d0720:
	nop_s
L_8d0722:
	nop_s
	.global L_8d0724
L_8d0724:
	mov_s r1,0x889100
L_8d072a:
	ld_s r0,[r1,0x18]
L_8d072c:
	bset_s r0,r0,0x4
L_8d072e:
	st_s r0,[r1,0x18]
L_8d0730:
	mov_s r0,0x0
L_8d0732:
	b.d L_8d04fc
L_8d0736:
	mov r1,0x428
L_8d073a:
	nop_s
