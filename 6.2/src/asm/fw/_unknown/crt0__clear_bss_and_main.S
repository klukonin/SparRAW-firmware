/* crt0__clear_bss_and_main @ 0x8c168c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: crt0__jump_to_rom_3c364, fw_main, memset0_words
 * Глобалы (через gp): 0x8002a0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global crt0__clear_bss_and_main
crt0__clear_bss_and_main:
L_8c168c:
	push_s blink
L_8c168e:
	ld_s r0,[gp,0x11c]
L_8c1690:
	breq_s r0,0,L_8c16b6
L_8c1692:
	mov_s r0,0x803b70
L_8c1698:
	mov_s r1,0x8067dc
L_8c169e:
	bl.d L_8c1cd8
L_8c16a2:
	sub_s r1,r1,r0
L_8c16a4:
	/* mov_s r0,0x0 */
	.byte 0xcf,0x70,0x00,0x00,0x00,0x00
L_8c16aa:
	/* mov_s r1,0x0 */
	.byte 0xcf,0x71,0x00,0x00,0x00,0x00
L_8c16b0:
	bl.d L_8c1cd8
L_8c16b4:
	sub_s r1,r1,r0
	.global L_8c16b6
L_8c16b6:
	mov_s r0,0x840000
L_8c16bc:
	mov_s r1,0x84e81c
L_8c16c2:
	bl.d L_8c1cd8
L_8c16c6:
	sub_s r1,r1,r0
L_8c16c8:
	mov_s r0,0x857000
L_8c16ce:
	mov_s r1,0x857828
L_8c16d4:
	bl.d L_8c1cd8
L_8c16d8:
	sub_s r1,r1,r0
L_8c16da:
	mov_s r0,0x854000
L_8c16e0:
	mov_s r1,0x8552f4
L_8c16e6:
	bl.d L_8c1cd8
L_8c16ea:
	sub_s r1,r1,r0
L_8c16ec:
	mov_s r0,0x0
L_8c16ee:
	bl.d L_8c1d6c
L_8c16f2:
	stb r0,[gp, 0x92]
L_8c16f6:
	bl L_8f00dc
L_8c16fa:
	pop_s blink
L_8c16fc:
	j_s [blink]
L_8c16fe:
	nop_s
