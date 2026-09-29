/* boot__publish_ids @ 0x8e8578, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Глобалы (через gp): 0x800200, 0x800202
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__publish_ids
boot__publish_ids:
	.global L_8e8578
L_8e8578:
	ld_s r0,[gp,-0x12c]
L_8e857a:
	ld.as r1,[gp,-0x6]
L_8e857e:
	stb r0,[r1, 0x2c]
L_8e8582:
	ld_s r0,[gp,-0x12c]
L_8e8584:
	ld.as r1,[gp,-0x6]
L_8e8588:
	and r0,r0,0xff00
L_8e8590:
	lsr_s r0,r0,0x8
L_8e8592:
	stb r0,[r1, 0x2d]
L_8e8596:
	ld_s r0,[gp,-0x12c]
L_8e8598:
	ld.as r1,[gp,-0x6]
L_8e859c:
	and r0,r0,0xff0000
L_8e85a4:
	lsr_s r0,r0,0x10
L_8e85a6:
	stb r0,[r1, 0x2e]
L_8e85aa:
	ld_s r0,[gp,-0x12c]
L_8e85ac:
	ld.as r1,[gp,-0x6]
L_8e85b0:
	and r0,r0,0xff000000
L_8e85b8:
	lsr_s r0,r0,0x18
L_8e85ba:
	stb r0,[r1, 0x2f]
L_8e85be:
	ldb r1,[gp, 0xec]
L_8e85c2:
	ld_s r0,[gp,-0x18]
L_8e85c4:
	st_s r1,[r0,0x28]
L_8e85c6:
	mov_s r0,0x803c00
L_8e85cc:
	ld_s r1,[r0,0x20]
L_8e85ce:
	btst_s r1,0xc
L_8e85d0:
	mov_s r0,0x64
L_8e85d2:
	mov.eq r0,0x17
L_8e85d6:
	stw.as r0,[gp,0x3f]
L_8e85da:
	btst_s r1,0xc
L_8e85dc:
	mov r0,0x5dc
L_8e85e0:
	mov.eq r0,0x320
L_8e85e8:
	j_s.d [blink]
L_8e85ea:
	stw.as r0,[gp,0x3e]
L_8e85ee:
	nop_s
