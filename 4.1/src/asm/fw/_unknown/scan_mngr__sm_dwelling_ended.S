/* scan_mngr__sm_dwelling_ended @ 0x8f0d18, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::sm_dwelling_ended()
 *   scan_mngr::sm_dwelling_ended() -> ACTIVE SCAN - del_bcon()
 *   scan_mngr::sm_dwelling_ended() MISSED %d Probe responses
 * Зовут его: channels_switch_sm__action_dwelling_stopped
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, scan_mngr__clean_all_lists, tx_bcon__del_bcon, u_schd__add
 */
	.section .text.scan_mngr__sm_dwelling_ended,"ax",@progbits
	.global scan_mngr__sm_dwelling_ended
scan_mngr__sm_dwelling_ended:
	.global L_8f0d18
L_8f0d18:
	push_s blink
L_8f0d1a:
	bl.d L_8c02c4
L_8f0d1e:
	mov_s r1,0x2
L_8f0d20:
	mov_s r14,r0
L_8f0d22:
	mov_s r2,0x1013cd4
L_8f0d28:
	bl.d L_8edfb0
L_8f0d2c:
	mov_s r0,0x9
L_8f0d2e:
	mov_s r0,0x1
L_8f0d30:
	add3 r13,r14,0x10
L_8f0d34:
	st_s r0,[r13,0x8]
L_8f0d36:
	ld_s r1,[r14,0x6c]
L_8f0d38:
	mov_s r0,0x0
L_8f0d3a:
	cmp_s r1,0x0
L_8f0d3c:
	cmp.ne r1,0x3
L_8f0d40:
	bne_s L_8f0d54
L_8f0d42:
	ldb_s r0,[r13,0xd]
L_8f0d44:
	brne r0,0x1,L_8f0d4e
L_8f0d48:
	ld_s r0,[r14,0x78]
L_8f0d4a:
	breq r0,0x1,L_8f0d52
	.global L_8f0d4e
L_8f0d4e:
	mov_s r0,0x0
L_8f0d50:
	b_s L_8f0d54
	.global L_8f0d52
L_8f0d52:
	mov_s r0,0x1
	.global L_8f0d54
L_8f0d54:
	extb.f 0x0,r0
L_8f0d58:
	beq_s L_8f0d6e
L_8f0d5a:
	mov_s r2,0x1013cf4
L_8f0d60:
	mov_s r0,0x9
L_8f0d62:
	bl.d L_8edfb0
L_8f0d66:
	mov_s r1,0x2
L_8f0d68:
	bl.d L_8c7578
L_8f0d6c:
	ld_s r0,[r14,0x7c]
	.global L_8f0d6e
L_8f0d6e:
	ldb_s r3,[r13,0xc]
L_8f0d70:
	breq_s r3,0,L_8f0d80
L_8f0d72:
	mov_s r2,0x1013d30
L_8f0d78:
	mov_s r0,0x9
L_8f0d7a:
	bl.d L_8edfcc
L_8f0d7e:
	mov_s r1,0x1
	.global L_8f0d80
L_8f0d80:
	bl.d L_8ea324
L_8f0d84:
	mov_s r0,r14
L_8f0d86:
	mov_s r0,0x3181c
L_8f0d8c:
	mov_s r1,r14
L_8f0d8e:
	mov_s r2,0x0
L_8f0d90:
	bl.d L_8c2ac8
L_8f0d94:
	mov_s r3,0x1
L_8f0d96:
	b L_8c0334
L_8f0d9a:
	nop_s
