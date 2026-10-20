/* pcie__program_seq_fw_8825c0__8d1114 @ 0x8d1114, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_pcie__is_ep_under_serdes, mac__set_880af8_afc_b25_b5, mac__set_880af8_afc_b30_b6, mac__set_880afc_bits9_11, mac__set_bits_880af4_f8_fc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__program_seq_fw_8825c0__8d1114
pcie__program_seq_fw_8825c0__8d1114:
	.global L_8d1114
L_8d1114:
	push_s blink
L_8d1116:
	bl L_8c01e4
L_8d111a:
	bl.d L_8d1470
L_8d111e:
	mov_s r14,r0
L_8d1120:
	mov_s r1,0x882580
L_8d1126:
	ld_s r13,[r1,0x40]
L_8d1128:
	breq_s r0,0,L_8d113e
L_8d112a:
	bl.d L_8d19a4
L_8d112e:
	mov_s r0,r14
L_8d1130:
	bl.d L_8d1a34
L_8d1134:
	mov_s r0,r14
L_8d1136:
	bl.d L_8d1ac0
L_8d113a:
	mov_s r0,r14
L_8d113c:
	b_s L_8d1176
	.global L_8d113e
L_8d113e:
	mov_s r0,0x0
L_8d1140:
	btst_s r13,0x2
L_8d1142:
	btst.eq r13,0x3
L_8d1146:
	mov.eq r0,0x1
L_8d114a:
	extb_s r0,r0
L_8d114c:
	bl.d L_8d1ac0
L_8d1150:
	and_s r0,r0,r14
L_8d1152:
	bxor r0,r13,0x0
L_8d1156:
	bmsk_s r0,r0,0x0
L_8d1158:
	bl.d L_8d19a4
L_8d115c:
	and_s r0,r0,r14
L_8d115e:
	lsr_s r13,r13
L_8d1160:
	bxor r13,r13,0x0
L_8d1164:
	bmsk_s r13,r13,0x0
L_8d1166:
	bl.d L_8d1a34
L_8d116a:
	and r0,r13,r14
L_8d116e:
	bl.d L_8d1250
L_8d1172:
	and r0,r13,r14
	.global L_8d1176
L_8d1176:
	b L_8c0254
L_8d117a:
	nop_s
