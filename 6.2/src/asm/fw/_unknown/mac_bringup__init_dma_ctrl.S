/* mac_bringup__init_dma_ctrl @ 0x8fa7e8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__init_dma_ctrl
mac_bringup__init_dma_ctrl:
	.global L_8fa7e8
L_8fa7e8:
	mov_s r0,0x5
L_8fa7ea:
	mov_s r1,0x886a00
L_8fa7f0:
	st_s r0,[r1]
L_8fa7f2:
	mov_s r0,0x9
L_8fa7f4:
	st_s r0,[r1,0x4]
L_8fa7f6:
	j_s [blink]
