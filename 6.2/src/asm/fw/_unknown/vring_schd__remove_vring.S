/* vring_schd__remove_vring @ 0x8c8e90, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Remove from VR_SCHDLR #%d V-ring.
 * Зовут его: stream_mgr__delete_vring
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, stream_mgr__check_vring, vring__clear_hw_state
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__remove_vring
vring_schd__remove_vring:
	.global L_8c8e90
L_8c8e90:
	push_s blink
L_8c8e92:
	push_s r13
L_8c8e94:
	mov_s r13,r1
L_8c8e96:
	mov_s r1,0x100bb70
L_8c8e9c:
	mov_s r0,0x27
L_8c8e9e:
	bl.d L_8dcc10
L_8c8ea2:
	ldb_s r2,[r13,0x9]
L_8c8ea4:
	bl.d L_8caf30
L_8c8ea8:
	mov_s r0,r13
L_8c8eaa:
	mov_s r0,0x804da8
L_8c8eb0:
	bl.d L_8caed0
L_8c8eb4:
	mov_s r1,r13
L_8c8eb6:
	b L_8c025c
L_8c8eba:
	nop_s
