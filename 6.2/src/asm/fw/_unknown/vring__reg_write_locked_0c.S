/* vring__reg_write_locked_0c @ 0x8d04d8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reg_write_locked_0c
vring__reg_write_locked_0c:
	.global L_8d04d8
L_8d04d8:
	push_s blink
L_8d04da:
	push_s r13
L_8d04dc:
	lr r13,[0xa]
L_8d04e0:
	bclr r2,r13,0x1
L_8d04e4:
	flag r2
L_8d04e8:
	mov_s r2,0x881c00
L_8d04ee:
	st_s r0,[r2,0xc]
L_8d04f0:
	breq_s r1,0,L_8d04f6
L_8d04f2:
	sync
	.global L_8d04f6
L_8d04f6:
	lr r0,[0xa]
L_8d04fa:
	bic r13,r13,-0x3
L_8d04fe:
	or_s r13,r13,r0
L_8d0500:
	flag r13
L_8d0504:
	b L_8c025c
