/* radio_mgr__init_global @ 0x8f56b8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main, l2mgr__init
 * Зовёт сам: __ld_r13_to_r13_ret, radio_mgr__init_pool_and_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__init_global
radio_mgr__init_global:
	.global L_8f56b8
L_8f56b8:
	push_s blink
L_8f56ba:
	push_s r13
L_8f56bc:
	mov_s r13,0x806214
L_8f56c2:
	bl.d L_8d8de4
L_8f56c6:
	mov_s r0,r13
L_8f56c8:
	b.d L_8c025c
L_8f56cc:
	st.as r13,[gp,-0x10]
