/* rfc__read_core_result @ 0x92a2a4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_powerup_deep_all_rfs
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__read_core_result
rfc__read_core_result:
	.global L_92a2a4
L_92a2a4:
	st.a r13,[sp,-0x10]
L_92a2a8:
	st blink,[sp, 0x4]
L_92a2ac:
	st_s r14,[sp,0x8]
L_92a2ae:
	st_s r15,[sp,0xc]
L_92a2b0:
	mov_s r3,r1
L_92a2b2:
	mov r8,0x0
L_92a2b6:
	st r8,[r2]
L_92a2ba:
	mov_s r13,0x889000
L_92a2c0:
	ld.as r5,[r13,0x46]
L_92a2c4:
	mov_s r15,0xdeadbeef
L_92a2ca:
	bset r5,r5,0x6
L_92a2ce:
	st.as r5,[r13,0x46]
L_92a2d2:
	ld.as r4,[r13,0x46]
L_92a2d6:
	mov_s r14,r2
L_92a2d8:
	bclr r4,r4,0x6
L_92a2dc:
	st.as r4,[r13,0x46]
L_92a2e0:
	mov_s r0,r8
L_92a2e2:
	mov_s r1,0x4
L_92a2e4:
	mov r2,r3
L_92a2e8:
	bl.d L_92a3d8
L_92a2ec:
	mov r3,r8
L_92a2f0:
	ld.as r7,[r13,0xfb]
L_92a2f4:
	brne r7,0x1,L_92a304
L_92a2f8:
	ld r15,[r13, 0xd8]
L_92a2fc:
	mov r6,0x1
L_92a300:
	st r6,[r14]
	.global L_92a304
L_92a304:
	ld blink,[sp, 0x4]
L_92a308:
	mov_s r0,r15
L_92a30a:
	ld_s r14,[sp,0x8]
L_92a30c:
	ld_s r15,[sp,0xc]
L_92a30e:
	j_s.d [blink]
L_92a310:
	ld.ab r13,[sp,0x10]
