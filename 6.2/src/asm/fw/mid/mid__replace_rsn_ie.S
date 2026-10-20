/* mid__replace_rsn_ie @ 0x8e6f34, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Replace RSN IE 0x%x new ie_len %d
 * Зовут его: mid__apply_app_ies
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_sysassert_fatal, hexdump_words, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__replace_rsn_ie
mid__replace_rsn_ie:
	.global L_8e6f34
L_8e6f34:
	push_s blink
L_8e6f36:
	bl L_8c01dc
L_8e6f3a:
	mov_s r16,r0
L_8e6f3c:
	ldb_s r13,[r1,0x1]
L_8e6f3e:
	mov_s r14,r1
L_8e6f40:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8e6f42:
	mov_s r0,r1
L_8e6f44:
	bl.d L_8c9790
L_8e6f48:
	mov_s r1,r13
L_8e6f4a:
	ldb_s r2,[r14]
L_8e6f4c:
	mov_s r1,0x100c634
L_8e6f52:
	mov_s r0,0x2b
L_8e6f54:
	bl.d L_8dcc80
L_8e6f58:
	mov_s r3,r13
L_8e6f5a:
	brhs r13,0x29,L_8e6f78
	.global L_8e6f5e
L_8e6f5e:
	add r16,r16,0x180
L_8e6f62:
	mov_s r0,r16
L_8e6f64:
	mov_s r1,r14
L_8e6f66:
	bl.d L_8c0380
L_8e6f6a:
	mov_s r2,r13
L_8e6f6c:
	mov_s r0,r16
L_8e6f6e:
	bl.d L_8c9790
L_8e6f72:
	mov_s r1,r13
L_8e6f74:
	b L_8c0244
	.global L_8e6f78
L_8e6f78:
	mov_s r0,blink
L_8e6f7a:
	mov_s r1,0x1482
L_8e6f80:
	bl L_8c9b28
L_8e6f84:
	b_s L_8e6f5e
L_8e6f86:
	nop_s
