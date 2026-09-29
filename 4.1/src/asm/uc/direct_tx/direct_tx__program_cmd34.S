/* direct_tx__program_cmd34 @ 0x924ea8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft__send_ssw_feedback, bi_rx__send_response, cf_end__send_frame, direct_tx__send_short_frame, direct_tx_rx__program, direct_tx_step, internal_tx_step, mac_mode_program_a, mac_mode_program_b, rx_funcs_step
 * Глобалы (через gp): 0x8005d4
 */
	.section .text.direct_tx__program_cmd34,"ax",@progbits
	.global direct_tx__program_cmd34
direct_tx__program_cmd34:
	.global L_924ea8
L_924ea8:
	st.a r13,[sp,-0xc]
L_924eac:
	st blink,[sp, 0x4]
L_924eb0:
	st_s r14,[sp,0x8]
L_924eb2:
	mov_s r13,r0
L_924eb4:
	mov_s r14,r1
L_924eb6:
	mov_s r1,0x33000001
L_924ebc:
	mov r32,r1
L_924ec0:
	st.ab r1,[r25,0x4]
L_924ec4:
	bclr r25,r25,0xa
L_924ec8:
	st.as r14,[gp,-0x6]
L_924ecc:
	stw.as r13,[gp,0x56]
L_924ed0:
	or r14,r14,0x34000000
L_924ed8:
	asl r0,r13,0x10
L_924edc:
	or_s r0,r0,r14
L_924ede:
	mov_s r32,r0
L_924ee0:
	st.ab r0,[r25,0x4]
L_924ee4:
	bclr r25,r25,0xa
L_924ee8:
	ld blink,[sp, 0x4]
L_924eec:
	ld_s r14,[sp,0x8]
L_924eee:
	j_s.d [blink]
L_924ef0:
	ld.ab r13,[sp,0xc]
