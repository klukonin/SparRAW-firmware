/* wmi_deep_echo @ 0x8c87a4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_deep_echo
wmi_deep_echo:
	.global L_8c87a4
L_8c87a4:
	push_s blink
L_8c87a6:
	push_s r13
L_8c87a8:
	bl.d L_8c3284
L_8c87ac:
	mov_s r13,r1
L_8c87ae:
	st_s r13,[r0]
L_8c87b0:
	mov_s r1,0x2
L_8c87b2:
	mov_s r2,0x4
L_8c87b4:
	bl.d L_8e5204
L_8c87b8:
	mov_s r3,0x0
L_8c87ba:
	b L_8c025c
L_8c87be:
	nop_s
