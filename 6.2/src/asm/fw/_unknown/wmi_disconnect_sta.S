/* wmi_disconnect_sta @ 0x8ec4f4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__disconnect_sta
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_disconnect_sta
wmi_disconnect_sta:
	.global L_8ec4f4
L_8ec4f4:
	mov_s r2,r0
L_8ec4f6:
	mov_s r0,r1
L_8ec4f8:
	mov_s r1,r2
L_8ec4fa:
	b.d L_8c93a0
L_8ec4fe:
	ldw_s r2,[r2,0x6]
