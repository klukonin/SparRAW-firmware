/* tx_api__count_completion_status @ 0x8e5a78, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets
 */
	.section .text.tx_api__count_completion_status,"ax",@progbits
	.global tx_api__count_completion_status
tx_api__count_completion_status:
	.global L_8e5a78
L_8e5a78:
	ld_s r3,[r0]
L_8e5a7a:
	cmp_s r1,0x2
L_8e5a7c:
	ld_s r2,[r3,0x8]
L_8e5a7e:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e5a80:
	st_s r2,[r3,0x8]
L_8e5a82:
	beq_s L_8e5aa6
L_8e5a84:
	bgt_s L_8e5a92
L_8e5a86:
	brne_s r1,0,L_8e5aba
L_8e5a88:
	ld_s r1,[r0]
L_8e5a8a:
	ld_s r0,[r1,0xc]
L_8e5a8c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5a8e:
	j_s.d [blink]
L_8e5a90:
	st_s r0,[r1,0xc]
	.global L_8e5a92
L_8e5a92:
	breq r1,0x4,L_8e5ab0
L_8e5a96:
	cmp r1,0xff
L_8e5a9a:
	bne_s L_8e5aba
L_8e5a9c:
	ld_s r1,[r0]
L_8e5a9e:
	ld_s r0,[r1,0x14]
L_8e5aa0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5aa2:
	j_s.d [blink]
L_8e5aa4:
	st_s r0,[r1,0x14]
	.global L_8e5aa6
L_8e5aa6:
	ld_s r1,[r0]
L_8e5aa8:
	ld_s r0,[r1,0x18]
L_8e5aaa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5aac:
	j_s.d [blink]
L_8e5aae:
	st_s r0,[r1,0x18]
	.global L_8e5ab0
L_8e5ab0:
	ld_s r1,[r0]
L_8e5ab2:
	ld_s r0,[r1,0x10]
L_8e5ab4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e5ab6:
	j_s.d [blink]
L_8e5ab8:
	st_s r0,[r1,0x10]
	.global L_8e5aba
L_8e5aba:
	j_s [blink]
