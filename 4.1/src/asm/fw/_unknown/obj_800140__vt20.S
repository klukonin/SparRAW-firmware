/* obj_800140__vt20 @ 0x8c9fb4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, lmac_if__ucode_event_dispatch
 */
	.section .text.obj_800140__vt20,"ax",@progbits
	.global obj_800140__vt20
obj_800140__vt20:
	.global L_8c9fb4
L_8c9fb4:
	ld_s r0,[gp,-0x30]
L_8c9fb6:
	ld_s r1,[r0]
L_8c9fb8:
	ld_s r1,[r1,0x20]
L_8c9fba:
	j_s [r1]
