/* verify_ssid @ 0x8ebe18, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   verify_ssid: length %x %x
 *   verify_ssid: mismatch %x %x %x
 * Зовут его: bss_join_verify
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, fw_log_emit3, memcmp_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global verify_ssid
verify_ssid:
	.global L_8ebe18
L_8ebe18:
	push_s blink
L_8ebe1a:
	push_s r13
L_8ebe1c:
	mov_s r13,r0
L_8ebe1e:
	ld_s r3,[r13,0x48]
L_8ebe20:
	mov_s r0,r1
L_8ebe22:
	breq r2,r3,L_8ebe36
L_8ebe26:
	mov_s r1,0x100c47c
L_8ebe2c:
	bl.d L_8dcc80
L_8ebe30:
	mov_s r0,0x2b
L_8ebe32:
	mov_s r0,0x0
L_8ebe34:
	b_s L_8ebe5e
	.global L_8ebe36
L_8ebe36:
	add r1,r13,0x26
L_8ebe3a:
	bl.d L_8ddf4c
L_8ebe3e:
	mov_s r2,r3
L_8ebe40:
	breq_s r0,0,L_8ebe5c
L_8ebe42:
	add_s r13,r13,0x20
L_8ebe44:
	ldb r4,[r13, 0x8]
L_8ebe48:
	mov_s r1,0x100c498
L_8ebe4e:
	ldb_s r2,[r13,0x6]
L_8ebe50:
	mov_s r0,0x2b
L_8ebe52:
	bl.d L_8dcd00
L_8ebe56:
	ldb_s r3,[r13,0x7]
L_8ebe58:
	mov_s r0,0x0
L_8ebe5a:
	b_s L_8ebe5e
	.global L_8ebe5c
L_8ebe5c:
	mov_s r0,0x1
	.global L_8ebe5e
L_8ebe5e:
	b L_8c025c
L_8ebe62:
	nop_s
