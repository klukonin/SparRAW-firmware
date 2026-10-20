/* lmac_if__fill_cmd_hdr @ 0x8d8cf8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__build_cmd_0x01
 */
	.section .text.lmac_if__fill_cmd_hdr,"ax",@progbits
	.global lmac_if__fill_cmd_hdr
lmac_if__fill_cmd_hdr:
	.global L_8d8cf8
L_8d8cf8:
	sub_s sp,sp,0x8
L_8d8cfa:
	push_s r13
L_8d8cfc:
	st_s r2,[r0]
L_8d8cfe:
	st_s r3,[r0,0x4]
L_8d8d00:
	ld_s r2,[r0,0x10]
L_8d8d02:
	bmsk r3,r5,0x0
L_8d8d06:
	bclr_s r2,r2,0x0
L_8d8d08:
	or_s r2,r2,r3
L_8d8d0a:
	st_s r2,[r0,0x10]
L_8d8d0c:
	st_s r1,[r0,0x18]
L_8d8d0e:
	ld_s r1,[r0,0x1c]
L_8d8d10:
	bmsk r13,r4,0x0
L_8d8d14:
	bclr_s r1,r1,0x0
L_8d8d16:
	or r2,r13,r1
L_8d8d1a:
	asl_s r1,r13
L_8d8d1c:
	bclr_s r2,r2,0x1
L_8d8d1e:
	or_s r1,r1,r2
L_8d8d20:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8d8d22:
	bclr_s r1,r1,0x2
L_8d8d24:
	or_s r13,r13,r1
L_8d8d26:
	st_s r13,[r0,0x1c]
L_8d8d28:
	pop_s r13
L_8d8d2a:
	j_s.d [blink]
L_8d8d2c:
	add_s sp,sp,0x8
L_8d8d2e:
	nop_s
