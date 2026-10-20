/* hwd_abif__caf_phy_control_mode @ 0x8ce648, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__caf_phy_control_mode
hwd_abif__caf_phy_control_mode:
	.global L_8ce648
L_8ce648:
	mov_s r1,0x88af80
L_8ce64e:
	cmp_s r0,0x1
L_8ce650:
	ld_s r0,[r1,0x68]
L_8ce652:
	bset.eq r0,r0,0x0
L_8ce656:
	bclr.ne r0,r0,0x0
L_8ce65a:
	st_s r0,[r1,0x68]
L_8ce65c:
	j_s [blink]
L_8ce65e:
	nop_s
