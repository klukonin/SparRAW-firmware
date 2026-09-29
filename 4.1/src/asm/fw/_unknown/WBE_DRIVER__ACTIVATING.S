/* WBE_DRIVER__ACTIVATING @ 0x8ddc3c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::ACTIVATING PXE
 * Зовёт сам: WBE_DRIVER__pxe_isoc_in_dir_bypass, fw_log__emit0, set_reg_88268c_x2, set_reg_88268c_x2_8f2920, set_reg_88268c_x2_8f2930
 * Глобалы (через gp): 0x800428, 0x80042c
 */
	.section .text.WBE_DRIVER__ACTIVATING,"ax",@progbits
	.global WBE_DRIVER__ACTIVATING
WBE_DRIVER__ACTIVATING:
L_8ddc3c:
	push_s blink
L_8ddc3e:
	mov_s r0,0x0
L_8ddc40:
	st.as r0,[gp,-0x10]
L_8ddc44:
	mov_s r2,0x1003dd4
L_8ddc4a:
	mov_s r0,0xf
L_8ddc4c:
	bl.d L_8edfb0
L_8ddc50:
	mov_s r1,0x2
L_8ddc52:
	ld_s r0,[gp,0x2bc]
L_8ddc54:
	cmp_s r0,0x0
L_8ddc56:
	bl.ne L_8f2930
L_8ddc5a:
	ld_s r0,[gp,0x2b8]
L_8ddc5c:
	breq_s r0,0,L_8ddc6c
L_8ddc5e:
	bl.d L_8efae8
L_8ddc62:
	mov_s r0,0x0
L_8ddc64:
	bl L_8f2910
L_8ddc68:
	bl L_8f2920
	.global L_8ddc6c
L_8ddc6c:
	mov_s r1,0x882d80
L_8ddc72:
	ld_s r0,[r1,0x54]
L_8ddc74:
	bset_s r0,r0,0x1f
L_8ddc76:
	st_s r0,[r1,0x54]
L_8ddc78:
	pop_s blink
L_8ddc7a:
	j_s [blink]
