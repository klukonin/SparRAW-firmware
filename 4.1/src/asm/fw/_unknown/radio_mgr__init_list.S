/* radio_mgr__init_list @ 0x8d612c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: radio_mgr__init_pool_and_sm
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, llist__init
 */
	.section .text.radio_mgr__init_list,"ax",@progbits
	.global radio_mgr__init_list
radio_mgr__init_list:
	.global L_8d612c
L_8d612c:
	push_s blink
L_8d612e:
	bl L_8c02c4
L_8d6132:
	mov_s r13,r0
L_8d6134:
	bl.d L_8de5c4
L_8d6138:
	mov_s r14,r1
L_8d613a:
	b.d L_8c0334
L_8d613e:
	st_s r14,[r13,0xc]
