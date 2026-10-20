/* vring_tbl__find_by_id @ 0x8cce14, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open_and_keys, vring__is_empty_by_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_tbl__find_by_id
vring_tbl__find_by_id:
	.global L_8cce14
L_8cce14:
	mov_s r3,0x0
L_8cce16:
	b_s L_8cce1a
	.global L_8cce18
L_8cce18:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8cce1a
L_8cce1a:
	brhs r3,0xa,L_8cce3c
L_8cce1e:
	mov_s r1,0x847f34
L_8cce24:
	sub r1,r1,0x400
L_8cce28:
	add2_s r1,r1,r3
L_8cce2a:
	ld r1,[r1,0x44c]
L_8cce32:
	breq_s r1,0,L_8cce18
L_8cce34:
	ld_s r2,[r1]
L_8cce36:
	brne r0,r2,L_8cce18
L_8cce3a:
	b_s L_8cce3e
	.global L_8cce3c
L_8cce3c:
	mov_s r1,0x0
	.global L_8cce3e
L_8cce3e:
	j_s.d [blink]
L_8cce40:
	mov_s r0,r1
L_8cce42:
	nop_s
