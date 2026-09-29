/* mid__refill_rx_buffers @ 0x8e1e4c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__attach_rx_pool
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, rx_api__alloc_rx_buffer, rx_buf__init_descriptor
 */
	.section .text.mid__refill_rx_buffers,"ax",@progbits
	.global mid__refill_rx_buffers
mid__refill_rx_buffers:
	.global L_8e1e4c
L_8e1e4c:
	push_s blink
L_8e1e4e:
	bl L_8c02c0
L_8e1e52:
	mov_s r15,r0
L_8e1e54:
	ld_s r13,[r0]
L_8e1e56:
	ld_s r0,[r0,0x4]
L_8e1e58:
	brlo.d r0,0x1,L_8e1e84
L_8e1e5c:
	mov_s r14,0x0
	.global L_8e1e5e
L_8e1e5e:
	/* bl.d 0x008c2bf4 */
	.byte 0x9a,0x0d,0x6f,0xf0
L_8e1e62:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e1e64:
	mov_s r1,0x8062e0
L_8e1e6a:
	ld_s r1,[r1,0x8]
L_8e1e6c:
	sub r3,r1,0x38
L_8e1e70:
	bmsk r1,r0,0x11
L_8e1e74:
	mov_s r0,r13
L_8e1e76:
	bl.d L_8dee00
L_8e1e7a:
	mov_s r2,0x0
L_8e1e7c:
	ld_s r0,[r15,0x4]
L_8e1e7e:
	brlo.d r14,r0,L_8e1e5e
L_8e1e82:
	add_s r13,r13,0x20
	.global L_8e1e84
L_8e1e84:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8e1e86:
	b.d L_8c032c
L_8e1e8a:
	st_s r0,[r15,0xc]
