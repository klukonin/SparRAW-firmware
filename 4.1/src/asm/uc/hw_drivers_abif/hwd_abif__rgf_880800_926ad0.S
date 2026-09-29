/* hwd_abif__rgf_880800_926ad0 @ 0x926ad0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_step
 */
	.section .text.hwd_abif__rgf_880800_926ad0,"ax",@progbits
	.global hwd_abif__rgf_880800_926ad0
hwd_abif__rgf_880800_926ad0:
	.global L_926ad0
L_926ad0:
	mov r3,0x1b0
L_926ad4:
	mov r4,0x880800
L_926adc:
	breq.d r0,0x0,L_926af4
L_926ae0:
	mov r1,-0x1b1
L_926ae4:
	ld.as r2,[r4,0xc0]
L_926ae8:
	and_s r1,r1,r2
L_926aea:
	or_s r1,r1,r3
L_926aec:
	st.as r1,[r4,0xc0]
L_926af0:
	j [blink]
	.global L_926af4
L_926af4:
	ld.as r0,[r4,0xc0]
L_926af8:
	and_s r0,r0,r1
L_926afa:
	st.as r0,[r4,0xc0]
L_926afe:
	j_s [blink]
