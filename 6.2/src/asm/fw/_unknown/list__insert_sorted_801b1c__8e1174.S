/* list__insert_sorted_801b1c__8e1174 @ 0x8e1174, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: list__insert_obj__8c1cc0
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__insert_sorted_801b1c__8e1174
list__insert_sorted_801b1c__8e1174:
	.global L_8e1174
L_8e1174:
	push_s blink
L_8e1176:
	bl.d L_8c01e0
L_8e117a:
	mov_s r3,0x0
L_8e117c:
	mov_s r14,0x801b1c
L_8e1182:
	add2_s r14,r14,r1
L_8e1184:
	ld_s r1,[r14]
L_8e1186:
	ld_s r13,[r0]
L_8e1188:
	breq_s r1,0,L_8e11a2
	.global L_8e118a
L_8e118a:
	ld_s r15,[r1]
L_8e118c:
	breq_s r2,0,L_8e1194
L_8e118e:
	brlo r15,r13,L_8e1198
L_8e1192:
	b_s L_8e11a2
	.global L_8e1194
L_8e1194:
	brhs r13,r15,L_8e11a2
	.global L_8e1198
L_8e1198:
	ld_s r15,[r1,0x8]
L_8e119a:
	breq_s r15,0,L_8e11a6
L_8e119c:
	mov_s r3,r1
L_8e119e:
	mov_s r1,r15
L_8e11a0:
	b_s L_8e118a
	.global L_8e11a2
L_8e11a2:
	mov_s r15,r1
L_8e11a4:
	mov_s r1,r3
	.global L_8e11a6
L_8e11a6:
	st_s r15,[r0,0x8]
L_8e11a8:
	brne_s r1,0,L_8e11ae
L_8e11aa:
	st_s r0,[r14]
L_8e11ac:
	b_s L_8e11b0
	.global L_8e11ae
L_8e11ae:
	st_s r0,[r1,0x8]
	.global L_8e11b0
L_8e11b0:
	b L_8c024c
