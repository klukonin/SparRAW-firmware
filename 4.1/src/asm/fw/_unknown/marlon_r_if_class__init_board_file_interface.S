/* marlon_r_if_class__init_board_file_interface @ 0x8d66d8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::init_board_file_interface: Multi-Array format board file detected. Shall be parsed by brd_if_multi_array
 *   marlon_r_if_class::init_board_file_interface: Failed to initialize board file interface. Check board file
 * Зовут его: marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brd_if_multi_array__init, fw_log__emit0
 */
	.section .text.marlon_r_if_class__init_board_file_interface,"ax",@progbits
	.global marlon_r_if_class__init_board_file_interface
marlon_r_if_class__init_board_file_interface:
	.global L_8d66d8
L_8d66d8:
	push_s blink
L_8d66da:
	bl.d L_8c02c4
L_8d66de:
	mov_s r2,0x0
L_8d66e0:
	mov_s r13,r0
L_8d66e2:
	add r14,r0,0x8
L_8d66e6:
	mov_s r0,r14
L_8d66e8:
	mov_s r1,0x84f800
L_8d66ee:
	bl.d L_8d5ec4
L_8d66f2:
	bset_s r2,r2,0xc
L_8d66f4:
	mov_s r1,0x0
L_8d66f6:
	breq_s r0,0,L_8d6706
L_8d66f8:
	st_s r14,[r13,0x20]
L_8d66fa:
	mov_s r2,0x1005c78
L_8d6700:
	mov_s r0,r1
L_8d6702:
	mov_s r1,0x2
L_8d6704:
	b_s L_8d6710
	.global L_8d6706
L_8d6706:
	st_s r1,[r13,0x20]
L_8d6708:
	mov_s r2,0x1005cf4
L_8d670e:
	mov_s r0,r1
	.global L_8d6710
L_8d6710:
	bl L_8edfb0
L_8d6714:
	ld_s r0,[r13,0x20]
L_8d6716:
	sub.f r0,r0,0x0
L_8d671a:
	b.d L_8c0334
L_8d671e:
	mov.ne r0,0x1
L_8d6722:
	nop_s
