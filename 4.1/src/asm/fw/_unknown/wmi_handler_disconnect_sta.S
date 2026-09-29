/* wmi_handler_disconnect_sta @ 0x8e77ec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: l2mgr__disconnect_sta
 */
	.section .text.wmi_handler_disconnect_sta,"ax",@progbits
	.global wmi_handler_disconnect_sta
wmi_handler_disconnect_sta:
	.global L_8e77ec
L_8e77ec:
	mov_s r2,r0
L_8e77ee:
	mov_s r0,r1
L_8e77f0:
	mov_s r1,r2
L_8e77f2:
	b.d L_8eb494
L_8e77f6:
	ldw_s r2,[r2,0x6]
