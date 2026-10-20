/* lmac_if__build_cmd_0x01 @ 0x8d89f0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x01
 * Зовёт сам: __ld_r13_ret, lmac_if__fill_cmd_hdr
 */
	.section .text.lmac_if__build_cmd_0x01,"ax",@progbits
	.global lmac_if__build_cmd_0x01
lmac_if__build_cmd_0x01:
	.global L_8d89f0
L_8d89f0:
	sub_s sp,sp,0x8
L_8d89f2:
	push_s blink
L_8d89f4:
	push_s r13
L_8d89f6:
	mov_s r7,r1
L_8d89f8:
	mov_s r6,r2
L_8d89fa:
	mov_s r13,r0
L_8d89fc:
	asl r1,r3,0xa
L_8d8a00:
	mov_s r2,r7
L_8d8a02:
	bl.d L_8d8cf8
L_8d8a06:
	mov_s r3,r6
L_8d8a08:
	mov_s r0,0x1
L_8d8a0a:
	st_s r0,[r13,0x20]
L_8d8a0c:
	mov_s r12,0xc
L_8d8a0e:
	b L_8c033e
L_8d8a12:
	nop_s
