/* ring__is_full @ 0x8d7220, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_dma_if__push_desc
 */
	.section .text.ring__is_full,"ax",@progbits
	.global ring__is_full
ring__is_full:
	.global L_8d7220
L_8d7220:
	ld_s r1,[r0,0xc]
L_8d7222:
	ld_s r2,[r0,0x4]
L_8d7224:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8d7226:
	cmp_s r1,r2
L_8d7228:
	ld_s r0,[r0,0x8]
L_8d722a:
	mov.eq r1,0x0
L_8d722e:
	cmp_s r1,r0
L_8d7230:
	mov_s r0,0x1
L_8d7232:
	j_s.d [blink]
L_8d7234:
	sub_s.ne r0,r0,r0
L_8d7236:
	nop_s
