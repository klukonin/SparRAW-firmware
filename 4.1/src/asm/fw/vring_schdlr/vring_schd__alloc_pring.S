/* vring_schd__alloc_pring @ 0x8c1dac, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: stream_mgr__add_bcast_vring
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, vring_list__find, vring_schd__move_to_ready
 */
	.section .text.vring_schd__alloc_pring,"ax",@progbits
	.global vring_schd__alloc_pring
vring_schd__alloc_pring:
	.global L_8c1dac
L_8c1dac:
	push_s blink
L_8c1dae:
	push_s r13
L_8c1db0:
	mov_s r2,r0
L_8c1db2:
	mov_s r0,0x0
L_8c1db4:
	push_s r0
L_8c1db6:
	mov_s r13,0x804580
L_8c1dbc:
	mov_s r3,sp
L_8c1dbe:
	mov_s r0,r13
L_8c1dc0:
	bl.d L_8e727c
L_8c1dc4:
	mov_s r1,r13
L_8c1dc6:
	brne_s r0,0,L_8c1de0
L_8c1dc8:
	mov_s r0,blink
L_8c1dca:
	mov_s r2,0x100a584
L_8c1dd0:
	mov_s r1,0x133c
L_8c1dd6:
	bl.d L_8c82c0
L_8c1dda:
	mov r3,0x2dc
L_8c1dde:
	b_s L_8c1de8
	.global L_8c1de0
L_8c1de0:
	mov_s r0,r13
L_8c1de2:
	bl.d L_8c1e44
L_8c1de6:
	ld_s r1,[sp,0x0]
	.global L_8c1de8
L_8c1de8:
	b.d L_8c033c
L_8c1dec:
	add_s sp,sp,0x4
L_8c1dee:
	nop_s
