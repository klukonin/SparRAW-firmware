/* mac__program_4f_52 @ 0x924840, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_brp_step, mac_mode_step_b, txss_rx_step
 */
	.section .text.mac__program_4f_52,"ax",@progbits
	.global mac__program_4f_52
mac__program_4f_52:
	.global L_924840
L_924840:
	st.a r13,[sp,-0x8]
L_924844:
	st_s r14,[sp,0x4]
L_924846:
	mov_s r14,blink
L_924848:
	mov_s r13,r1
L_92484a:
	or r0,r0,0x4f000000
L_924852:
	mov_s r32,r0
L_924854:
	st.ab r0,[r25,0x4]
L_924858:
	bclr r25,r25,0xa
L_92485c:
	asl r0,r13,0x8
L_924860:
	or r0,r0,0x52000008
L_924868:
	mov r32,r0
L_92486c:
	st.ab r0,[r25,0x4]
L_924870:
	bclr r25,r25,0xa
L_924874:
	mov_s blink,r14
L_924876:
	ld_s r14,[sp,0x4]
L_924878:
	j.d [blink]
L_92487c:
	ld.ab r13,[sp,0x8]
