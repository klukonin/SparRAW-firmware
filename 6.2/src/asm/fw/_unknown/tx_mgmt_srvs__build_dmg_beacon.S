/* tx_mgmt_srvs__build_dmg_beacon @ 0x8e9ccc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX MGMT SRVS: Build DMG Beacon len %d
 *   TX MGMT SRVS: Before IE push - len %d
 *   TX MGMT SRVS: After IE push - len %d
 *   TX MGMT SRVS: No App IE added to DMG Beacon- len %d
 * Зовут его: add_bcon, add_discovery_bcon
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, hexdump_words, ies_block__is_empty, memcpy_fw, mid__get_bcon_additional_ies, tx_mgmt_build_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_mgmt_srvs__build_dmg_beacon
tx_mgmt_srvs__build_dmg_beacon:
	.global L_8e9ccc
L_8e9ccc:
	push_s blink
L_8e9cce:
	bl L_8c01dc
L_8e9cd2:
	mov_s r15,r0
L_8e9cd4:
	mov_s r16,r1
L_8e9cd6:
	mov_s r13,r2
L_8e9cd8:
	bl.d L_8d7df4
L_8e9cdc:
	mov_s r1,r2
L_8e9cde:
	mov_s r14,r0
L_8e9ce0:
	mov_s r1,0x1013da0
L_8e9ce6:
	mov_s r0,0x2d
L_8e9ce8:
	bl.d L_8dcc10
L_8e9cec:
	mov_s r2,r14
L_8e9cee:
	add3 r0,r13,0x9
L_8e9cf2:
	bl.d L_8cb844
L_8e9cf6:
	mov_s r1,0x8
L_8e9cf8:
	mov.f r13,r0
L_8e9cfc:
	beq_s L_8e9d28
L_8e9cfe:
	bl L_8da1c0
L_8e9d02:
	brne_s r0,0,L_8e9d28
L_8e9d04:
	mov_s r1,0x1013dc8
L_8e9d0a:
	mov_s r0,0x2d
L_8e9d0c:
	bl.d L_8dcc10
L_8e9d10:
	mov_s r2,r14
L_8e9d12:
	ld_s r1,[r13]
L_8e9d14:
	add_s r0,r15,r14
L_8e9d16:
	bl.d L_8c0380
L_8e9d1a:
	ldw_s r2,[r13,0x4]
L_8e9d1c:
	ldw_s r0,[r13,0x4]
L_8e9d1e:
	mov_s r1,0x1013df0
L_8e9d24:
	add_s r14,r14,r0
L_8e9d26:
	b_s L_8e9d2e
	.global L_8e9d28
L_8e9d28:
	mov_s r1,0x1013e18
	.global L_8e9d2e
L_8e9d2e:
	mov_s r0,0x2d
L_8e9d30:
	bl.d L_8dcc10
L_8e9d34:
	mov_s r2,r14
L_8e9d36:
	mov_s r0,r15
L_8e9d38:
	bl.d L_8c9790
L_8e9d3c:
	mov_s r1,r14
L_8e9d3e:
	b.d L_8c0244
L_8e9d42:
	st r14,[r16]
L_8e9d46:
	nop_s
