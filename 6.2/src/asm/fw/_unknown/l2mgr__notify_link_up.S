/* l2mgr__notify_link_up @ 0x8cd76c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__notify_link_via_l2mgr
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_sm__on_link_up, scan_mngr__handle_link_up_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__notify_link_up
l2mgr__notify_link_up:
	.global L_8cd76c
L_8cd76c:
	push_s blink
L_8cd76e:
	bl L_8c01e0
L_8cd772:
	mov_s r14,r0
L_8cd774:
	mov_s r15,r1
L_8cd776:
	mov_s r13,r2
L_8cd778:
	bl.d L_8cd790
L_8cd77c:
	ld_s r0,[r0,0x8]
L_8cd77e:
	add r0,r14,0xc
L_8cd782:
	mov_s r1,r15
L_8cd784:
	bl.d L_8c48c4
L_8cd788:
	mov_s r2,r13
L_8cd78a:
	b L_8c024c
L_8cd78e:
	nop_s
