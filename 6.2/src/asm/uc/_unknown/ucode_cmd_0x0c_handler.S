/* ucode_cmd_0x0c_handler @ 0x93b924, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, txss__set_sweep_param, txss__sweep_timing, uc_sysassert, ucode_cmd_0b__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x0c_handler
ucode_cmd_0x0c_handler:
	.global L_93b924
L_93b924:
	push_s blink
L_93b926:
	bl L_920230
L_93b92a:
	ldb_s r14,[r0]
L_93b92c:
	sub_s sp,sp,0x8
L_93b92e:
	brhs.d r14,0x9,L_93b9b6
L_93b932:
	mov_s r13,r0
	.global L_93b934
L_93b934:
	mul64 r14,0x4c
L_93b938:
	add r0,mlo,0x802b68
L_93b940:
	st_s r0,[sp,0x0]
L_93b942:
	bl.d L_92b198
L_93b946:
	add_s r1,r13,0x4
L_93b948:
	asl_s r0,r14,0x4
L_93b94a:
	mul64 r14,0x4c
L_93b94e:
	add2_s r0,r0,r0
L_93b950:
	mov_s r1,0x801150
L_93b956:
	ldb_s r13,[r1,r0]
L_93b958:
	mov_s r0,0x802e64
L_93b95e:
	add r15,mlo,0x802ba8
L_93b966:
	add3_s r0,r0,r14
L_93b968:
	ldb_s r1,[r15,0x8]
L_93b96a:
	mov_s r4,r0
L_93b96c:
	bl.d L_939cc4
L_93b970:
	mov_s r2,r13
L_93b972:
	ldb_s r0,[r15,0x8]
L_93b974:
	ldb r5,[r15, 0x9]
L_93b978:
	mulu64 r0,r13
L_93b97c:
	sub_s r0,r13,0x1
L_93b97e:
	ld_s r1,[sp,0x0]
L_93b980:
	mov_s r2,r13
L_93b982:
	add_s r0,r0,mlo
L_93b984:
	extb_s r0,r0
L_93b986:
	st_s r0,[sp,0x4]
L_93b988:
	mov_s r0,r4
L_93b98a:
	mov_s r3,0x0
L_93b98c:
	bl.d L_9357ec
L_93b990:
	ld r4,[sp, 0x4]
L_93b994:
	mov_s r0,0x802e54
L_93b99a:
	ldb_s r1,[r0,0xa]
L_93b99c:
	ld_s r0,[gp,-0xc]
L_93b99e:
	asl_s r1,r1,0x8
L_93b9a0:
	or r0,r0,0x30
L_93b9a4:
	or_s r0,r0,r1
L_93b9a6:
	mov_s r1,0x802aec
L_93b9ac:
	add2_s r1,r1,r14
L_93b9ae:
	st_s r0,[r1]
L_93b9b0:
	b.d L_92029c
L_93b9b4:
	add_s sp,sp,0x8
	.global L_93b9b6
L_93b9b6:
	mov_s r0,blink
L_93b9b8:
	bl.d L_926618
L_93b9bc:
	mov_s r1,0xfd
L_93b9be:
	b_s L_93b934
