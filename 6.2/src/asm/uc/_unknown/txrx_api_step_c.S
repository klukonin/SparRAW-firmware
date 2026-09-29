/* txrx_api_step_c @ 0x9368d8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x04_handler_uc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txrx_api_step_c
txrx_api_step_c:
	.global L_9368d8
L_9368d8:
	push_s blink
L_9368da:
	bl L_920234
L_9368de:
	mov_s r14,r0
L_9368e0:
	mov_s r13,r1
L_9368e2:
	ldw_s r0,[r1,0x4]
L_9368e4:
	mov_s r1,0x0
L_9368e6:
	bset r1,r1,r0
L_9368ea:
	ldw_s r0,[r13,0x8]
L_9368ec:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_9368ee:
	asl_s r0,r0,0x1c
L_9368f0:
	or r0,r0,0x201ff
L_9368f8:
	mov_s r2,0x886d68
L_9368fe:
	add2_s r2,r2,r14
L_936900:
	st_s r0,[r2]
L_936902:
	mov_s r0,0xc0adc0ad
L_936908:
	asl_s r0,r0,r14
L_93690a:
	mov_s r2,0x886d78
L_936910:
	add2_s r2,r2,r14
L_936912:
	st_s r0,[r2]
L_936914:
	add r0,r14,0x9
L_936918:
	asl_s r0,r0,0x18
L_93691a:
	or_s r0,r0,r1
L_93691c:
	mov_s r32,r0
L_93691e:
	st.ab r0,[r25,0x4]
L_936922:
	bclr r25,r25,0xa
L_936926:
	mov_s r0,0x0
L_936928:
	add r1,r14,0x14
L_93692c:
	bset r0,r0,r1
L_936930:
	add r2,r14,0x8
L_936934:
	bset r1,r0,r2
L_936938:
	ld_s r0,[gp,-0x1c]
L_93693a:
	bic_s r0,r0,r1
L_93693c:
	or_s r0,r0,r1
L_93693e:
	st.as r0,[gp,-0x7]
L_936942:
	bset_s r0,r0,0x18
L_936944:
	bset_s r0,r0,0x19
L_936946:
	bset_s r0,r0,0x1a
L_936948:
	mov_s r32,r0
L_93694a:
	st.ab r0,[r25,0x4]
L_93694e:
	bclr r25,r25,0xa
L_936952:
	ldw_s r1,[r13,0x4]
L_936954:
	mov_s r0,0x8015a4
L_93695a:
	add2_s r0,r0,r14
L_93695c:
	stb_s r1,[r0]
L_93695e:
	ldw_s r1,[r13,0x4]
L_936960:
	stb_s r1,[r0,0x2]
L_936962:
	ldw_s r1,[r13,0x6]
L_936964:
	b.d L_9202a4
L_936968:
	stb_s r1,[r0,0x1]
L_93696a:
	nop_s
