/* fw_boot__clear_bss @ 0x8c165c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: WBE_DRIVER__pcie_boot_init, fw_boot__jump_reset, memset0_words
 * Глобалы (через gp): 0x80028c
 */
	.section .text.fw_boot__clear_bss,"ax",@progbits
	.global fw_boot__clear_bss
fw_boot__clear_bss:
L_8c165c:
	push_s blink
L_8c165e:
	ld_s r0,[gp,0x11c]
L_8c1660:
	breq_s r0,0,L_8c1686
L_8c1662:
	mov_s r0,0x8033cc
L_8c1668:
	mov_s r1,0x806784
L_8c166e:
	bl.d L_8c1a78
L_8c1672:
	sub_s r1,r1,r0
L_8c1674:
	/* mov_s r0,0x0 */
	.byte 0xcf,0x70,0x00,0x00,0x00,0x00
L_8c167a:
	/* mov_s r1,0x0 */
	.byte 0xcf,0x71,0x00,0x00,0x00,0x00
L_8c1680:
	bl.d L_8c1a78
L_8c1684:
	sub_s r1,r1,r0
	.global L_8c1686
L_8c1686:
	mov_s r0,0x840000
L_8c168c:
	mov_s r1,0x84ee7c
L_8c1692:
	bl.d L_8c1a78
L_8c1696:
	sub_s r1,r1,r0
L_8c1698:
	mov_s r0,0x857000
L_8c169e:
	mov_s r1,0x8572a8
L_8c16a4:
	bl.d L_8c1a78
L_8c16a8:
	sub_s r1,r1,r0
L_8c16aa:
	mov_s r0,0x850800
L_8c16b0:
	mov_s r1,0x852d00
L_8c16b6:
	bl.d L_8c1a78
L_8c16ba:
	sub_s r1,r1,r0
L_8c16bc:
	mov_s r0,0x0
L_8c16be:
	bl.d L_8c1b0c
L_8c16c2:
	stb r0,[gp, 0x8e]
L_8c16c6:
	bl L_8e8a1c
L_8c16ca:
	pop_s blink
