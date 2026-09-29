/* internal_tx__peer_pending @ 0x928fd0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step
 */
	.section .text.internal_tx__peer_pending,"ax",@progbits
	.global internal_tx__peer_pending
internal_tx__peer_pending:
	.global L_928fd0
L_928fd0:
	ld.as r2,[r0,0x50]
L_928fd4:
	breq r2,0x0,L_928ff8
L_928fd8:
	ld.as r3,[r0,0x4e]
L_928fdc:
	asl r4,0x1,r1
L_928fe4:
	ld.as r1,[r0,0x4d]
L_928fe8:
	and r3,r3,r4
L_928fec:
	or.f 0x0,r1,r3
L_928ff0:
	beq.d L_928ffc
L_928ff4:
	mov r2,0x1
	.global L_928ff8
L_928ff8:
	mov r2,0x0
	.global L_928ffc
L_928ffc:
	j.d [blink]
L_929000:
	mov_s r0,r2
L_929002:
	nop_s
