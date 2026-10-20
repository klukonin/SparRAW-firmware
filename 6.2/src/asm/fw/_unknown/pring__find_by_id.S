/* pring__find_by_id @ 0x8cd00c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__timeout
 * Зовёт сам: __ld_r13_to_r13_ret, vring__find_busy_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pring__find_by_id
pring__find_by_id:
	.global L_8cd00c
L_8cd00c:
	mov_s r3,0x0
L_8cd00e:
	b_s L_8cd014
	.global L_8cd010
L_8cd010:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8cd012:
	extb_s r3,r3
	.global L_8cd014
L_8cd014:
	brhs r3,0x9,L_8cd02e
L_8cd018:
	asl_s r1,r3,0x3
L_8cd01a:
	add2_s r1,r1,r1
L_8cd01c:
	add_s r1,r1,0x804c40
L_8cd022:
	ld_s r2,[r1,0x24]
L_8cd024:
	breq_s r2,0,L_8cd010
L_8cd026:
	ldb_s r2,[r1,0x9]
L_8cd028:
	brne r0,r2,L_8cd010
L_8cd02c:
	b_s L_8cd030
	.global L_8cd02e
L_8cd02e:
	mov_s r1,0x0
	.global L_8cd030
L_8cd030:
	j_s.d [blink]
L_8cd032:
	mov_s r0,r1
L_8cd034:
	push_s blink
L_8cd036:
	push_s r13
L_8cd038:
	mov_s r13,0x0
L_8cd03a:
	bl.d L_8ccfe4
L_8cd03e:
	mov_s r0,r1
L_8cd040:
	cmp_s r0,0x0
L_8cd042:
	mov.eq r0,r13
L_8cd046:
	beq_s L_8cd04a
L_8cd048:
	ld_s r0,[r0,0x1c]
	.global L_8cd04a
L_8cd04a:
	b L_8c025c
L_8cd04e:
	nop_s
L_8cd050:
	mov_s r0,0x857748
L_8cd056:
	j_s.d [blink]
L_8cd058:
	ld.as r0,[r0,r1]
L_8cd05c:
	push_s blink
L_8cd05e:
	bl.d L_8ccfe4
L_8cd062:
	mov_s r0,r1
L_8cd064:
	cmp_s r0,0x0
L_8cd066:
	mov.eq r0,0xff
L_8cd06e:
	beq_s L_8cd072
L_8cd070:
	ldb_s r0,[r0,0x9]
	.global L_8cd072
L_8cd072:
	pop_s blink
L_8cd074:
	j_s [blink]
L_8cd076:
	nop_s
L_8cd078:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8cd07a:
	j_s.d [blink]
L_8cd07c:
	ldb_s r0,[r0,r1]
L_8cd07e:
	nop_s
