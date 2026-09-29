/* rm_main_sm__lock_primary @ 0x8d91d4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::lock_primary. callback 0x%x for Handle:0x%x
 * Зовут его: rm_main_sm__get_next_prim_request
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, llist__insert, tail_llist__is_empty, u_schd__add
 */
	.section .text.rm_main_sm__lock_primary,"ax",@progbits
	.global rm_main_sm__lock_primary
rm_main_sm__lock_primary:
	.global L_8d91d4
L_8d91d4:
	push_s blink
L_8d91d6:
	bl L_8c02c4
L_8d91da:
	mov_s r13,r0
L_8d91dc:
	bl.d L_8dc8e8
L_8d91e0:
	ld_s r0,[r0,0x2c]
L_8d91e2:
	mov_s r14,r0
L_8d91e4:
	add2 r0,r13,0x31
L_8d91e8:
	bl.d L_8c1fc4
L_8d91ec:
	mov_s r1,r14
L_8d91ee:
	mov_s r0,0x3
L_8d91f0:
	st_s r0,[r14,0x8]
L_8d91f2:
	ld_s r0,[r13,0x28]
L_8d91f4:
	breq_s r0,0,L_8d9208
L_8d91f6:
	ld_s r3,[r14,0xc]
L_8d91f8:
	mov_s r2,0x1015ea4
L_8d91fe:
	mov_s r0,0x8
L_8d9200:
	mov_s r1,0x2
L_8d9202:
	bl.d L_8edff8
L_8d9206:
	mov_s r4,r14
	.global L_8d9208
L_8d9208:
	mov_s r0,0x1f9f0
L_8d920e:
	mov_s r1,r14
L_8d9210:
	mov_s r2,0x0
L_8d9212:
	bl.d L_8c2ac8
L_8d9216:
	mov_s r3,0x1
L_8d9218:
	b L_8c0334
