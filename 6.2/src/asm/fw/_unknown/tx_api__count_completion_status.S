/* tx_api__count_completion_status @ 0x8ead70, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__handle_completed_packets
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__count_completion_status
tx_api__count_completion_status:
	.global L_8ead70
L_8ead70:
	ld_s r3,[r0]
L_8ead72:
	cmp_s r1,0x2
L_8ead74:
	ld_s r2,[r3,0x8]
L_8ead76:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ead78:
	st_s r2,[r3,0x8]
L_8ead7a:
	beq_s L_8ead9e
L_8ead7c:
	bgt_s L_8ead8a
L_8ead7e:
	brne_s r1,0,L_8eadb2
L_8ead80:
	ld_s r1,[r0]
L_8ead82:
	ld_s r0,[r1,0xc]
L_8ead84:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ead86:
	j_s.d [blink]
L_8ead88:
	st_s r0,[r1,0xc]
	.global L_8ead8a
L_8ead8a:
	breq r1,0x4,L_8eada8
L_8ead8e:
	cmp r1,0xff
L_8ead92:
	bne_s L_8eadb2
L_8ead94:
	ld_s r1,[r0]
L_8ead96:
	ld_s r0,[r1,0x14]
L_8ead98:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ead9a:
	j_s.d [blink]
L_8ead9c:
	st_s r0,[r1,0x14]
	.global L_8ead9e
L_8ead9e:
	ld_s r1,[r0]
L_8eada0:
	ld_s r0,[r1,0x18]
L_8eada2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eada4:
	j_s.d [blink]
L_8eada6:
	st_s r0,[r1,0x18]
	.global L_8eada8
L_8eada8:
	ld_s r1,[r0]
L_8eadaa:
	ld_s r0,[r1,0x10]
L_8eadac:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eadae:
	j_s.d [blink]
L_8eadb0:
	st_s r0,[r1,0x10]
	.global L_8eadb2
L_8eadb2:
	j_s [blink]
