/* scan_mngr__update_connected_scan_time @ 0x8eaa88, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::update_connected_scan_time() - updated connected scan time to %d
 * Зовут его: scan_mngr__scan_done
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, scan_mngr__update_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__update_connected_scan_time
scan_mngr__update_connected_scan_time:
	.global L_8eaa88
L_8eaa88:
	push_s blink
L_8eaa8a:
	push_s r13
L_8eaa8c:
	bl.d L_8cbee8
L_8eaa90:
	mov_s r13,r0
L_8eaa92:
	mov_s r2,r0
L_8eaa94:
	st.as r0,[r13,0x86]
L_8eaa98:
	mov_s r1,0x10153c4
L_8eaa9e:
	bl.d L_8dcc10
L_8eaaa2:
	mov_s r0,0x29
L_8eaaa4:
	b L_8c025c
