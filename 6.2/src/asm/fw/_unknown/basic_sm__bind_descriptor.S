/* basic_sm__bind_descriptor @ 0x8d94e0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__sm_init, disc_flush_sm__init, field_set_0x08__8d8eb4, ftm_state_sm__init, obj_vt801bec__ctor, obj_vt801c30__ctor, obj_vt801d64__ctor, obj_vt801eac__ctor, obj_vt801f08__ctor, obj_vt802458__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global basic_sm__bind_descriptor
basic_sm__bind_descriptor:
	.global L_8d94e0
L_8d94e0:
	ldb_s r2,[r1,0x2]
L_8d94e2:
	st_s r1,[r0,0x4]
L_8d94e4:
	stb_s r2,[r0]
L_8d94e6:
	mov_s r1,0xff
L_8d94e8:
	stb_s r1,[r0,0x2]
L_8d94ea:
	mov_s r1,0x0
L_8d94ec:
	j_s.d [blink]
L_8d94ee:
	stb_s r1,[r0,0x3]
