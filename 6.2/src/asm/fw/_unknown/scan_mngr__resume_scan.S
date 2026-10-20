/* scan_mngr__resume_scan @ 0x8f8028, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::resume_scan()
 *   scan_mngr::resume_scan() - Not in posponed scan state. Returning.
 * Зовут его: scan_resume
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, scan_mngr__kick_scan_state_machine
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__resume_scan
scan_mngr__resume_scan:
	.global L_8f8028
L_8f8028:
	push_s blink
L_8f802a:
	push_s r13
L_8f802c:
	mov_s r13,r0
L_8f802e:
	mov_s r1,0x1015364
L_8f8034:
	bl.d L_8dcba8
L_8f8038:
	mov_s r0,0x29
L_8f803a:
	add3 r1,r13,0x30
L_8f803e:
	ld_s r0,[r1,0x4c]
L_8f8040:
	brne_s r0,0,L_8f8050
L_8f8042:
	mov_s r1,0x1015380
L_8f8048:
	bl.d L_8dcba8
L_8f804c:
	mov_s r0,0x29
L_8f804e:
	b_s L_8f805c
	.global L_8f8050
L_8f8050:
	mov_s r0,0x0
L_8f8052:
	st_s r0,[r1,0x4c]
L_8f8054:
	st_s r0,[r1,0x48]
L_8f8056:
	bl.d L_8f5d1c
L_8f805a:
	mov_s r0,r13
	.global L_8f805c
L_8f805c:
	b L_8c025c
