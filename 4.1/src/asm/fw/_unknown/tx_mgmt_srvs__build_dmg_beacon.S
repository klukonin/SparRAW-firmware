/* tx_mgmt_srvs__build_dmg_beacon @ 0x8e4c34, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX MGMT SRVS: Build DMG Beacon len %d
 *   TX MGMT SRVS: Before IE push - len %d
 *   TX MGMT SRVS: After IE push - len %d
 *   TX MGMT SRVS: No App IE added to DMG Beacon- len %d
 * Зовут его: add_discovery_bcon, tx_bcon__update_bcon
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, ies_block__is_empty, log_hexdump, memcpy_fw, mid__get_bcon_additional_ies, tx_mgmt_build_step
 */
	.section .text.tx_mgmt_srvs__build_dmg_beacon,"ax",@progbits
	.global tx_mgmt_srvs__build_dmg_beacon
tx_mgmt_srvs__build_dmg_beacon:
	.global L_8e4c34
L_8e4c34:
	push_s blink
L_8e4c36:
	bl L_8c02bc
L_8e4c3a:
	mov_s r15,r0
L_8e4c3c:
	mov_s r16,r1
L_8e4c3e:
	mov_s r13,r2
L_8e4c40:
	bl.d L_8ec89c
L_8e4c44:
	mov_s r1,r2
L_8e4c46:
	mov_s r14,r0
L_8e4c48:
	mov_s r2,0x10108f8
L_8e4c4e:
	mov_s r0,0xd
L_8e4c50:
	mov_s r1,0x2
L_8e4c52:
	bl.d L_8edfcc
L_8e4c56:
	mov_s r3,r14
L_8e4c58:
	add3 r0,r13,0x9
L_8e4c5c:
	bl.d L_8c97fc
L_8e4c60:
	mov_s r1,0x8
L_8e4c62:
	mov.f r13,r0
L_8e4c66:
	beq_s L_8e4c9c
L_8e4c68:
	bl L_8d70f0
L_8e4c6c:
	brne_s r0,0,L_8e4c9c
L_8e4c6e:
	mov_s r2,0x1010920
L_8e4c74:
	mov_s r0,0xd
L_8e4c76:
	mov_s r1,0x2
L_8e4c78:
	bl.d L_8edfcc
L_8e4c7c:
	mov_s r3,r14
L_8e4c7e:
	mov_s r0,r15
L_8e4c80:
	bl.d L_8c7f90
L_8e4c84:
	mov_s r1,r14
L_8e4c86:
	ld_s r1,[r13]
L_8e4c88:
	add_s r0,r15,r14
L_8e4c8a:
	bl.d L_8c0460
L_8e4c8e:
	ldw_s r2,[r13,0x4]
L_8e4c90:
	ldw_s r0,[r13,0x4]
L_8e4c92:
	mov_s r2,0x1010948
L_8e4c98:
	add_s r14,r14,r0
L_8e4c9a:
	b_s L_8e4ca2
	.global L_8e4c9c
L_8e4c9c:
	mov_s r2,0x1010970
	.global L_8e4ca2
L_8e4ca2:
	mov_s r0,0xd
L_8e4ca4:
	mov_s r1,0x2
L_8e4ca6:
	bl.d L_8edfcc
L_8e4caa:
	mov_s r3,r14
L_8e4cac:
	mov_s r0,r15
L_8e4cae:
	bl.d L_8c7f90
L_8e4cb2:
	mov_s r1,r14
L_8e4cb4:
	b.d L_8c0324
L_8e4cb8:
	st r14,[r16]
