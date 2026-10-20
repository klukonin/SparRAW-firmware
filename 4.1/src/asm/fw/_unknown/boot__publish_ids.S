/* boot__publish_ids @ 0x8e3524, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Глобалы (через gp): 0x8001e8, 0x8001ea, 0x800258
 */
	.section .text.boot__publish_ids,"ax",@progbits
	.global boot__publish_ids
boot__publish_ids:
	.global L_8e3524
L_8e3524:
	ld.as r3,[gp,-0x3]
L_8e3528:
	ld_s r0,[gp,-0x114]
L_8e352a:
	add3 r2,r3,0x8
L_8e352e:
	stb_s r0,[r2]
L_8e3530:
	and r1,r0,0xff00
L_8e3538:
	lsr_s r1,r1,0x8
L_8e353a:
	stb_s r1,[r2,0x1]
L_8e353c:
	and r1,r0,0xff0000
L_8e3544:
	lsr_s r1,r1,0x10
L_8e3546:
	and r0,r0,0xff000000
L_8e354e:
	lsr_s r0,r0,0x18
L_8e3550:
	stb_s r0,[r2,0x3]
L_8e3552:
	ldb_s r0,[gp,0xe8]
L_8e3554:
	stb_s r1,[r2,0x2]
L_8e3556:
	st_s r0,[r3,0x3c]
L_8e3558:
	mov_s r0,0x80345c
L_8e355e:
	ld_s r1,[r0,0x18]
L_8e3560:
	btst_s r1,0xc
L_8e3562:
	mov_s r0,0x64
L_8e3564:
	mov.eq r0,0x17
L_8e3568:
	stw.as r0,[gp,0x3d]
L_8e356c:
	btst_s r1,0xc
L_8e356e:
	mov r0,0x5dc
L_8e3572:
	mov.eq r0,0x320
L_8e357a:
	j_s.d [blink]
L_8e357c:
	stw.as r0,[gp,0x3c]
