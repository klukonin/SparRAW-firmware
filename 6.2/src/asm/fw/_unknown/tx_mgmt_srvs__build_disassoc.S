/* tx_mgmt_srvs__build_disassoc @ 0x8e9c9c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX MGMT SRVS: Build disassociate req length = %d
 * Зовут его: mlme_sm__send_disassoc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, mgmt_tx__build_mac_header
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_srvs__build_disassoc
tx_mgmt_srvs__build_disassoc:
	.global L_8e9c9c
L_8e9c9c:
	push_s blink
L_8e9c9e:
	bl.d L_8c01e0
L_8e9ca2:
	add_s r3,r3,0x1c
L_8e9ca4:
	mov_s r13,r0
L_8e9ca6:
	mov_s r14,r1
L_8e9ca8:
	mov_s r15,r4
L_8e9caa:
	mov_s r0,r2
L_8e9cac:
	mov_s r1,r13
L_8e9cae:
	bl.d L_8d7db8
L_8e9cb2:
	mov_s r2,0xa
L_8e9cb4:
	stw_s r15,[r13,0x18]
L_8e9cb6:
	mov_s r2,0x1a
L_8e9cb8:
	st_s r2,[r14]
L_8e9cba:
	mov_s r1,0x1013d6c
L_8e9cc0:
	bl.d L_8dcc10
L_8e9cc4:
	mov_s r0,0x2d
L_8e9cc6:
	b L_8c024c
L_8e9cca:
	nop_s
