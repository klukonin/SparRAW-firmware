/* WBE_DRIVER__CLOSE @ 0x8f17d8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::CLOSE IDLES
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, WBE_DRIVER__link_down, disc_sm__sw_data_stopped
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.WBE_DRIVER__CLOSE,"ax",@progbits
	.global WBE_DRIVER__CLOSE
WBE_DRIVER__CLOSE:
	.global L_8f17d8
L_8f17d8:
	push_s blink
L_8f17da:
	push_s r13
L_8f17dc:
	mov_s r2,0x100335c
L_8f17e2:
	mov_s r0,0xf
L_8f17e4:
	mov_s r13,0x2
L_8f17e6:
	bl.d L_8edfb0
L_8f17ea:
	mov_s r1,r13
L_8f17ec:
	mov_s r0,0x882a00
L_8f17f2:
	st_s r13,[r0,0x74]
L_8f17f4:
	b L_8c033c
