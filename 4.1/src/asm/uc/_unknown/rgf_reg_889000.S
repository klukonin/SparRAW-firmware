/* rgf_reg_889000 @ 0x927508, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_wrap
 * Зовёт сам: uc_hwd_rfc_write_core
 */
	.section .text.rgf_reg_889000,"ax",@progbits
	.global rgf_reg_889000
rgf_reg_889000:
	.global L_927508
L_927508:
	st.a r13,[sp,-0x4]
L_92750c:
	brne.d r1,0x1,L_927524
L_927510:
	mov_s r13,blink
L_927512:
	mov_s r1,0x8
L_927514:
	mov r2,0x0
L_927518:
	bl.d L_927564
L_92751c:
	mov r3,r2
L_927520:
	b L_92755e
	.global L_927524
L_927524:
	mov r4,0x889000
L_92752c:
	ld.as r2,[r4,0x46]
L_927530:
	mov r5,0x3e80
L_927538:
	bclr r2,r2,0x4
L_92753c:
	st.as r2,[r4,0x46]
L_927540:
	mov lp_count,r5
L_927544:
	nop_s
L_927546:
	lp L_92754e
L_92754a:
	nop_s
L_92754c:
	nop_s
	.global L_92754e
L_92754e:
	mov_s r3,0x889000
L_927554:
	ld.as r1,[r3,0x46]
L_927558:
	bset_s r1,r1,0x4
L_92755a:
	st.as r1,[r3,0x46]
	.global L_92755e
L_92755e:
	mov_s blink,r13
L_927560:
	j_s.d [blink]
L_927562:
	pop_s r13
