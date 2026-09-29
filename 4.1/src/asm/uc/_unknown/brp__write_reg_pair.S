/* brp__write_reg_pair @ 0x92bcac, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__flow_main, brp__write_pair_0x504, brp__write_pair_b, brp_step_b
 */
	.section .text.brp__write_reg_pair,"ax",@progbits
	.global brp__write_reg_pair
brp__write_reg_pair:
	.global L_92bcac
L_92bcac:
	st.a r13,[sp,-0xc]
L_92bcb0:
	st blink,[sp, 0x4]
L_92bcb4:
	st_s r14,[sp,0x8]
L_92bcb6:
	mov_s r14,r0
L_92bcb8:
	mov_s r13,r1
L_92bcba:
	extw_s r1,r1
L_92bcbc:
	or r1,r1,0x42000000
L_92bcc4:
	mov r32,r1
L_92bcc8:
	st.ab r1,[r25,0x4]
L_92bccc:
	bclr r25,r25,0xa
L_92bcd0:
	lsr_s r13,r13,0x10
L_92bcd2:
	or r13,r13,0x43000000
L_92bcda:
	mov_s r32,r13
L_92bcdc:
	st.ab r13,[r25,0x4]
L_92bce0:
	bclr r25,r25,0xa
L_92bce4:
	ld_s r0,[gp,-0x44]
L_92bce6:
	and r0,r0,0xfff0ffff
L_92bcee:
	or r4,r0,0x30000
L_92bcf6:
	or r0,r0,0x1d030000
L_92bcfe:
	st.as r4,[gp,-0x11]
L_92bd02:
	mov_s r32,r0
L_92bd04:
	st.ab r0,[r25,0x4]
L_92bd08:
	bclr r25,r25,0xa
L_92bd0c:
	nop_s
L_92bd0e:
	nop_s
L_92bd10:
	mov 0x0,0x0
	.global L_92bd14
L_92bd14:
	mov_s r3,r47
L_92bd16:
	bbit1 r3,0x11,L_92bd14
L_92bd1a:
	ld.as r2,[gp,-0x4]
L_92bd1e:
	asl_s r14,r14,0x8
L_92bd20:
	or r2,r2,0x41000000
L_92bd28:
	or_s r14,r14,r2
L_92bd2a:
	mov_s r32,r14
L_92bd2c:
	st.ab r14,[r25,0x4]
L_92bd30:
	bclr r25,r25,0xa
L_92bd34:
	ld blink,[sp, 0x4]
L_92bd38:
	ld_s r14,[sp,0x8]
L_92bd3a:
	j_s.d [blink]
L_92bd3c:
	ld.ab r13,[sp,0xc]
