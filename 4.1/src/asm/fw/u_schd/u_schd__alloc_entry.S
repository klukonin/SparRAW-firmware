/* u_schd__alloc_entry @ 0x8c2b88, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: u_schd__add, u_schd__insert
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.u_schd__alloc_entry,"ax",@progbits
	.global u_schd__alloc_entry
u_schd__alloc_entry:
	.global L_8c2b88
L_8c2b88:
	push_s blink
L_8c2b8a:
	bl L_8c02c4
L_8c2b8e:
	lr r14,[0xa]
L_8c2b92:
	bclr r0,r14,0x1
L_8c2b96:
	flag r0
L_8c2b9a:
	mov_s r0,0x8034d4
L_8c2ba0:
	bl.d L_8c2dc8
L_8c2ba4:
	bic r14,r14,-0x3
L_8c2ba8:
	mov_s r13,r0
L_8c2baa:
	lr r0,[0xa]
L_8c2bae:
	or_s r14,r14,r0
L_8c2bb0:
	flag r14
L_8c2bb4:
	breq_s r13,0,L_8c2bbc
	.global L_8c2bb6
L_8c2bb6:
	b.d L_8c0334
L_8c2bba:
	mov_s r0,r13
	.global L_8c2bbc
L_8c2bbc:
	mov_s r0,blink
L_8c2bbe:
	mov_s r2,0x1001708
L_8c2bc4:
	mov_s r1,0x63
L_8c2bc6:
	bset_s r1,r1,0xc
L_8c2bc8:
	bl.d L_8c82c0
L_8c2bcc:
	mov_s r3,0x64
L_8c2bce:
	b_s L_8c2bb6
