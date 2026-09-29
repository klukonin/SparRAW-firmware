/* find_mngr__link_up @ 0x8c3f4c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: Link up....
 * Зовут его: handle_abft_event, l2mgr__notify_link_up
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.find_mngr__link_up,"ax",@progbits
	.global find_mngr__link_up
find_mngr__link_up:
	.global L_8c3f4c
L_8c3f4c:
	push_s blink
L_8c3f4e:
	bl L_8c02c0
L_8c3f52:
	mov_s r13,r0
L_8c3f54:
	ld_s r0,[r0,0x64]
L_8c3f56:
	mov_s r15,r1
L_8c3f58:
	mov_s r14,r2
L_8c3f5a:
	breq_s r0,0,L_8c3f7c
L_8c3f5c:
	mov_s r2,0x1013f10
L_8c3f62:
	mov_s r0,0xc
L_8c3f64:
	bl.d L_8edfb0
L_8c3f68:
	mov_s r1,0x2
L_8c3f6a:
	add r0,r13,0x1c
L_8c3f6e:
	mov_s r1,0x5
L_8c3f70:
	mov_s r2,r15
L_8c3f72:
	mov_s r3,r14
L_8c3f74:
	bl.d L_8d6a1c
L_8c3f78:
	mov r4,0x0
	.global L_8c3f7c
L_8c3f7c:
	b L_8c032c
