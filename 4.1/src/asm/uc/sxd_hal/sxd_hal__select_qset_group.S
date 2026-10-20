/* sxd_hal__select_qset_group @ 0x924fe8, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal.c
 * Зовут его: sxd_hal__write_qset_field
 * Зовёт сам: uc_sysassert
 */
	.section .text.sxd_hal__select_qset_group,"ax",@progbits
	.global sxd_hal__select_qset_group
sxd_hal__select_qset_group:
	.global L_924fe8
L_924fe8:
	st.a r13,[sp,-0xc]
L_924fec:
	st blink,[sp, 0x4]
L_924ff0:
	st_s r14,[sp,0x8]
L_924ff2:
	mov_s r13,r0
L_924ff4:
	mov_s r14,0x0
L_924ff6:
	asl_s r0,r0,0x14
L_924ff8:
	and r0,r0,0xf00000
L_925000:
	or r0,r0,0x68000000
L_925008:
	mov r32,r0
L_92500c:
	st.ab r0,[r25,0x4]
L_925010:
	bclr r25,r25,0xa
L_925014:
	brhs r13,0x3,L_925034
L_925018:
	mov_s r14,0x49008000
L_92501e:
	mov_s r32,r14
L_925020:
	st.ab r14,[r25,0x4]
L_925024:
	bclr r25,r25,0xa
L_925028:
	ld blink,[sp, 0x4]
L_92502c:
	ld_s r14,[sp,0x8]
L_92502e:
	j_s.d [blink]
L_925030:
	ld.ab r13,[sp,0xc]
	.global L_925034
L_925034:
	brhs r13,0x6,L_925054
L_925038:
	mov_s r14,0x49010000
L_92503e:
	mov_s r32,r14
L_925040:
	st.ab r14,[r25,0x4]
L_925044:
	bclr r25,r25,0xa
L_925048:
	ld blink,[sp, 0x4]
L_92504c:
	ld_s r14,[sp,0x8]
L_92504e:
	j_s.d [blink]
L_925050:
	ld.ab r13,[sp,0xc]
	.global L_925054
L_925054:
	brhs r13,0xa,L_925074
L_925058:
	mov_s r14,0x49020000
L_92505e:
	mov_s r32,r14
L_925060:
	st.ab r14,[r25,0x4]
L_925064:
	bclr r25,r25,0xa
L_925068:
	ld blink,[sp, 0x4]
L_92506c:
	ld_s r14,[sp,0x8]
L_92506e:
	j_s.d [blink]
L_925070:
	ld.ab r13,[sp,0xc]
	.global L_925074
L_925074:
	mov_s r0,blink
L_925076:
	mov_s r2,0x1000d80
L_92507c:
	mov r1,0x69
L_925080:
	bl.d L_925548
L_925084:
	mov r3,0x132
L_925088:
	or r14,r14,0x49000000
L_925090:
	mov r32,r14
L_925094:
	st.ab r14,[r25,0x4]
L_925098:
	bclr r25,r25,0xa
L_92509c:
	ld blink,[sp, 0x4]
L_9250a0:
	ld_s r14,[sp,0x8]
L_9250a2:
	j_s.d [blink]
L_9250a4:
	ld.ab r13,[sp,0xc]
