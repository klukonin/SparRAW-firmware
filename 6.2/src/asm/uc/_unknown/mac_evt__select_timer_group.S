/* mac_evt__select_timer_group @ 0x9258e0, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss__program_sector, bcon_txss_sweep_step, gp_timer__set_value, internal_tx__flow_sm6, sxd_hal__write_qset_field
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_evt__select_timer_group
mac_evt__select_timer_group:
	.global L_9258e0
L_9258e0:
	st.a r13,[sp,-0xc]
L_9258e4:
	st blink,[sp, 0x4]
L_9258e8:
	st_s r14,[sp,0x8]
L_9258ea:
	mov_s r13,r0
L_9258ec:
	mov_s r14,0x0
L_9258ee:
	asl_s r0,r0,0x14
L_9258f0:
	and r0,r0,0xf00000
L_9258f8:
	or r0,r0,0x68000000
L_925900:
	mov r32,r0
L_925904:
	st.ab r0,[r25,0x4]
L_925908:
	bclr r25,r25,0xa
L_92590c:
	brhs r13,0x3,L_92592c
L_925910:
	mov_s r14,0x49008000
L_925916:
	mov_s r32,r14
L_925918:
	st.ab r14,[r25,0x4]
L_92591c:
	bclr r25,r25,0xa
L_925920:
	ld blink,[sp, 0x4]
L_925924:
	ld_s r14,[sp,0x8]
L_925926:
	j_s.d [blink]
L_925928:
	ld.ab r13,[sp,0xc]
	.global L_92592c
L_92592c:
	brhs r13,0x6,L_92594c
L_925930:
	mov_s r14,0x49010000
L_925936:
	mov_s r32,r14
L_925938:
	st.ab r14,[r25,0x4]
L_92593c:
	bclr r25,r25,0xa
L_925940:
	ld blink,[sp, 0x4]
L_925944:
	ld_s r14,[sp,0x8]
L_925946:
	j_s.d [blink]
L_925948:
	ld.ab r13,[sp,0xc]
	.global L_92594c
L_92594c:
	brhs r13,0xa,L_92596c
L_925950:
	mov_s r14,0x49020000
L_925956:
	mov_s r32,r14
L_925958:
	st.ab r14,[r25,0x4]
L_92595c:
	bclr r25,r25,0xa
L_925960:
	ld blink,[sp, 0x4]
L_925964:
	ld_s r14,[sp,0x8]
L_925966:
	j_s.d [blink]
L_925968:
	ld.ab r13,[sp,0xc]
	.global L_92596c
L_92596c:
	mov r0,blink
L_925970:
	bl.d L_926618
L_925974:
	mov r1,0x69
L_925978:
	or r14,r14,0x49000000
L_925980:
	mov r32,r14
L_925984:
	st.ab r14,[r25,0x4]
L_925988:
	bclr r25,r25,0xa
L_92598c:
	ld blink,[sp, 0x4]
L_925990:
	ld_s r14,[sp,0x8]
L_925992:
	j_s.d [blink]
L_925994:
	ld.ab r13,[sp,0xc]
