/* new_link_evt @ 0x8cc158, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, lmac_if__ucode_event_dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global new_link_evt
new_link_evt:
	.global L_8cc158
L_8cc158:
	ld_s r0,[gp,-0x40]
L_8cc15a:
	ld_s r1,[r0]
L_8cc15c:
	ld_s r1,[r1,0x20]
L_8cc15e:
	j_s [r1]
