/* mac__program_tx_beacon @ 0x92d8a4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, bti__measure_frame_duration
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__program_tx_beacon
mac__program_tx_beacon:
	.global L_92d8a4
L_92d8a4:
	push_s r13
L_92d8a6:
	mov_s r13,blink
L_92d8a8:
	mov_s r2,0x1b001111
L_92d8ae:
	mov_s r32,r2
L_92d8b0:
	st.ab r2,[r25,0x4]
L_92d8b4:
	bclr r25,r25,0xa
L_92d8b8:
	mov_s r1,0x161e0001
L_92d8be:
	mov_s r32,r1
L_92d8c0:
	st.ab r1,[r25,0x4]
L_92d8c4:
	bclr r25,r25,0xa
L_92d8c8:
	mov_s r0,0x17000003
L_92d8ce:
	mov_s r32,r0
L_92d8d0:
	st.ab r0,[r25,0x4]
L_92d8d4:
	bclr r25,r25,0xa
L_92d8d8:
	nop_s
L_92d8da:
	nop_s
L_92d8dc:
	nop_s
L_92d8de:
	mov_s blink,r13
L_92d8e0:
	j.d [blink]
L_92d8e4:
	pop_s r13
L_92d8e6:
	nop_s
