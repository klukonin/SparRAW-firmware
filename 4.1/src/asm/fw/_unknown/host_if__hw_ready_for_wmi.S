/* host_if__hw_ready_for_wmi @ 0x8d74d8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: get_reg_880a3c_8d7540, rf__is_present, rw_g_8043d4
 */
	.section .text.host_if__hw_ready_for_wmi,"ax",@progbits
	.global host_if__hw_ready_for_wmi
host_if__hw_ready_for_wmi:
	.global L_8d74d8
L_8d74d8:
	push_s blink
L_8d74da:
	bl L_8d7540
L_8d74de:
	breq_s r0,0,L_8d74f0
L_8d74e0:
	bl L_8d750c
L_8d74e4:
	breq_s r0,0,L_8d74ec
L_8d74e6:
	bl L_8ca800
L_8d74ea:
	breq_s r0,0,L_8d74f0
	.global L_8d74ec
L_8d74ec:
	mov_s r0,0x0
L_8d74ee:
	b_s L_8d74f2
	.global L_8d74f0
L_8d74f0:
	mov_s r0,0x1
	.global L_8d74f2
L_8d74f2:
	pop_s blink
L_8d74f4:
	j_s [blink]
L_8d74f6:
	nop_s
