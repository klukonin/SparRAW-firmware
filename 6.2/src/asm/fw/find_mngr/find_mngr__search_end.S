/* find_mngr__search_end @ 0x8e4c8c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: state_sm_8030f4__action_8f9994
 * Зовёт сам: l2mgr__send_search_started
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mngr__search_end
find_mngr__search_end:
	.global L_8e4c8c
L_8e4c8c:
	push_s blink
L_8e4c8e:
	ld_s r1,[r0,0xc]
L_8e4c90:
	brne_s r1,0,L_8e4c9c
L_8e4c92:
	ld_s r1,[r0,0x48]
L_8e4c94:
	mov_s r0,0x0
L_8e4c96:
	bl.d L_8f8d74
L_8e4c9a:
	ldb_s r1,[r1,0x10]
	.global L_8e4c9c
L_8e4c9c:
	pop_s blink
L_8e4c9e:
	j_s [blink]
