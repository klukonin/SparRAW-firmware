/* brp__write_reg_pair @ 0x92f9d8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_restore_sectors, config_brp_rf, mac__read_tsf64_uc, sector_mem__addr_of
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__write_reg_pair
brp__write_reg_pair:
	.global L_92f9d8
L_92f9d8:
	st.a r13,[sp,-0xc]
L_92f9dc:
	st blink,[sp, 0x4]
L_92f9e0:
	st_s r14,[sp,0x8]
L_92f9e2:
	mov_s r14,r0
L_92f9e4:
	mov_s r13,r1
L_92f9e6:
	extw_s r1,r1
L_92f9e8:
	or r1,r1,0x42000000
L_92f9f0:
	mov r32,r1
L_92f9f4:
	st.ab r1,[r25,0x4]
L_92f9f8:
	bclr r25,r25,0xa
L_92f9fc:
	lsr_s r13,r13,0x10
L_92f9fe:
	or r13,r13,0x43000000
L_92fa06:
	mov_s r32,r13
L_92fa08:
	st.ab r13,[r25,0x4]
L_92fa0c:
	bclr r25,r25,0xa
L_92fa10:
	ld_s r0,[gp,-0x44]
L_92fa12:
	and r0,r0,0xfff0ffff
L_92fa1a:
	or r4,r0,0x30000
L_92fa22:
	or r0,r0,0x1d030000
L_92fa2a:
	st.as r4,[gp,-0x11]
L_92fa2e:
	mov_s r32,r0
L_92fa30:
	st.ab r0,[r25,0x4]
L_92fa34:
	bclr r25,r25,0xa
L_92fa38:
	nop_s
L_92fa3a:
	nop_s
L_92fa3c:
	mov 0x0,0x0
	.global L_92fa40
L_92fa40:
	mov_s r3,r47
L_92fa42:
	bbit1 r3,0x11,L_92fa40
L_92fa46:
	ld.as r2,[gp,-0x3]
L_92fa4a:
	asl_s r14,r14,0x8
L_92fa4c:
	or r2,r2,0x41000000
L_92fa54:
	or_s r14,r14,r2
L_92fa56:
	mov_s r32,r14
L_92fa58:
	st.ab r14,[r25,0x4]
L_92fa5c:
	bclr r25,r25,0xa
L_92fa60:
	ld blink,[sp, 0x4]
L_92fa64:
	ld_s r14,[sp,0x8]
L_92fa66:
	j_s.d [blink]
L_92fa68:
	ld.ab r13,[sp,0xc]
