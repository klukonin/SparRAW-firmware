/* pcie__apply_mode_fw_8825c0__8d10c8 @ 0x8d10c8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_pcie__is_ep_under_serdes, mac__set_880af8_afc_b25_b5, mac__set_880af8_afc_b30_b6, mac__set_880afc_bits9_11, mac__set_bits_880af4_f8_fc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__apply_mode_fw_8825c0__8d10c8
pcie__apply_mode_fw_8825c0__8d10c8:
	.global L_8d10c8
L_8d10c8:
	push_s blink
L_8d10ca:
	bl L_8c01e4
L_8d10ce:
	bl.d L_8d1470
L_8d10d2:
	mov_s r13,r0
L_8d10d4:
	mov_s r1,0x882580
L_8d10da:
	ld_s r14,[r1,0x40]
L_8d10dc:
	brne_s r0,0,L_8d1110
L_8d10de:
	mov_s r0,0x0
L_8d10e0:
	btst_s r14,0x2
L_8d10e2:
	btst.eq r14,0x3
L_8d10e6:
	mov.ne r0,0x1
L_8d10ea:
	extb_s r0,r0
L_8d10ec:
	bl.d L_8d1ac0
L_8d10f0:
	and_s r0,r0,r13
L_8d10f2:
	bmsk r0,r14,0x0
L_8d10f6:
	bl.d L_8d19a4
L_8d10fa:
	and_s r0,r0,r13
L_8d10fc:
	lsr_s r14,r14
L_8d10fe:
	bmsk_s r14,r14,0x0
L_8d1100:
	bl.d L_8d1a34
L_8d1104:
	and r0,r14,r13
L_8d1108:
	bl.d L_8d1250
L_8d110c:
	and r0,r14,r13
	.global L_8d1110
L_8d1110:
	b L_8c0254
