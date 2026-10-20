/* tx_api__stamp_seq_bytes @ 0x8c7110, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__send_packet
 */
	.section .text.tx_api__stamp_seq_bytes,"ax",@progbits
	.global tx_api__stamp_seq_bytes
tx_api__stamp_seq_bytes:
	.global L_8c7110
L_8c7110:
	push_s r13
L_8c7112:
	mov_s r3,0x0
L_8c7114:
	b_s L_8c713e
	.global L_8c7116
L_8c7116:
	add_s r12,r0,r3
L_8c7118:
	stb_s r1,[r12]
L_8c711a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c711c:
	extb_s r1,r1
L_8c711e:
	add_s r13,r3,0x1
L_8c7120:
	add_s r13,r13,r0
L_8c7122:
	stb_s r1,[r13]
L_8c7124:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7126:
	extb_s r1,r1
L_8c7128:
	add_s r13,r3,0x2
L_8c712a:
	add_s r13,r13,r0
L_8c712c:
	stb_s r1,[r13]
L_8c712e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7130:
	extb_s r1,r1
L_8c7132:
	add_s r13,r3,0x3
L_8c7134:
	add_s r13,r13,r0
L_8c7136:
	stb_s r1,[r13]
L_8c7138:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c713a:
	extb_s r1,r1
L_8c713c:
	/* add_s r3,0x4 */
	.byte 0x04,0xe3
	.global L_8c713e
L_8c713e:
	bic r13,r2,0x3
L_8c7142:
	brlo r3,r13,L_8c7116
	.global L_8c7146
L_8c7146:
	bmsk r13,r2,0x1
L_8c714a:
	brhs r3,r13,L_8c715a
L_8c714e:
	add_s r12,r0,r3
L_8c7150:
	stb_s r1,[r12]
L_8c7152:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c7154:
	extb_s r1,r1
L_8c7156:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8c7158:
	b_s L_8c7146
	.global L_8c715a
L_8c715a:
	j_s.d [blink]
L_8c715c:
	pop_s r13
L_8c715e:
	nop_s
