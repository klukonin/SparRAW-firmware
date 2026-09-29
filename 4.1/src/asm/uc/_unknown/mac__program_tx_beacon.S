/* mac__program_tx_beacon @ 0x92a2d4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_sweep_step_a, bcon_txss_sweep_step
 */
	.section .text.mac__program_tx_beacon,"ax",@progbits
	.global mac__program_tx_beacon
mac__program_tx_beacon:
	.global L_92a2d4
L_92a2d4:
	push_s r13
L_92a2d6:
	mov_s r13,blink
L_92a2d8:
	mov_s r2,0x1b001111
L_92a2de:
	mov_s r32,r2
L_92a2e0:
	st.ab r2,[r25,0x4]
L_92a2e4:
	bclr r25,r25,0xa
L_92a2e8:
	mov_s r1,0x161e0001
L_92a2ee:
	mov_s r32,r1
L_92a2f0:
	st.ab r1,[r25,0x4]
L_92a2f4:
	bclr r25,r25,0xa
L_92a2f8:
	mov_s r0,0x17000003
L_92a2fe:
	mov_s r32,r0
L_92a300:
	st.ab r0,[r25,0x4]
L_92a304:
	bclr r25,r25,0xa
L_92a308:
	nop_s
L_92a30a:
	nop_s
L_92a30c:
	nop_s
L_92a30e:
	mov_s blink,r13
L_92a310:
	j.d [blink]
L_92a314:
	pop_s r13
L_92a316:
	nop_s
