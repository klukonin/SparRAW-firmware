/* hw__power_step @ 0x929eec, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__power_sequence_rf
 * Зовёт сам: hwd_rfc_write_core, rfca__select_rf_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hw__power_step
hw__power_step:
	.global L_929eec
L_929eec:
	st.a r13,[sp,-0xc]
L_929ef0:
	st blink,[sp, 0x4]
L_929ef4:
	st_s r14,[sp,0x8]
L_929ef6:
	mov_s r14,r0
L_929ef8:
	mov r13,0x0
L_929efc:
	stb.a r13,[sp,-0x4]
L_929f00:
	bl.d L_928b8c
L_929f04:
	mov r1,sp
L_929f08:
	mov_s r0,r13
L_929f0a:
	mov_s r1,0x1
L_929f0c:
	mov r2,r13
L_929f10:
	bl.d L_92a3d8
L_929f14:
	mov r3,r13
L_929f18:
	ldb_s r0,[sp,0x0]
L_929f1a:
	cmp_s r14,r0
L_929f1c:
	bl.ne.d L_928b8c
L_929f20:
	mov.ne r1,r13
L_929f24:
	add_s sp,sp,0x4
L_929f26:
	ld blink,[sp, 0x4]
L_929f2a:
	ld_s r14,[sp,0x8]
L_929f2c:
	j.d [blink]
L_929f30:
	ld.ab r13,[sp,0xc]
