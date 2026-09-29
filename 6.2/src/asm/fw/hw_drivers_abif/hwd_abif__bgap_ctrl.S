/* hwd_abif__bgap_ctrl @ 0x8ce5c0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_modes_cmd_0x304_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__bgap_ctrl
hwd_abif__bgap_ctrl:
	.global L_8ce5c0
L_8ce5c0:
	mov_s r1,0x889300
L_8ce5c6:
	cmp_s r0,0x1
L_8ce5c8:
	ld_s r0,[r1,0x64]
L_8ce5ca:
	bset.eq r0,r0,0x0
L_8ce5ce:
	bclr.ne r0,r0,0x0
L_8ce5d2:
	st_s r0,[r1,0x64]
L_8ce5d4:
	j_s [blink]
L_8ce5d6:
	nop_s
