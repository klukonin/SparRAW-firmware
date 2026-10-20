/* pcie__clear_cpl_timeout @ 0x8fa818, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dpal__cpl_timeout_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__clear_cpl_timeout
pcie__clear_cpl_timeout:
	.global L_8fa818
L_8fa818:
	mov r1,0x3e7
L_8fa81c:
	mov_s r0,0x882d00
L_8fa822:
	st_s r1,[r0,0x4]
L_8fa824:
	mov_s r0,0x882680
L_8fa82a:
	st 0x1000,[r0, 0xc]
L_8fa832:
	st 0x1000,[r0, 0x20]
L_8fa83a:
	j_s [blink]
