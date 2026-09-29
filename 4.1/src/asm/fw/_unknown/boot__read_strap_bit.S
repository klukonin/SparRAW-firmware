/* boot__read_strap_bit @ 0x8d7244, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.boot__read_strap_bit,"ax",@progbits
	.global boot__read_strap_bit
boot__read_strap_bit:
	.global L_8d7244
L_8d7244:
	mov_s r1,0x11
L_8d7246:
	asl_s r1,r1,0x13
L_8d7248:
	ld_s r0,[r1,0x1c]
L_8d724a:
	btst_s r0,0x0
L_8d724c:
	mov.ne r0,0x1
L_8d7250:
	bne_s L_8d7258
L_8d7252:
	bset_s r0,r0,0x0
L_8d7254:
	st_s r0,[r1,0x1c]
L_8d7256:
	mov_s r0,0x0
	.global L_8d7258
L_8d7258:
	j_s [blink]
L_8d725a:
	nop_s
