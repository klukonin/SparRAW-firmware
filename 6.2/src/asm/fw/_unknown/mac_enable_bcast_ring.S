/* mac_enable_bcast_ring @ 0x8c14d4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__configure_tx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_enable_bcast_ring
mac_enable_bcast_ring:
	.global L_8c14d4
L_8c14d4:
	mov_s r1,0x881800
L_8c14da:
	ld.as r0,[r1,0xc9]
L_8c14de:
	bset_s r0,r0,0x0
L_8c14e0:
	st.as r0,[r1,0xc9]
L_8c14e4:
	ld.as r0,[r1,0xe2]
L_8c14e8:
	bset_s r0,r0,0x7
L_8c14ea:
	st.as r0,[r1,0xe2]
L_8c14ee:
	j_s [blink]
