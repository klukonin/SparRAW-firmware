/* mac__program_4f_52 @ 0x924d8c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__exchange_request, brp_initiator_brp_transaction_flow, txss_resp__wait_iss_end
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_4f_52
mac__program_4f_52:
	.global L_924d8c
L_924d8c:
	st.a r13,[sp,-0x8]
L_924d90:
	st_s r14,[sp,0x4]
L_924d92:
	mov_s r14,blink
L_924d94:
	mov_s r13,r1
L_924d96:
	or r0,r0,0x4f000000
L_924d9e:
	mov_s r32,r0
L_924da0:
	st.ab r0,[r25,0x4]
L_924da4:
	bclr r25,r25,0xa
L_924da8:
	asl r0,r13,0x8
L_924dac:
	or r0,r0,0x52000008
L_924db4:
	mov r32,r0
L_924db8:
	st.ab r0,[r25,0x4]
L_924dbc:
	bclr r25,r25,0xa
L_924dc0:
	mov_s blink,r14
L_924dc2:
	ld_s r14,[sp,0x4]
L_924dc4:
	j.d [blink]
L_924dc8:
	ld.ab r13,[sp,0x8]
