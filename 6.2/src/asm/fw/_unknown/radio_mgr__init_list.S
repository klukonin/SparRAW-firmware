/* radio_mgr__init_list @ 0x8d91a0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__init_pool_and_sm
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, llist__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__init_list
radio_mgr__init_list:
	.global L_8d91a0
L_8d91a0:
	push_s blink
L_8d91a2:
	bl L_8c01e4
L_8d91a6:
	mov_s r13,r0
L_8d91a8:
	bl.d L_8e293c
L_8d91ac:
	mov_s r14,r1
L_8d91ae:
	b.d L_8c0254
L_8d91b2:
	st_s r14,[r13,0xc]
