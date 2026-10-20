/* calib_mngr__log_scheme @ 0x8c4ae8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mngr.cpp
 * Зовёт сам: __ld_r13_ret, calib_cfg__get_scheme, calib_mngr__schedule_scheme_step, fw_sysassert_fatal
 * Глобалы (через gp): 0x80023b
 */
	.section .text.calib_mngr__log_scheme,"ax",@progbits
	.global calib_mngr__log_scheme
calib_mngr__log_scheme:
L_8c4ae8:
	j_s [blink]
	.global sub_8c4aea
sub_8c4aea:
L_8c4aea:
	nop_s
L_8c4aec:
	push_s blink
L_8c4aee:
	push_s r13
L_8c4af0:
	brhs.d r0,0x6,L_8c4b1e
L_8c4af4:
	mov_s r13,r0
	.global L_8c4af6
L_8c4af6:
	mov_s r0,0x842840
L_8c4afc:
	ldb_s r0,[r0,r13]
L_8c4afe:
	breq_s r0,0,L_8c4b1a
L_8c4b00:
	ldb_s r0,[gp,0xcb]
L_8c4b02:
	bl.d L_8ca4a4
L_8c4b06:
	ld.as r1,[gp,-0x2]
L_8c4b0a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c4b0c:
	asl_s r1,r13,0x2
L_8c4b0e:
	add1_s r1,r1,r1
L_8c4b10:
	add_s r1,r1,r0
L_8c4b12:
	mov_s r0,r13
L_8c4b14:
	bl.d L_8dfcd4
L_8c4b18:
	mov_s r2,0x0
	.global L_8c4b1a
L_8c4b1a:
	b L_8c033c
	.global L_8c4b1e
L_8c4b1e:
	mov_s r0,blink
L_8c4b20:
	mov_s r2,0x10085d4
L_8c4b26:
	mov_s r1,0x95
L_8c4b28:
	bset_s r1,r1,0xc
L_8c4b2a:
	bl.d L_8c82c0
L_8c4b2e:
	mov r3,0x1a4
L_8c4b32:
	b_s L_8c4af6
