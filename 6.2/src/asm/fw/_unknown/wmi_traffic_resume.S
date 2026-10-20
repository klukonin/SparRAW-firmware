/* wmi_traffic_resume @ 0x8ecf48, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__send_traffic_resume_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_traffic_resume
wmi_traffic_resume:
	.global L_8ecf48
L_8ecf48:
	mov_s r0,0x803d10
L_8ecf4e:
	b L_8e055c
L_8ecf52:
	nop_s
