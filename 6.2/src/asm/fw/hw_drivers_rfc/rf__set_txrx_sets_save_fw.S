/* rf__set_txrx_sets_save_fw @ 0x8d3efc, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rfc__restore_txrx_sets_fw
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__set_txrx_sets_save_fw
rf__set_txrx_sets_save_fw:
	.global L_8d3efc
L_8d3efc:
	push_s blink
L_8d3efe:
	bl L_8c01dc
L_8d3f02:
	mov_s r13,r0
L_8d3f04:
	mov_s r16,r1
L_8d3f06:
	breq_s r2,0,L_8d3f12
L_8d3f08:
	mov_s r0,0x889480
L_8d3f0e:
	ld_s r0,[r0,0x8]
L_8d3f10:
	st_s r0,[r2]
	.global L_8d3f12
L_8d3f12:
	breq_s r3,0,L_8d3f1e
L_8d3f14:
	mov_s r0,0x889100
L_8d3f1a:
	ld_s r0,[r0,0x54]
L_8d3f1c:
	st_s r0,[r3]
	.global L_8d3f1e
L_8d3f1e:
	mov_s r12,r16
L_8d3f20:
	bic.f r12,r12,0xff
L_8d3f24:
	bne_s L_8d3f62
	.global L_8d3f26
L_8d3f26:
	mov_s r2,0x889480
L_8d3f2c:
	ld_s r1,[r2,0x8]
L_8d3f2e:
	asl r0,r16,0x10
L_8d3f32:
	and r1,r1,0xff00ffff
L_8d3f3a:
	or_s r0,r0,r1
L_8d3f3c:
	st_s r0,[r2,0x8]
L_8d3f3e:
	bic.f r14,r13,0xf
L_8d3f42:
	bne_s L_8d3f6c
	.global L_8d3f44
L_8d3f44:
	brne_s r14,0,L_8d3f76
	.global L_8d3f46
L_8d3f46:
	mov_s r0,0x889100
L_8d3f4c:
	ld_s r1,[r0,0x54]
L_8d3f4e:
	bic r1,r1,0xf
L_8d3f52:
	or_s r1,r1,r13
L_8d3f54:
	bic r1,r1,0xf0
L_8d3f58:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8d3f5a:
	or_s r1,r1,r13
L_8d3f5c:
	st_s r1,[r0,0x54]
L_8d3f5e:
	b L_8c0244
	.global L_8d3f62
L_8d3f62:
	mov_s r0,blink
L_8d3f64:
	bl.d L_8c9b28
L_8d3f68:
	mov_s r1,0xac
L_8d3f6a:
	b_s L_8d3f26
	.global L_8d3f6c
L_8d3f6c:
	mov_s r0,blink
L_8d3f6e:
	bl.d L_8c9b28
L_8d3f72:
	mov_s r1,0xad
L_8d3f74:
	b_s L_8d3f44
	.global L_8d3f76
L_8d3f76:
	mov_s r0,blink
L_8d3f78:
	bl.d L_8c9b28
L_8d3f7c:
	mov_s r1,0xae
L_8d3f7e:
	b_s L_8d3f46
