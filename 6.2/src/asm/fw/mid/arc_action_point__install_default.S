/* arc_action_point__install_default @ 0x8c3b68, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: arc_action_point__arm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global arc_action_point__install_default
arc_action_point__install_default:
	.global L_8c3b68
L_8c3b68:
	push_s blink
L_8c3b6a:
	mov_s r1,0x1
L_8c3b6c:
	st.a r1,[sp,-0x20]
L_8c3b70:
	st_s r1,[sp,0x1c]
L_8c3b72:
	mov_s r2,0x0
L_8c3b74:
	st_s r2,[sp,0x14]
L_8c3b76:
	st_s r2,[sp,0x18]
L_8c3b78:
	mov_s r1,0x2
L_8c3b7a:
	st_s r1,[sp,0xc]
L_8c3b7c:
	mov_s r1,0x3
L_8c3b7e:
	st_s r1,[sp,0x10]
L_8c3b80:
	st_s r2,[sp,0x4]
L_8c3b82:
	st_s r0,[sp,0x8]
L_8c3b84:
	bl.d L_8c3af0
L_8c3b88:
	mov_s r0,sp
L_8c3b8a:
	add_s sp,sp,0x20
L_8c3b8c:
	pop_s blink
L_8c3b8e:
	j_s [blink]
