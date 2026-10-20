/* rx_mgmt__find_free_ei @ 0x8c2bd0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_mgmt_prs__alloc_ei
 */
	.section .text.rx_mgmt__find_free_ei,"ax",@progbits
	.global rx_mgmt__find_free_ei
rx_mgmt__find_free_ei:
	.global L_8c2bd0
L_8c2bd0:
	mov_s r3,0x0
L_8c2bd2:
	b_s L_8c2bd6
	.global L_8c2bd4
L_8c2bd4:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
	.global L_8c2bd6
L_8c2bd6:
	brhs r3,0x5,L_8c2bf0
L_8c2bda:
	mul64 r3,0xd4
L_8c2bde:
	add r1,r0,mlo
L_8c2be2:
	ld_s r2,[r1,0x8]
L_8c2be4:
	brne_s r2,0,L_8c2bd4
L_8c2be6:
	mov_s r2,0x1
L_8c2be8:
	st_s r2,[r1,0x8]
L_8c2bea:
	add_s r0,r0,0x8
L_8c2bec:
	add_s r0,r0,mlo
L_8c2bee:
	b_s L_8c2bf2
	.global L_8c2bf0
L_8c2bf0:
	mov_s r0,0x0
	.global L_8c2bf2
L_8c2bf2:
	j_s [blink]
