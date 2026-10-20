/* sta__set_rx_sector @ 0x93d140, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure, set_selected_rf_sector_index_cmd_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta__set_rx_sector
sta__set_rx_sector:
	.global L_93d140
L_93d140:
	push_s r13
L_93d142:
	mov_s r3,0x8021b8
L_93d148:
	ld_s r13,[r3,0x18]
L_93d14a:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93d14c:
	add2_s r0,r0,r0
L_93d14e:
	add_s r0,r0,0x801104
L_93d154:
	ld.as r2,[gp,-0x3]
L_93d158:
	bset_s r2,r2,0x5
L_93d15a:
	breq_s r13,0,L_93d168
L_93d15c:
	ldb_s r13,[r3,0x1c]
L_93d15e:
	asl r1,r13,0x8
L_93d162:
	or_s r1,r1,r2
L_93d164:
	st_s r1,[r0,0x4]
L_93d166:
	b_s L_93d174
	.global L_93d168
L_93d168:
	asl r13,r1,0x8
L_93d16c:
	or_s r13,r13,r2
L_93d16e:
	st_s r13,[r0,0x4]
L_93d170:
	extb_s r13,r1
L_93d172:
	stb_s r1,[r3,0x1c]
	.global L_93d174
L_93d174:
	mov_s r0,0x802110
L_93d17a:
	stb_s r13,[r0,0x1]
L_93d17c:
	j_s.d [blink]
L_93d17e:
	pop_s r13
