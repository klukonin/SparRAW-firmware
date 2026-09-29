/* bf_txss__reset_report_ctx @ 0x92ebfc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__on_txss_init, bf_sm__on_txss_resp
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_txss__reset_report_ctx
bf_txss__reset_report_ctx:
	.global L_92ebfc
L_92ebfc:
	mov r0,-0x14
L_92ec00:
	mov_s r1,0x8020f0
L_92ec06:
	st_s r0,[r1,0x8]
L_92ec08:
	mov_s r0,0x0
L_92ec0a:
	stb_s r0,[r1,0xe]
L_92ec0c:
	st_s r0,[r1,0x10]
L_92ec0e:
	st_s r0,[r1,0x14]
L_92ec10:
	st_s r0,[r1,0x18]
L_92ec12:
	j_s.d [blink]
L_92ec14:
	st_s r0,[r1,0x1c]
L_92ec16:
	nop_s
