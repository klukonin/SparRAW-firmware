/* radio_mgr__init_pool_and_sm @ 0x8d8de4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__init_global
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words, obj_vt803210__ctor, radio_mgr__init_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__init_pool_and_sm
radio_mgr__init_pool_and_sm:
	.global L_8d8de4
L_8d8de4:
	push_s blink
L_8d8de6:
	bl.d L_8c01e4
L_8d8dea:
	mov r1,0x240
L_8d8dee:
	mov_s r13,r0
L_8d8df0:
	mov_s r14,0x8062d8
L_8d8df6:
	bl.d L_8c1cd8
L_8d8dfa:
	mov_s r0,r14
L_8d8dfc:
	add_s r0,r13,0x4
L_8d8dfe:
	mov_s r1,r14
L_8d8e00:
	mov_s r2,0x24
L_8d8e02:
	bl.d L_8c7cf8
L_8d8e06:
	mov_s r3,0x10
L_8d8e08:
	add r14,r13,0x18
L_8d8e0c:
	mov_s r0,r14
L_8d8e0e:
	bl.d L_8d91a0
L_8d8e12:
	mov_s r1,r13
L_8d8e14:
	add r0,r13,0x28
L_8d8e18:
	mov_s r1,r13
L_8d8e1a:
	bl.d L_8d8c1c
L_8d8e1e:
	mov_s r2,r14
L_8d8e20:
	b L_8c0254
