/* rm_req__get_next @ 0x8cc65c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__get_next_prim_request, rm_main_sm__get_next_request, rm_main_sm__secondary_handle_free
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_req__get_next
rm_req__get_next:
	.global L_8cc65c
L_8cc65c:
	j_s.d [blink]
L_8cc65e:
	ld_s r0,[r0,0x4]
