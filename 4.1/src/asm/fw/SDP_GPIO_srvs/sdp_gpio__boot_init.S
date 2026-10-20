/* sdp_gpio__boot_init @ 0x8dfe54, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: SDP__sdp_init, SDP__sdp_init__2, __ld_r13_ret, gpio__reset_mux, hw_personality_detect
 */
	.section .text.sdp_gpio__boot_init,"ax",@progbits
	.global sdp_gpio__boot_init
sdp_gpio__boot_init:
	.global L_8dfe54
L_8dfe54:
	push_s blink
L_8dfe56:
	bl.d L_8d1598
L_8dfe5a:
	push_s r13
L_8dfe5c:
	mov r0,0x320
L_8dfe60:
	mov lp_count,r0
L_8dfe64:
	nop_s
L_8dfe66:
	lp L_8dfe6e
L_8dfe6a:
	nop_s
L_8dfe6c:
	nop_s
	.global L_8dfe6e
L_8dfe6e:
	bl.d L_8dffd8
L_8dfe72:
	mov_s r13,0x0
L_8dfe74:
	b_s L_8dfe88
	.global L_8dfe76
L_8dfe76:
	bl.d L_8c5244
L_8dfe7a:
	mov_s r0,r13
L_8dfe7c:
	cmp_s r0,0x0
L_8dfe7e:
	bl.ne.d L_8dfe90
L_8dfe82:
	mov.ne r0,r13
L_8dfe86:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dfe88
L_8dfe88:
	brlo r13,0x8,L_8dfe76
L_8dfe8c:
	b L_8c033c
