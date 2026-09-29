/* sta_rec__unpack_5bit_caps @ 0x8e70c4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set16_s7_w5, bits__set8_s2_w5, sta_rec__bits_set16_s5_w5, sta_rec__bits_set8_s0_w5
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_rec__unpack_5bit_caps
sta_rec__unpack_5bit_caps:
	.global L_8e70c4
L_8e70c4:
	push_s blink
L_8e70c6:
	push_s r13
L_8e70c8:
	mov_s r13,r1
L_8e70ca:
	ldb_s r1,[r1]
L_8e70cc:
	mov_s r3,r0
L_8e70ce:
	bmsk_s r1,r1,0x4
L_8e70d0:
	add3 r2,r0,0x2c
L_8e70d4:
	add r0,r2,0x1b
L_8e70d8:
	bl L_8ed244
L_8e70dc:
	ldb_s r1,[r13,0x1]
L_8e70de:
	add r0,r2,0x1c
L_8e70e2:
	lsr_s r1,r1,0x2
L_8e70e4:
	bmsk_s r1,r1,0x4
L_8e70e6:
	bl L_8ed274
L_8e70ea:
	ldb_s r0,[r13,0x1]
L_8e70ec:
	ldb_s r1,[r13]
L_8e70ee:
	asl_s r0,r0,0x8
L_8e70f0:
	or_s r1,r1,r0
L_8e70f2:
	lsr_s r1,r1,0x5
L_8e70f4:
	bmsk_s r1,r1,0x4
L_8e70f6:
	mov_s r0,r3
L_8e70f8:
	add r0,r0,0x17b
L_8e70fc:
	bl L_8ed1b4
L_8e7100:
	ldb_s r0,[r13,0x2]
L_8e7102:
	ldb_s r1,[r13,0x1]
L_8e7104:
	asl_s r0,r0,0x8
L_8e7106:
	or_s r1,r1,r0
L_8e7108:
	lsr_s r1,r1,0x7
L_8e710a:
	bmsk_s r1,r1,0x4
L_8e710c:
	mov_s r0,r3
L_8e710e:
	add r0,r0,0x17c
L_8e7112:
	bl L_8ed1fc
L_8e7116:
	ldb_s r0,[r13,0x2]
L_8e7118:
	lsr_s r0,r0,0x5
L_8e711a:
	bmsk_s r0,r0,0x0
L_8e711c:
	asl_s r1,r0,0x5
L_8e711e:
	ldb_s r0,[r2,0x1d]
L_8e7120:
	bclr_s r0,r0,0x5
L_8e7122:
	or_s r1,r1,r0
L_8e7124:
	stb_s r1,[r2,0x1d]
L_8e7126:
	ldb_s r0,[r13,0x2]
L_8e7128:
	bclr_s r1,r1,0x4
L_8e712a:
	lsr_s r0,r0,0x4
L_8e712c:
	bmsk_s r0,r0,0x0
L_8e712e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e7130:
	or_s r0,r0,r1
L_8e7132:
	b.d L_8c025c
L_8e7136:
	stb_s r0,[r2,0x1d]
