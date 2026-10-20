/* hwd_mac__trigger_sxd_tx_mode @ 0x8d1008, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__set_loopback
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__trigger_sxd_tx_mode
hwd_mac__trigger_sxd_tx_mode:
	.global L_8d1008
L_8d1008:
	push_s blink
L_8d100a:
	push_s r13
L_8d100c:
	brge.d r0,0x20,L_8d1038
L_8d1010:
	mov_s r13,r0
	.global L_8d1012
L_8d1012:
	mov_s r1,0x886d80
L_8d1018:
	st 0x3d000100,[r1, 0x48]
L_8d1020:
	asl_s r0,r13,0x4
L_8d1022:
	or r0,r0,0x3e000000
L_8d102a:
	st_s r0,[r1,0x48]
L_8d102c:
	st 0x3d001000,[r1, 0x48]
L_8d1034:
	b L_8c025c
	.global L_8d1038
L_8d1038:
	mov_s r0,blink
L_8d103a:
	mov_s r1,0xd9
L_8d103c:
	bl.d L_8c9b28
L_8d1040:
	bset_s r1,r1,0xc
L_8d1042:
	b_s L_8d1012
