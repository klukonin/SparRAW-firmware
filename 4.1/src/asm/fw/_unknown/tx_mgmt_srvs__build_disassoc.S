/* tx_mgmt_srvs__build_disassoc @ 0x8e4c04, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX MGMT SRVS: Build disassociate req length = %d
 * Зовут его: mlme_sm__send_disassoc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, mgmt_tx__build_mac_header
 */
	.section .text.tx_mgmt_srvs__build_disassoc,"ax",@progbits
	.global tx_mgmt_srvs__build_disassoc
tx_mgmt_srvs__build_disassoc:
	.global L_8e4c04
L_8e4c04:
	push_s blink
L_8e4c06:
	bl.d L_8c02c0
L_8e4c0a:
	add_s r3,r3,0x10
L_8e4c0c:
	mov_s r13,r0
L_8e4c0e:
	mov_s r14,r1
L_8e4c10:
	mov_s r15,r4
L_8e4c12:
	mov_s r0,r2
L_8e4c14:
	mov_s r1,r13
L_8e4c16:
	bl.d L_8ec5c0
L_8e4c1a:
	mov_s r2,0xa
L_8e4c1c:
	stw_s r15,[r13,0x18]
L_8e4c1e:
	mov_s r3,0x1a
L_8e4c20:
	st_s r3,[r14]
L_8e4c22:
	mov_s r2,0x10108c4
L_8e4c28:
	mov_s r0,0xd
L_8e4c2a:
	bl.d L_8edfcc
L_8e4c2e:
	mov_s r1,0x2
L_8e4c30:
	b L_8c032c
