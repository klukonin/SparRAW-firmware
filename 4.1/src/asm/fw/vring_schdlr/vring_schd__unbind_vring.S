/* vring_schd__unbind_vring @ 0x8c7904, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: vring__on_macq_delete_ntf
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, llist__remove, vring_list__find, vring_schd__remove_vring
 */
	.section .text.vring_schd__unbind_vring,"ax",@progbits
	.global vring_schd__unbind_vring
vring_schd__unbind_vring:
	.global L_8c7904
L_8c7904:
	push_s blink
L_8c7906:
	push_s r13
L_8c7908:
	mov_s r2,r0
L_8c790a:
	mov_s r0,0x0
L_8c790c:
	push_s r0
L_8c790e:
	mov_s r13,0x804580
L_8c7914:
	mov_s r3,sp
L_8c7916:
	mov_s r0,r13
L_8c7918:
	bl.d L_8e727c
L_8c791c:
	mov_s r1,r13
L_8c791e:
	brne_s r0,0,L_8c7938
L_8c7920:
	mov_s r0,blink
L_8c7922:
	mov_s r2,0x100a584
L_8c7928:
	mov_s r1,0x12b8
L_8c792e:
	bl.d L_8c82c0
L_8c7932:
	mov r3,0x116
L_8c7936:
	b_s L_8c7948
	.global L_8c7938
L_8c7938:
	mov_s r0,r13
L_8c793a:
	bl.d L_8de4ec
L_8c793e:
	ld_s r1,[sp,0x0]
L_8c7940:
	mov_s r0,r13
L_8c7942:
	bl.d L_8c7858
L_8c7946:
	ld_s r1,[sp,0x0]
	.global L_8c7948
L_8c7948:
	b.d L_8c033c
L_8c794c:
	add_s sp,sp,0x4
L_8c794e:
	nop_s
