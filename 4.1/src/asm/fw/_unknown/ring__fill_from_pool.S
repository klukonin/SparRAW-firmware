/* ring__fill_from_pool @ 0x8dca80, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ring__init_desc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__allocate
 */
	.section .text.ring__fill_from_pool,"ax",@progbits
	.global ring__fill_from_pool
ring__fill_from_pool:
	.global L_8dca80
L_8dca80:
	push_s blink
L_8dca82:
	bl L_8c02c0
L_8dca86:
	mov_s r13,r0
L_8dca88:
	mov_s r15,r1
L_8dca8a:
	ld_s r14,[r0,0x4]
L_8dca8c:
	b_s L_8dca98
	.global L_8dca8e
L_8dca8e:
	mov_s r0,0x0
	.global L_8dca90
L_8dca90:
	st_s r0,[r14,0x4]
L_8dca92:
	mov_s r0,0x0
L_8dca94:
	st.ab r0,[r14,0x8]
	.global L_8dca98
L_8dca98:
	ld_s r0,[r13,0x8]
L_8dca9a:
	brhs r14,r0,L_8dcaaa
L_8dca9e:
	brne r15,0x1,L_8dca8e
L_8dcaa2:
	bl.d L_8c2dc8
L_8dcaa6:
	ld_s r0,[r13,0x10]
L_8dcaa8:
	b_s L_8dca90
	.global L_8dcaaa
L_8dcaaa:
	.byte 0x85,0x00
