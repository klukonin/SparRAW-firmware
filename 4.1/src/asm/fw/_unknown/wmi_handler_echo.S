/* wmi_handler_echo @ 0x8e0844, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event
 */
	.section .text.wmi_handler_echo,"ax",@progbits
	.global wmi_handler_echo
wmi_handler_echo:
	.global L_8e0844
L_8e0844:
	push_s blink
L_8e0846:
	bl L_8c02c0
L_8e084a:
	mov_s r14,r0
L_8e084c:
	mov_s r13,r1
L_8e084e:
	bl.d L_8c2c38
L_8e0852:
	mov_s r15,r2
L_8e0854:
	mov_s r1,r0
L_8e0856:
	st_s r13,[r0]
L_8e0858:
	mov_s r0,r14
L_8e085a:
	mov_s r2,0x0
L_8e085c:
	mov_s r3,0x1803
L_8e0862:
	mov r4,0x4
L_8e0866:
	mov_s r5,r15
L_8e0868:
	mov_s r6,r2
L_8e086a:
	bl.d L_8e0460
L_8e086e:
	mov_s r7,r2
L_8e0870:
	b L_8c032c
