/* mac_enable_bcast_ring @ 0x8c1498, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__setup_bcast_vring
 */
	.section .text.mac_enable_bcast_ring,"ax",@progbits
	.global mac_enable_bcast_ring
mac_enable_bcast_ring:
	.global L_8c1498
L_8c1498:
	mov_s r1,0x881800
L_8c149e:
	ld.as r0,[r1,0xc9]
L_8c14a2:
	bset_s r0,r0,0x0
L_8c14a4:
	st.as r0,[r1,0xc9]
L_8c14a8:
	ld.as r0,[r1,0xe2]
L_8c14ac:
	bset_s r0,r0,0x7
L_8c14ae:
	st.as r0,[r1,0xe2]
L_8c14b2:
	j_s [blink]
