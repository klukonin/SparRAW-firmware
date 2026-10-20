/* retry__try_next @ 0x8f7ce4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: backoff__add_and_schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global retry__try_next
retry__try_next:
	.global L_8f7ce4
L_8f7ce4:
	push_s blink
L_8f7ce6:
	ld_s r1,[r0,0x4]
L_8f7ce8:
	ldw_s r2,[r0,0xc]
L_8f7cea:
	cmp_s r1,r2
L_8f7cec:
	mov.cc r0,0x0
L_8f7cf0:
	bhs_s L_8f7d0a
L_8f7cf2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f7cf4:
	st_s r1,[r0,0x4]
L_8f7cf6:
	ld_s r1,[r0,0x18]
L_8f7cf8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f7cfa:
	st_s r1,[r0,0x18]
L_8f7cfc:
	ld_s r1,[r0,0x14]
L_8f7cfe:
	cmp_s r1,0x0
L_8f7d00:
	bl.ne.d L_8f1c30
L_8f7d04:
	mov.ne r1,0x1
L_8f7d08:
	mov_s r0,0x1
	.global L_8f7d0a
L_8f7d0a:
	pop_s blink
L_8f7d0c:
	j_s [blink]
L_8f7d0e:
	nop_s
