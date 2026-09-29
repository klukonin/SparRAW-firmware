/* scan_mngr__sm_ready_for_dwelling @ 0x8f0d9c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::sm_ready_for_dwelling()
 *   scan_mngr::sm_ready_for_dwelling() -> ACTIVE SCAN - add_discovery_bcon()
 * Зовут его: channels_switch_sm__action_radio_tunned
 * Зовёт сам: __ld_r13_ret, add_discovery_bcon, fw_log__emit0, u_schd__add
 */
	.section .text.scan_mngr__sm_ready_for_dwelling,"ax",@progbits
	.global scan_mngr__sm_ready_for_dwelling
scan_mngr__sm_ready_for_dwelling:
	.global L_8f0d9c
L_8f0d9c:
	push_s blink
L_8f0d9e:
	push_s r13
L_8f0da0:
	mov_s r13,r0
L_8f0da2:
	mov_s r2,0x1013c64
L_8f0da8:
	mov_s r0,0x9
L_8f0daa:
	bl.d L_8edfb0
L_8f0dae:
	mov_s r1,0x2
L_8f0db0:
	mov_s r0,0x0
L_8f0db2:
	ld_s r1,[r13,0x6c]
L_8f0db4:
	stb r0,[r13, 0x8c]
L_8f0db8:
	cmp_s r1,0x0
L_8f0dba:
	cmp.ne r1,0x3
L_8f0dbe:
	bne_s L_8f0dd4
L_8f0dc0:
	ldb r0,[r13, 0x8d]
L_8f0dc4:
	brne r0,0x1,L_8f0dce
L_8f0dc8:
	ld_s r0,[r13,0x78]
L_8f0dca:
	breq r0,0x1,L_8f0dd2
	.global L_8f0dce
L_8f0dce:
	mov_s r0,0x0
L_8f0dd0:
	b_s L_8f0dd4
	.global L_8f0dd2
L_8f0dd2:
	mov_s r0,0x1
	.global L_8f0dd4
L_8f0dd4:
	extb.f 0x0,r0
L_8f0dd8:
	beq_s L_8f0df0
L_8f0dda:
	mov_s r2,0x1013c88
L_8f0de0:
	mov_s r0,0x9
L_8f0de2:
	bl.d L_8edfb0
L_8f0de6:
	mov_s r1,0x2
L_8f0de8:
	ld_s r0,[r13,0x7c]
L_8f0dea:
	bl.d L_8c22e4
L_8f0dee:
	mov_s r1,0x0
	.global L_8f0df0
L_8f0df0:
	mov_s r0,0x312cc
L_8f0df6:
	mov_s r1,r13
L_8f0df8:
	mov_s r2,0x0
L_8f0dfa:
	bl.d L_8c2ac8
L_8f0dfe:
	mov_s r3,0x1
L_8f0e00:
	b L_8c033c
