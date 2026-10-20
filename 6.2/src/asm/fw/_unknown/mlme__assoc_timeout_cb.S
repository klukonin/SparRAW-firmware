/* mlme__assoc_timeout_cb @ 0x8f1054, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   assoc_timeout_cb ; p_sm->m_assoc_timer_id=%d
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme__assoc_timeout_cb
mlme__assoc_timeout_cb:
	.global L_8f1054
L_8f1054:
	push_s blink
L_8f1056:
	push_s r13
L_8f1058:
	mov_s r13,r0
L_8f105a:
	mov_s r1,0x101132c
L_8f1060:
	mov_s r0,0x1a
L_8f1062:
	bl.d L_8dcc10
L_8f1066:
	ld_s r2,[r13,0x14]
L_8f1068:
	ld_s r0,[r13,0x14]
L_8f106a:
	breq_s r0,0,L_8f107c
L_8f106c:
	mov_s r2,0x0
L_8f106e:
	st_s r2,[r13,0x14]
L_8f1070:
	mov_s r0,r13
L_8f1072:
	mov_s r1,0x6
L_8f1074:
	mov_s r3,r2
L_8f1076:
	bl.d L_8d9b6c
L_8f107a:
	mov_s r4,r2
	.global L_8f107c
L_8f107c:
	b L_8c025c
