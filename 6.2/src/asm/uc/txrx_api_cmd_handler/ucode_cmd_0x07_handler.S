/* ucode_cmd_0x07_handler @ 0x93ae18, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, mac_qset__reset_masks, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x07_handler
ucode_cmd_0x07_handler:
	.global L_93ae18
L_93ae18:
	push_s blink
L_93ae1a:
	push_s r13
L_93ae1c:
	ld_s r1,[r0,0xc]
L_93ae1e:
	breq r1,0x0,L_93aea0
L_93ae22:
	breq r1,0x1,L_93ae34
L_93ae26:
	breq r1,0x2,L_93ae7c
L_93ae2a:
	mov_s r0,blink
L_93ae2c:
	bl.d L_926618
L_93ae30:
	mov_s r1,0x82
L_93ae32:
	b_s L_93aea0
	.global L_93ae34
L_93ae34:
	ld_s r1,[r0,0x4]
L_93ae36:
	mov_s r3,0x0
L_93ae38:
	bmsk r13,r1,0x4
L_93ae3c:
	lsr_s r1,r1,0x8
L_93ae3e:
	bmsk r2,r1,0x4
L_93ae42:
	mov_s r1,0x0
L_93ae44:
	bset r1,r1,r2
L_93ae48:
	bset r3,r3,r13
L_93ae4c:
	sub r2,r1,r3
L_93ae50:
	or_s r1,r1,r2
L_93ae52:
	mov_s r2,0x800400
L_93ae58:
	st_s r1,[r2,0x10]
L_93ae5a:
	ld_s r1,[r0,0x4]
L_93ae5c:
	mov_s r3,0x0
L_93ae5e:
	lsr r0,r1,0x10
L_93ae62:
	bmsk_s r0,r0,0x4
L_93ae64:
	lsr_s r1,r1,0x18
L_93ae66:
	bmsk_s r1,r1,0x4
L_93ae68:
	bset r3,r3,r1
L_93ae6c:
	mov_s r1,0x0
L_93ae6e:
	bset r1,r1,r0
L_93ae72:
	sub r0,r3,r1
L_93ae76:
	or_s r0,r0,r3
L_93ae78:
	st_s r0,[r2,0x18]
L_93ae7a:
	b_s L_93aea0
	.global L_93ae7c
L_93ae7c:
	ld_s r0,[r0,0x8]
L_93ae7e:
	mov_s r1,0x0
L_93ae80:
	bmsk r3,r0,0x4
L_93ae84:
	lsr_s r0,r0,0x8
L_93ae86:
	bmsk_s r0,r0,0x4
L_93ae88:
	bset r1,r1,r0
L_93ae8c:
	mov_s r2,0x0
L_93ae8e:
	bset r2,r2,r3
L_93ae92:
	sub r0,r1,r2
L_93ae96:
	or_s r0,r0,r1
L_93ae98:
	mov_s r1,0x800400
L_93ae9e:
	st_s r0,[r1,0x20]
	.global L_93aea0
L_93aea0:
	bl L_92ea48
L_93aea4:
	b L_9202ac
