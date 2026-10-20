/* memcmp_fw @ 0x8da014, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__ssid_matches, mid_list__find_by, verify_ssid
 */
	.section .text.memcmp_fw,"ax",@progbits
	.global memcmp_fw
memcmp_fw:
	.global L_8da014
L_8da014:
	push_s r13
L_8da016:
	b_s L_8da024
	.global L_8da018
L_8da018:
	ldb.ab r3,[r1,0x1]
L_8da01c:
	ldb.ab r13,[r0,0x1]
L_8da020:
	brne r13,r3,L_8da030
	.global L_8da024
L_8da024:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8da026:
	cmp r2,-0x1
L_8da02a:
	bne_s L_8da018
L_8da02c:
	mov_s r0,0x0
L_8da02e:
	b_s L_8da046
	.global L_8da030
L_8da030:
	ldb r2,[r0, -0x1]
L_8da034:
	ldb r0,[r1, -0x1]
L_8da038:
	mov_s r1,0x1
L_8da03a:
	cmp_s r2,r0
L_8da03c:
	mov r0,-0x1
L_8da040:
	sub.lt r1,r1,r1
L_8da044:
	add1_s r0,r0,r1
	.global L_8da046
L_8da046:
	j_s.d [blink]
L_8da048:
	pop_s r13
L_8da04a:
	nop_s
