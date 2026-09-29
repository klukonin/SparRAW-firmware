/* rx_buf__init_descriptor @ 0x8dee00, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__refill_rx_buffers
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.rx_buf__init_descriptor,"ax",@progbits
	.global rx_buf__init_descriptor
rx_buf__init_descriptor:
	.global L_8dee00
L_8dee00:
	push_s blink
L_8dee02:
	bl L_8c02bc
L_8dee06:
	mov_s r13,r0
L_8dee08:
	mov_s r14,r1
L_8dee0a:
	mov_s r15,r2
L_8dee0c:
	mov_s r16,r3
L_8dee0e:
	bl.d L_8c1a78
L_8dee12:
	mov_s r1,0x20
L_8dee14:
	st_s r14,[r13,0x14]
L_8dee16:
	ld_s r1,[r13,0x10]
L_8dee18:
	st_s r15,[r13,0x18]
L_8dee1a:
	bclr_s r1,r1,0xa
L_8dee1c:
	bset r0,r1,0xa
L_8dee20:
	st_s r0,[r13,0x10]
L_8dee22:
	stw r16,[r13, 0x1e]
L_8dee26:
	or r1,r1,0x600
L_8dee2a:
	b.d L_8c0324
L_8dee2e:
	st_s r1,[r13,0x10]
