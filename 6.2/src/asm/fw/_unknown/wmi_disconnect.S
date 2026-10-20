/* wmi_disconnect @ 0x8ec4ec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: conn_main_sm__action_8c9050
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_disconnect
wmi_disconnect:
	.global L_8ec4ec
L_8ec4ec:
	mov_s r1,0x2
L_8ec4ee:
	b.d L_8c909c
L_8ec4f2:
	mov_s r2,0x3
