/* bi_build_schedule_tables @ 0x927f00, 408 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode__build_schedule
 * Зовёт сам: memset0_words_uc, softfloat_df_add, softfloat_df_mul, softfloat_double_to_short, softfloat_int_to_double
 */
	.section .text.bi_build_schedule_tables,"ax",@progbits
	.global bi_build_schedule_tables
bi_build_schedule_tables:
	.global L_927f00
L_927f00:
	st.a r13,[sp,-0x34]
L_927f04:
	st blink,[sp, 0x4]
L_927f08:
	st_s r14,[sp,0x8]
L_927f0a:
	st_s r15,[sp,0xc]
L_927f0c:
	st r16,[sp, 0x10]
L_927f10:
	st r17,[sp, 0x14]
L_927f14:
	st r18,[sp, 0x18]
L_927f18:
	st r19,[sp, 0x1c]
L_927f1c:
	st r20,[sp, 0x20]
L_927f20:
	st r21,[sp, 0x24]
L_927f24:
	st r22,[sp, 0x28]
L_927f28:
	st r23,[sp, 0x2c]
L_927f2c:
	st r24,[sp, 0x30]
L_927f30:
	mov r0,0x801e68
L_927f38:
	bl.d L_92166c
L_927f3c:
	mov r1,0x18
L_927f40:
	mov_s r1,0x54
L_927f42:
	asl_s r1,r1,0x18
L_927f44:
	mov r32,r1
L_927f48:
	st.ab r1,[r25,0x4]
L_927f4c:
	bclr r25,r25,0xa
L_927f50:
	mov_s r2,0x54
L_927f52:
	asl_s r2,r2,0x18
L_927f54:
	mov r32,r2
L_927f58:
	st.ab r2,[r25,0x4]
L_927f5c:
	bclr r25,r25,0xa
L_927f60:
	mov_s r3,0x49000100
L_927f66:
	mov_s r32,r3
L_927f68:
	st.ab r3,[r25,0x4]
L_927f6c:
	bclr r25,r25,0xa
L_927f70:
	mov r4,0x51000284
L_927f78:
	mov r32,r4
L_927f7c:
	st.ab r4,[r25,0x4]
L_927f80:
	bclr r25,r25,0xa
L_927f84:
	mov r5,0x54000508
L_927f8c:
	mov r32,r5
L_927f90:
	st.ab r5,[r25,0x4]
L_927f94:
	bclr r25,r25,0xa
L_927f98:
	mov r17,0x4
L_927f9c:
	mov r23,0x99b
L_927fa4:
	mov r14,0x802038
L_927fac:
	mov r24,0x5cd
L_927fb0:
	mov r16,0x266c
L_927fb8:
	mov r15,0x294
L_927fbc:
	b.d L_927fc8
L_927fc0:
	mov r13,0xc
	.global L_927fc4
L_927fc4:
	mov r14,r22
	.global L_927fc8
L_927fc8:
	mov r19,r17
L_927fcc:
	add r16,r16,r23
L_927fd0:
	add r18,r15,r16
L_927fd4:
	extw r18,r18
L_927fd8:
	stw r18,[r14, 0x10]
L_927fdc:
	add r17,r17,0x1
L_927fe0:
	mov_s r0,0xa5
L_927fe2:
	add_s r15,r15,r0
L_927fe4:
	bl.d L_920464
L_927fe8:
	mov r0,r17
L_927fec:
	mov_s r2,0xcccccccd
L_927ff2:
	mov_s r3,0x402dcccc
L_927ff8:
	bl.d L_9204ac
L_927ffc:
	add r22,r14,0x2
L_928000:
	mov_s r21,r0
L_928002:
	mov_s r20,r1
L_928004:
	bl.d L_920464
L_928008:
	mov r0,r19
L_92800c:
	mov r2,r21
L_928010:
	bl.d L_920974
L_928014:
	mov r3,r20
L_928018:
	mov_s r2,0xcccccccd
L_92801e:
	mov_s r3,0x3feccccc
L_928024:
	bl.d L_920974
L_928028:
	sub r13,r13,0x1
L_92802c:
	bl L_9210e4
L_928030:
	stw r0,[r14, -0x8]
L_928034:
	bl.d L_920464
L_928038:
	add r0,r18,r24
L_92803c:
	mov r3,0x40a78680
L_928044:
	bl.d L_920974
L_928048:
	mov r2,0x0
L_92804c:
	mov r3,0x40973400
L_928054:
	bl.d L_920974
L_928058:
	mov r2,0x0
L_92805c:
	bl L_9210e4
L_928060:
	brhs.d r13,0x1,L_927fc4
L_928064:
	stw_s r0,[r14,0x28]
L_928066:
	ld blink,[sp, 0x4]
L_92806a:
	ld_s r14,[sp,0x8]
L_92806c:
	ld_s r15,[sp,0xc]
L_92806e:
	ld r16,[sp, 0x10]
L_928072:
	ld r17,[sp, 0x14]
L_928076:
	ld r18,[sp, 0x18]
L_92807a:
	ld r19,[sp, 0x1c]
L_92807e:
	ld r20,[sp, 0x20]
L_928082:
	ld r21,[sp, 0x24]
L_928086:
	ld r22,[sp, 0x28]
L_92808a:
	ld r23,[sp, 0x2c]
L_92808e:
	ld r24,[sp, 0x30]
L_928092:
	j_s.d [blink]
L_928094:
	ld.ab r13,[sp,0x34]
