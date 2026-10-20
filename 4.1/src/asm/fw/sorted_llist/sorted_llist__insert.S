/* sorted_llist__insert @ 0x8c2018, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sorted_llist.cpp
 * Зовут его: u_schd__insert
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, llist__insert, llist__insert_after, sorted_llist__unlink
 */
	.section .text.sorted_llist__insert,"ax",@progbits
	.global sorted_llist__insert
sorted_llist__insert:
	.global L_8c2018
L_8c2018:
	push_s blink
L_8c201a:
	bl L_8c02b8
L_8c201e:
	mov.f r14,r1
L_8c2022:
	mov_s r15,r0
L_8c2024:
	mov_s r16,r2
L_8c2026:
	beq_s L_8c2062
	.global L_8c2028
L_8c2028:
	breq r16,0x0,L_8c2074
	.global L_8c202c
L_8c202c:
	ld_s r0,[r15]
L_8c202e:
	cmp_s r0,0x0
L_8c2030:
	mov_s r0,0x1
L_8c2032:
	sub_s.ne r0,r0,r0
L_8c2034:
	extb.f 0x0,r0
L_8c2038:
	bne_s L_8c208a
L_8c203a:
	ld_s r13,[r15,0x4]
L_8c203c:
	mov r17,0x0
L_8c2040:
	b_s L_8c2046
	.global L_8c2042
L_8c2042:
	mov_s r17,r13
L_8c2044:
	mov_s r13,r0
	.global L_8c2046
L_8c2046:
	ld_s r0,[r13,0x8]
L_8c2048:
	mov_s r2,r16
L_8c204a:
	jl_s.d [r2]
L_8c204c:
	ld_s r1,[r14,0x8]
L_8c204e:
	cmp r0,-0x1
L_8c2052:
	bne_s L_8c2086
L_8c2054:
	ld_s r0,[r13]
L_8c2056:
	brne_s r0,0,L_8c2042
L_8c2058:
	mov_s r0,r15
L_8c205a:
	bl.d L_8c1fc4
L_8c205e:
	mov_s r1,r14
L_8c2060:
	b_s L_8c209e
	.global L_8c2062
L_8c2062:
	mov_s r0,blink
L_8c2064:
	mov_s r2,0x1001dec
L_8c206a:
	mov_s r1,0xf2
L_8c206c:
	bl.d L_8c82c0
L_8c2070:
	mov_s r3,0xa
L_8c2072:
	b_s L_8c2028
	.global L_8c2074
L_8c2074:
	mov_s r0,blink
L_8c2076:
	mov_s r2,0x1001dec
L_8c207c:
	mov_s r1,0xf3
L_8c207e:
	bl.d L_8c82c0
L_8c2082:
	mov_s r3,0xb
L_8c2084:
	b_s L_8c202c
	.global L_8c2086
L_8c2086:
	brne r17,0x0,L_8c2094
	.global L_8c208a
L_8c208a:
	mov_s r0,r15
L_8c208c:
	bl.d L_8c1f70
L_8c2090:
	mov_s r1,r14
L_8c2092:
	b_s L_8c209e
	.global L_8c2094
L_8c2094:
	mov_s r0,r15
L_8c2096:
	mov_s r1,r14
L_8c2098:
	bl.d L_8c20a4
L_8c209c:
	mov_s r2,r17
	.global L_8c209e
L_8c209e:
	b L_8c031c
L_8c20a2:
	nop_s
