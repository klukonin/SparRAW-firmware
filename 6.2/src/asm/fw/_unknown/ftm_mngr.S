/* ftm_mngr @ 0x8c2a30, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ftm_mngr:: can't add FTM session
 * Зовут его: state_sm_8034c0__step_b, tof__find_session_by_addr
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, list__find_entry_d, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_mngr
ftm_mngr:
	.global L_8c2a30
L_8c2a30:
	push_s blink
L_8c2a32:
	bl L_8c01dc
L_8c2a36:
	mov.f r15,r2
L_8c2a3a:
	mov_s r16,r1
L_8c2a3c:
	mov_s r13,r3
L_8c2a3e:
	bne_s L_8c2a50
L_8c2a40:
	mov_s r1,0x10197c4
L_8c2a46:
	bl.d L_8dcba8
L_8c2a4a:
	mov_s r0,0x1b
L_8c2a4c:
	mov_s r0,0x0
L_8c2a4e:
	b_s L_8c2a8c
	.global L_8c2a50
L_8c2a50:
	add r14,r15,0x8
L_8c2a54:
	add r0,r14,0x8
L_8c2a58:
	add r1,r13,0x8
L_8c2a5c:
	bl.d L_8c0380
L_8c2a60:
	mov_s r2,0x6
L_8c2a62:
	ldb_s r0,[r13]
L_8c2a64:
	stb_s r0,[r14]
L_8c2a66:
	ldb_s r0,[r13,0x3]
L_8c2a68:
	stb_s r0,[r14,0x3]
L_8c2a6a:
	ldb_s r0,[r13,0x4]
L_8c2a6c:
	stb_s r0,[r14,0x4]
L_8c2a6e:
	ldb_s r0,[r13,0x5]
L_8c2a70:
	stb_s r0,[r14,0x5]
L_8c2a72:
	ldw_s r0,[r13,0x6]
L_8c2a74:
	stw_s r0,[r14,0x6]
L_8c2a76:
	ldb_s r0,[r13,0x1]
L_8c2a78:
	stb_s r0,[r14,0x1]
L_8c2a7a:
	ldb_s r0,[r13,0x2]
L_8c2a7c:
	stb_s r0,[r14,0x2]
L_8c2a7e:
	ldw_s r0,[r13,0xe]
L_8c2a80:
	stw_s r0,[r14,0xe]
L_8c2a82:
	mov_s r0,r16
L_8c2a84:
	bl.d L_8c25f4
L_8c2a88:
	mov_s r1,r15
L_8c2a8a:
	mov_s r0,0x1
	.global L_8c2a8c
L_8c2a8c:
	b L_8c0244
