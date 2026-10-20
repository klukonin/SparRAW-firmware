/* l2mgr__config_security @ 0x8f1c84, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Config Security Mid[%d] configured: m_wpa_offload = %x, auth_mode = %x
 * Зовут его: bcon_ctrl__prepare_mid_fw, l2_mgr__connect_setup
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__config_security
l2mgr__config_security:
	.global L_8f1c84
L_8f1c84:
	push_s blink
L_8f1c86:
	push_s r13
L_8f1c88:
	mov_s r6,r2
L_8f1c8a:
	mov_s r13,r3
L_8f1c8c:
	mov_s r3,r5
L_8f1c8e:
	st_s r1,[r0]
L_8f1c90:
	st_s r2,[r0,0x4]
L_8f1c92:
	st_s r13,[r0,0x8]
L_8f1c94:
	st r4,[r0, 0xc]
L_8f1c98:
	mov_s r1,0x1
L_8f1c9a:
	st_s r1,[r0,0x10]
L_8f1c9c:
	st r5,[r0, 0x18]
L_8f1ca0:
	ld_s r2,[r0,0x1c]
L_8f1ca2:
	mov_s r1,0x1010f68
L_8f1ca8:
	ldb_s r2,[r2,0x10]
L_8f1caa:
	mov_s r0,0x2e
L_8f1cac:
	bl.d L_8dcd00
L_8f1cb0:
	mov r4,r6
L_8f1cb4:
	b L_8c025c
