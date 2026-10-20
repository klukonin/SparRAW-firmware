/* hwd_phy__reconfig_with_delay @ 0x8d45b4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r13_ret, hwd_phy__config_by_mode, hwd_phy_dbg_clk_enable
 */
	.section .text.hwd_phy__reconfig_with_delay,"ax",@progbits
	.global hwd_phy__reconfig_with_delay
hwd_phy__reconfig_with_delay:
	.global L_8d45b4
L_8d45b4:
	push_s blink
L_8d45b6:
	push_s r13
L_8d45b8:
	mov.f r13,r0
L_8d45bc:
	beq_s L_8d45fc
L_8d45be:
	bl.d L_8ceed4
L_8d45c2:
	mov_s r0,0x1
L_8d45c4:
	mov_s r0,0x50
L_8d45c6:
	mov lp_count,r0
L_8d45ca:
	nop_s
L_8d45cc:
	lp L_8d45d4
L_8d45d0:
	nop_s
L_8d45d2:
	nop_s
	.global L_8d45d4
L_8d45d4:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8d45d6:
	add2_s r13,r13,r13
L_8d45d8:
	mov_s r0,0x1
L_8d45da:
	mov_s r1,0x0
L_8d45dc:
	mov_s r2,r13
L_8d45de:
	mov_s r3,r1
L_8d45e0:
	bl.d L_8cf2a4
L_8d45e4:
	mov r4,0x1f
L_8d45e8:
	mov lp_count,r13
L_8d45ec:
	nop_s
L_8d45ee:
	lp L_8d45f6
L_8d45f2:
	nop_s
L_8d45f4:
	nop_s
	.global L_8d45f6
L_8d45f6:
	bl.d L_8ceed4
L_8d45fa:
	mov_s r0,0x0
	.global L_8d45fc
L_8d45fc:
	b L_8c033c
