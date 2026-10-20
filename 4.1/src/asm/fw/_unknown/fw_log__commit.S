/* fw_log__commit @ 0x8ee134, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_log__emit0, fw_log__emit1, fw_log__emit1_nonl, fw_log__emit2, fw_log__emit2_nonl, fw_log__emit3, fw_log__emit3_nonl
 */
	.section .text.fw_log__commit,"ax",@progbits
	.global fw_log__commit
fw_log__commit:
	.global L_8ee134
L_8ee134:
	push_s r13
L_8ee136:
	asl_s r0,r0,0x14
L_8ee138:
	asl_s r1,r1,0x18
L_8ee13a:
	or_s r0,r0,r1
L_8ee13c:
	asl r1,r3,0x1a
L_8ee140:
	or_s r1,r1,r0
L_8ee142:
	bmsk_s r2,r2,0x13
L_8ee144:
	or_s r1,r1,r2
L_8ee146:
	asl r13,r4,0x1c
L_8ee14a:
	or_s r1,r1,r13
L_8ee14c:
	bset_s r1,r1,0x1d
L_8ee14e:
	mov_s r13,0x843900
L_8ee154:
	ld_s r0,[r13]
L_8ee156:
	bset_s r1,r1,0x1f
L_8ee158:
	bmsk r2,r0,0x9
L_8ee15c:
	add2 r2,r13,r2
L_8ee160:
	st_s r1,[r2,0x14]
L_8ee162:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8ee164:
	add_s r0,r0,r3
L_8ee166:
	st_s r0,[r13]
L_8ee168:
	j_s.d [blink]
L_8ee16a:
	pop_s r13
