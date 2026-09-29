/* brp__pick_sector_cfg @ 0x93cc90, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__pick_sector_cfg
brp__pick_sector_cfg:
	.global L_93cc90
L_93cc90:
	push_s r13
L_93cc92:
	mov_s r3,0x80088c
L_93cc98:
	ld_s r1,[r3]
L_93cc9a:
	mov_s r2,0x801ff4
L_93cca0:
	breq_s r1,0,L_93ccce
L_93cca2:
	mov_s r1,0x801504
L_93cca8:
	ldb_s r13,[r1,0x2]
L_93ccaa:
	ldb_s r1,[r3,0x9]
L_93ccac:
	brlt r13,r1,L_93ccba
L_93ccb0:
	ldb_s r1,[r3,0x8]
L_93ccb2:
	stb_s r1,[r2]
L_93ccb4:
	ldb.x r1,[r3, 0x6]
L_93ccb8:
	b_s L_93ccde
	.global L_93ccba
L_93ccba:
	mov_s r1,0x800824
L_93ccc0:
	ld_s r1,[r1]
L_93ccc2:
	lsr_s r1,r1,0xf
L_93ccc4:
	bmsk_s r1,r1,0x5
L_93ccc6:
	stb_s r1,[r2]
L_93ccc8:
	ldb.x r1,[r3, 0x5]
L_93cccc:
	b_s L_93ccde
	.global L_93ccce
L_93ccce:
	mov_s r1,0x800824
L_93ccd4:
	ld_s r1,[r1]
L_93ccd6:
	lsr_s r1,r1,0xf
L_93ccd8:
	bmsk_s r1,r1,0x5
L_93ccda:
	stb_s r1,[r2]
L_93ccdc:
	mov_s r1,0x0
	.global L_93ccde
L_93ccde:
	stb_s r1,[r2,0x1]
L_93cce0:
	add r1,r0,0x80066c
L_93cce8:
	ldb_s r0,[r1,0xc]
L_93ccea:
	lsr r1,r0,0x6
L_93ccee:
	bmsk.f 0x0,r1,0x1
L_93ccf2:
	beq_s L_93ccf8
L_93ccf4:
	bmsk_s r0,r0,0x5
L_93ccf6:
	stb_s r0,[r2]
	.global L_93ccf8
L_93ccf8:
	mov_s r0,0x0
L_93ccfa:
	stb_s r0,[r2,0x2]
L_93ccfc:
	j_s.d [blink]
L_93ccfe:
	pop_s r13
