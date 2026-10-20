/* radio_mgr__init_pool_and_sm @ 0x8d5c0c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init_radio_mgr
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words, radio_manager_main_sm__init, radio_mgr__init_list
 */
	.section .text.radio_mgr__init_pool_and_sm,"ax",@progbits
	.global radio_mgr__init_pool_and_sm
radio_mgr__init_pool_and_sm:
	.global L_8d5c0c
L_8d5c0c:
	push_s blink
L_8d5c0e:
	bl.d L_8c02c4
L_8d5c12:
	mov r1,0x240
L_8d5c16:
	mov_s r13,r0
L_8d5c18:
	mov_s r14,0x806500
L_8d5c1e:
	bl.d L_8c1a78
L_8d5c22:
	mov_s r0,r14
L_8d5c24:
	add_s r0,r13,0x4
L_8d5c26:
	mov_s r1,r14
L_8d5c28:
	mov_s r2,0x24
L_8d5c2a:
	bl.d L_8c6c70
L_8d5c2e:
	mov_s r3,0x10
L_8d5c30:
	add r14,r13,0x18
L_8d5c34:
	mov_s r0,r14
L_8d5c36:
	bl.d L_8d612c
L_8d5c3a:
	mov_s r1,r13
L_8d5c3c:
	add r0,r13,0x28
L_8d5c40:
	mov_s r1,r13
L_8d5c42:
	bl.d L_8d59b8
L_8d5c46:
	mov_s r2,r14
L_8d5c48:
	b L_8c0334
