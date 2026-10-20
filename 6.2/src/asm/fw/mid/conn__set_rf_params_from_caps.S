/* conn__set_rf_params_from_caps @ 0x8e6e1c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_req, discovery_handle_probe_resp
 * Зовёт сам: l2_mgr__set_rf_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__set_rf_params_from_caps
conn__set_rf_params_from_caps:
	.global L_8e6e1c
L_8e6e1c:
	ld.as r3,[r0,0x62]
L_8e6e20:
	mov_s r1,0x1
L_8e6e22:
	mov_s r2,0x40
L_8e6e24:
	breq_s r3,0,L_8e6e38
L_8e6e26:
	ldw.as r2,[r0,0xcb]
L_8e6e2a:
	lsr r1,r2,0x4
L_8e6e2e:
	lsr_s r2,r2,0x7
L_8e6e30:
	bmsk_s r1,r1,0x1
L_8e6e32:
	bmsk_s r2,r2,0x6
L_8e6e34:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e6e36:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8e6e38
L_8e6e38:
	b.d L_8f9028
L_8e6e3c:
	ldb_s r0,[r0,0x8]
L_8e6e3e:
	nop_s
