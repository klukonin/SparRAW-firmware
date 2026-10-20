/* dashboard__bf_results @ 0x8eab44, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [dashboard] ABFT BF results received for already removed connection
 *   [dashboard] Received BF results for invalid connection
 *   [dashboard]  cid(%d) exceeds limits
 * Зовут его: lmac_if__abft_notify_evt
 * Зовёт сам: fw_log_emit0, fw_log_emit1, maintain_ctx__set_field_9c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dashboard__bf_results
dashboard__bf_results:
	.global L_8eab44
L_8eab44:
	mov_s r3,r0
L_8eab46:
	brne_s r1,0,L_8eab66
L_8eab48:
	ld_s r0,[r3,0x30]
L_8eab4a:
	brne r0,0x2,L_8eab5a
L_8eab4e:
	mov_s r1,0x1018094
L_8eab54:
	b.d L_8dcba8
L_8eab58:
	mov_s r0,0x25
	.global L_8eab5a
L_8eab5a:
	mov_s r1,0x10180d8
L_8eab60:
	b.d L_8dcba8
L_8eab64:
	mov_s r0,0x15
	.global L_8eab66
L_8eab66:
	ldb_s r2,[r1,0x8]
L_8eab68:
	brlt r2,0x8,L_8eab78
L_8eab6c:
	mov_s r1,0x1018110
L_8eab72:
	b.d L_8dcc10
L_8eab76:
	mov_s r0,0x15
	.global L_8eab78
L_8eab78:
	ld_s r0,[r3,0x2c]
L_8eab7a:
	brne r0,0x1,L_8eab86
L_8eab7e:
	mov_s r0,r2
L_8eab80:
	b.d L_8ea9d0
L_8eab84:
	ld_s r1,[r3,0x3c]
	.global L_8eab86
L_8eab86:
	j_s [blink]
