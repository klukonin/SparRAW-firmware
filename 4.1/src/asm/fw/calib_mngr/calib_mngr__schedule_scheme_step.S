/* calib_mngr__schedule_scheme_step @ 0x8dfcd4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mngr.cpp
 * Зовут его: calib_engine__schedule_all_schemes, calib_mngr__log_scheme, calib_mngr__reset_scheme
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x80021f, 0x800364
 */
	.section .text.calib_mngr__schedule_scheme_step,"ax",@progbits
	.global calib_mngr__schedule_scheme_step
calib_mngr__schedule_scheme_step:
	.global L_8dfcd4
L_8dfcd4:
	push_s blink
L_8dfcd6:
	bl L_8c02bc
L_8dfcda:
	mov_s r13,r0
L_8dfcdc:
	mov_s r15,r1
L_8dfcde:
	brhs.d r0,0x6,L_8dfd2c
L_8dfce2:
	mov_s r16,r2
	.global L_8dfce4
L_8dfce4:
	ld_s r0,[r15]
L_8dfce6:
	mov_s r1,0x842840
L_8dfcec:
	add2 r14,r1,r13
L_8dfcf0:
	bbit0 r0,0x0,L_8dfd44
L_8dfcf4:
	ldw_s r2,[r15,0x8]
L_8dfcf6:
	breq_s r2,0,L_8dfd44
L_8dfcf8:
	ld_s r0,[r14,0x8]
L_8dfcfa:
	brne_s r0,0,L_8dfd48
L_8dfcfc:
	mul64 r2,0x3e8
L_8dfd00:
	mov r4,mlo
L_8dfd04:
	breq r16,0x0,L_8dfd10
L_8dfd08:
	ldb_s r0,[gp,0xaf]
L_8dfd0a:
	breq_s r0,0,L_8dfd10
L_8dfd0c:
	ld.as r4,[gp,0x7d]
	.global L_8dfd10
L_8dfd10:
	mov_s r0,0x1
L_8dfd12:
	add_s r1,r1,r13
L_8dfd14:
	stb_s r0,[r1]
L_8dfd16:
	mov_s r0,0x4b34
L_8dfd1c:
	mov_s r1,r13
L_8dfd1e:
	mov_s r2,0x0
L_8dfd20:
	mov_s r3,r2
L_8dfd22:
	mov_s r5,r2
L_8dfd24:
	bl.d L_8dc92c
L_8dfd28:
	mov_s r6,r2
L_8dfd2a:
	b_s L_8dfd46
	.global L_8dfd2c
L_8dfd2c:
	mov_s r0,blink
L_8dfd2e:
	mov_s r2,0x10085d4
L_8dfd34:
	mov_s r1,0x120a
L_8dfd3a:
	bl.d L_8c82c0
L_8dfd3e:
	mov r3,0x16c
L_8dfd42:
	b_s L_8dfce4
	.global L_8dfd44
L_8dfd44:
	mov_s r0,0x0
	.global L_8dfd46
L_8dfd46:
	st_s r0,[r14,0x8]
	.global L_8dfd48
L_8dfd48:
	b L_8c0324
