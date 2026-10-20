/* rf_utils__fill_step @ 0x929f34, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_utils_auto_fill_uc
 * Зовёт сам: hwd_rfc_write_core, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf_utils__fill_step
rf_utils__fill_step:
	.global L_929f34
L_929f34:
	st.a r13,[sp,-0x18]
L_929f38:
	st blink,[sp, 0x4]
L_929f3c:
	st_s r14,[sp,0x8]
L_929f3e:
	st_s r15,[sp,0xc]
L_929f40:
	st r16,[sp, 0x10]
L_929f44:
	st r17,[sp, 0x14]
L_929f48:
	mov_s r14,r0
L_929f4a:
	mov_s r15,r1
L_929f4c:
	mov_s r16,r2
L_929f4e:
	mov_s r17,r3
L_929f50:
	mov r13,0x0
L_929f54:
	stb.a r13,[sp,-0x4]
L_929f58:
	bl.d L_928b8c
L_929f5c:
	mov r1,sp
L_929f60:
	mov_s r0,r13
L_929f62:
	mov_s r1,r17
L_929f64:
	mov r2,r15
L_929f68:
	bl.d L_92a3d8
L_929f6c:
	mov r3,r16
L_929f70:
	ldb_s r0,[sp,0x0]
L_929f72:
	cmp_s r14,r0
L_929f74:
	bl.ne.d L_928b8c
L_929f78:
	mov.ne r1,r13
L_929f7c:
	add_s sp,sp,0x4
L_929f7e:
	ld blink,[sp, 0x4]
L_929f82:
	ld_s r14,[sp,0x8]
L_929f84:
	ld_s r15,[sp,0xc]
L_929f86:
	ld r16,[sp, 0x10]
L_929f8a:
	ld r17,[sp, 0x14]
L_929f8e:
	j_s.d [blink]
L_929f90:
	ld.ab r13,[sp,0x18]
