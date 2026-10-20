/* temp_measure_step @ 0x8ddda8, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__no_rf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, marlon_r_if__write_reg, tail_hwd_rfc_read_rgf
 */
	.section .text.temp_measure_step,"ax",@progbits
	.global temp_measure_step
temp_measure_step:
	.global L_8ddda8
L_8ddda8:
	push_s blink
L_8dddaa:
	bl.d L_8c02c0
L_8dddae:
	mov r2,0x34c
L_8dddb2:
	mov_s r13,r0
L_8dddb4:
	ldb_s r1,[r0]
L_8dddb6:
	mov_s r15,0x0
L_8dddb8:
	bl.d L_8e7f60
L_8dddbc:
	mov_s r3,0xf
L_8dddbe:
	ldb_s r1,[r13]
L_8dddc0:
	mov_s r0,r13
L_8dddc2:
	bl.d L_8ddd74
L_8dddc6:
	mov r2,0x440
L_8dddca:
	bmsk r3,r0,0x1
L_8dddce:
	mov_s r0,r13
L_8dddd0:
	ldb_s r1,[r13]
L_8dddd2:
	mov r2,0x440
L_8dddd6:
	bl.d L_8e7f60
L_8dddda:
	or r3,r3,0x28
L_8dddde:
	mov_s r0,r13
L_8ddde0:
	ldb_s r1,[r13]
L_8ddde2:
	mov r2,0x444
L_8ddde6:
	mov_s r3,0x10
L_8ddde8:
	bl.d L_8e7f60
L_8dddec:
	bset_s r3,r3,0xc
L_8dddee:
	mov_s r14,0x1
L_8dddf0:
	st_s r15,[r13,0x4]
L_8dddf2:
	mov_s r0,r13
L_8dddf4:
	ldb_s r1,[r13]
L_8dddf6:
	mov r2,0x45c
L_8dddfa:
	bl.d L_8e7f60
L_8dddfe:
	mov_s r3,r14
L_8dde00:
	st_s r14,[r13,0x4]
L_8dde02:
	mov_s r0,r13
L_8dde04:
	ldb_s r1,[r13]
L_8dde06:
	mov r2,0x454
L_8dde0a:
	bl.d L_8e7f60
L_8dde0e:
	mov_s r3,0x10
L_8dde10:
	st_s r15,[r13,0x4]
L_8dde12:
	mov_s r0,r13
L_8dde14:
	ldb_s r1,[r13]
L_8dde16:
	mov r2,0x44c
L_8dde1a:
	bl.d L_8e7f60
L_8dde1e:
	mov_s r3,r14
L_8dde20:
	st_s r14,[r13,0x4]
L_8dde22:
	mov r0,0x320
L_8dde26:
	mov lp_count,r0
L_8dde2a:
	nop_s
L_8dde2c:
	lp L_8dde34
L_8dde30:
	nop_s
L_8dde32:
	nop_s
	.global L_8dde34
L_8dde34:
	ldb_s r1,[r13]
L_8dde36:
	mov_s r0,r13
L_8dde38:
	bl.d L_8ddd74
L_8dde3c:
	mov r2,0x458
L_8dde40:
	/* mulu64 r0,0x1388 */
	.byte 0x05,0x28,0x80,0x0f,0x00,0x00,0x88,0x13
L_8dde48:
	lsr r0,mlo,0x5
L_8dde4c:
	sub r0,r0,0x7530
L_8dde54:
	b L_8c032c
