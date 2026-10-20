/* mac__program_tx_result_ctx_uc @ 0x92db20, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__submit_frame
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_tx_result_ctx_uc
mac__program_tx_result_ctx_uc:
	.global L_92db20
L_92db20:
	st.a r13,[sp,-0xc]
L_92db24:
	st blink,[sp, 0x4]
L_92db28:
	st_s r14,[sp,0x8]
L_92db2a:
	asl_s r0,r0,0x10
L_92db2c:
	bset r14,r0,0x4
L_92db30:
	cmp_s r1,0x0
L_92db32:
	mov r13,0x103
L_92db36:
	mov.eq r13,0x0
L_92db3a:
	mov_s r1,0x1b001111
L_92db40:
	mov r32,r1
L_92db44:
	st.ab r1,[r25,0x4]
L_92db48:
	bclr r25,r25,0xa
L_92db4c:
	or r14,r14,0x16000000
L_92db54:
	mov r32,r14
L_92db58:
	st.ab r14,[r25,0x4]
L_92db5c:
	bclr r25,r25,0xa
L_92db60:
	or r13,r13,0x17000000
L_92db68:
	mov r32,r13
L_92db6c:
	st.ab r13,[r25,0x4]
L_92db70:
	bclr r25,r25,0xa
L_92db74:
	nop_s
L_92db76:
	nop_s
L_92db78:
	nop_s
L_92db7a:
	ld blink,[sp, 0x4]
L_92db7e:
	ld_s r14,[sp,0x8]
L_92db80:
	j.d [blink]
L_92db84:
	ld.ab r13,[sp,0xc]
