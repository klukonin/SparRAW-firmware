/* gp_timer__set_value @ 0x935080, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ctx__clear_flag_179
 * Зовёт сам: mac_evt__select_timer_group, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp_timer__set_value
gp_timer__set_value:
	.global L_935080
L_935080:
	st.a r13,[sp,-0xc]
L_935084:
	st blink,[sp, 0x4]
L_935088:
	st_s r14,[sp,0x8]
L_93508a:
	mov_s r14,r1
L_93508c:
	and.f 0x0,r2,0xff000000
L_935094:
	bne.d L_93511c
L_935098:
	mov r13,r2
	.global L_93509c
L_93509c:
	bl.d L_9258e0
L_9350a0:
	mov r0,r14
L_9350a4:
	asl r1,r14,0x14
L_9350a8:
	and r1,r1,0xf00000
L_9350b0:
	or r1,r1,0x68000000
L_9350b8:
	mov r32,r1
L_9350bc:
	st.ab r1,[r25,0x4]
L_9350c0:
	bclr r25,r25,0xa
L_9350c4:
	nop_s
L_9350c6:
	nop_s
L_9350c8:
	nop_s
L_9350ca:
	or r13,r13,0x67000000
L_9350d2:
	mov_s r32,r13
L_9350d4:
	st.ab r13,[r25,0x4]
L_9350d8:
	bclr r25,r25,0xa
L_9350dc:
	nop_s
L_9350de:
	nop_s
L_9350e0:
	nop_s
L_9350e2:
	asl r2,r14,0x14
L_9350e6:
	and r2,r2,0xf00000
L_9350ee:
	or r2,r2,0x6800020b
L_9350f6:
	mov_s r32,r2
L_9350f8:
	st.ab r2,[r25,0x4]
L_9350fc:
	bclr r25,r25,0xa
L_935100:
	mov_s r0,0x49020000
L_935106:
	mov_s r32,r0
L_935108:
	st.ab r0,[r25,0x4]
L_93510c:
	bclr r25,r25,0xa
L_935110:
	ld blink,[sp, 0x4]
L_935114:
	ld_s r14,[sp,0x8]
L_935116:
	j_s.d [blink]
L_935118:
	ld.ab r13,[sp,0xc]
	.global L_93511c
L_93511c:
	mov r0,blink
L_935120:
	bl.d L_926618
L_935124:
	mov r1,0xa9
L_935128:
	b_s L_93509c
L_93512a:
	nop_s
