/* hwd_dma__reset_vring @ 0x8cdbe8, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Reset V-ring #%d, head %x head_4_rd %x.
 *   Before Reset V-ring #%d, tail %x .
 *   After Reset V-ring #%d, tail %x .
 * Зовут его: tail_hwd_dma__reset_vring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_log__emit3
 */
	.section .text.hwd_dma__reset_vring,"ax",@progbits
	.global hwd_dma__reset_vring
hwd_dma__reset_vring:
	.global L_8cdbe8
L_8cdbe8:
	push_s blink
L_8cdbea:
	bl.d L_8c02bc
L_8cdbee:
	mov_s r1,0x2
L_8cdbf0:
	mov_s r16,r0
L_8cdbf2:
	asl r15,r0,0x8
L_8cdbf6:
	add r0,r15,0x440c0c0
L_8cdbfe:
	lsr_s r0,r0,0x3
L_8cdc00:
	bic r0,r0,0x3
L_8cdc04:
	ld r4,[r0]
L_8cdc08:
	add r0,r15,0x440c120
L_8cdc10:
	lsr_s r0,r0,0x3
L_8cdc12:
	bic r0,r0,0x3
L_8cdc16:
	ld r5,[r0]
L_8cdc1a:
	mov_s r2,0x1018620
L_8cdc20:
	mov_s r13,0x0
L_8cdc22:
	mov_s r0,r13
L_8cdc24:
	bl.d L_8ee034
L_8cdc28:
	mov_s r3,r16
L_8cdc2a:
	add r0,r15,0x440c100
L_8cdc32:
	lsr_s r0,r0,0x3
L_8cdc34:
	bic r14,r0,0x3
L_8cdc38:
	ld r4,[r14]
L_8cdc3c:
	mov_s r2,0x1018648
L_8cdc42:
	mov_s r0,r13
L_8cdc44:
	mov_s r1,0x2
L_8cdc46:
	bl.d L_8edff8
L_8cdc4a:
	mov_s r3,r16
L_8cdc4c:
	st_s r13,[r14]
L_8cdc4e:
	ld r4,[r14]
L_8cdc52:
	mov_s r2,0x101866c
L_8cdc58:
	mov_s r0,r13
L_8cdc5a:
	mov_s r1,0x2
L_8cdc5c:
	bl.d L_8edff8
L_8cdc60:
	mov_s r3,r16
L_8cdc62:
	add r1,r15,0x440c0e0
L_8cdc6a:
	add r0,r15,0x440c0ff
L_8cdc72:
	bmsk_s r0,r0,0x4
L_8cdc74:
	lsr_s r1,r1,0x3
L_8cdc76:
	bic r2,r1,0x3
L_8cdc7a:
	st_s r13,[r2]
L_8cdc7c:
	mov_s r1,0x0
L_8cdc7e:
	bset r1,r1,r0
L_8cdc82:
	st_s r1,[r2]
L_8cdc84:
	add r1,r15,0x440c140
L_8cdc8c:
	add r0,r15,0x440c15f
L_8cdc94:
	bmsk_s r0,r0,0x4
L_8cdc96:
	lsr_s r1,r1,0x3
L_8cdc98:
	bic r2,r1,0x3
L_8cdc9c:
	st_s r13,[r2]
L_8cdc9e:
	mov_s r1,0x0
L_8cdca0:
	bset r1,r1,r0
L_8cdca4:
	st_s r1,[r2]
L_8cdca6:
	b L_8c0324
L_8cdcaa:
	nop_s
