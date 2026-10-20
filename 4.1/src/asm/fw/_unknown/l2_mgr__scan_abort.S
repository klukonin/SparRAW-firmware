/* l2_mgr__scan_abort @ 0x8efed8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::scan_abort: scan is not active. Sending done event
 *   l2_mgr::scan_abort: Sending scan stop to MID:[%d]
 *   l2_mgr::scan_abort: P2P Find session stop to MID:[%d]
 * Зовут его: low_sme__handle_rf_kill
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, mid_list__by_mid, scan_abort, stop_find_session, u_schd__add
 */
	.section .text.l2_mgr__scan_abort,"ax",@progbits
	.global l2_mgr__scan_abort
l2_mgr__scan_abort:
	.global L_8efed8
L_8efed8:
	push_s blink
L_8efeda:
	bl L_8c02c4
L_8efede:
	mov_s r14,0x0
L_8efee0:
	b_s L_8eff02
	.global L_8efee2
L_8efee2:
	mov_s r2,0x100d2c0
L_8efee8:
	mov_s r0,0xb
L_8efeea:
	bl.d L_8edfb0
L_8efeee:
	mov_s r1,0x2
L_8efef0:
	mov_s r0,0x28860
L_8efef6:
	mov_s r1,0x0
L_8efef8:
	mov_s r2,r1
L_8efefa:
	bl.d L_8c2ac8
L_8efefe:
	mov_s r3,0x1
	.global L_8eff00
L_8eff00:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8eff02
L_8eff02:
	brge r14,0x1,L_8eff4e
L_8eff06:
	bl.d L_8ca1b0
L_8eff0a:
	mov_s r0,r14
L_8eff0c:
	breq_s r0,0,L_8eff00
L_8eff0e:
	mov_s r13,r0
L_8eff10:
	add r13,r13,0x234
L_8eff14:
	ld_s r0,[r13,0x8]
L_8eff16:
	ld_s r0,[r0,0x78]
L_8eff18:
	breq_s r0,0,L_8eff32
L_8eff1a:
	mov_s r2,0x100d2fc
L_8eff20:
	mov_s r0,0xb
L_8eff22:
	mov_s r1,0x2
L_8eff24:
	bl.d L_8edfcc
L_8eff28:
	mov_s r3,r14
L_8eff2a:
	bl.d L_8eff54
L_8eff2e:
	mov_s r0,r13
L_8eff30:
	b_s L_8eff00
	.global L_8eff32
L_8eff32:
	ld_s r0,[r13,0x70]
L_8eff34:
	breq_s r0,0,L_8efee2
L_8eff36:
	mov_s r2,0x100d330
L_8eff3c:
	mov_s r0,0xb
L_8eff3e:
	mov_s r1,0x2
L_8eff40:
	bl.d L_8edfcc
L_8eff44:
	mov_s r3,r14
L_8eff46:
	bl.d L_8f17b8
L_8eff4a:
	mov_s r0,r13
L_8eff4c:
	b_s L_8eff00
	.global L_8eff4e
L_8eff4e:
	b L_8c0334
L_8eff52:
	nop_s
