/* arc_action_point__install_default @ 0x8e96e8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: arc_action_point__arm
 */
	.section .text.arc_action_point__install_default,"ax",@progbits
	.global arc_action_point__install_default
arc_action_point__install_default:
	.global L_8e96e8
L_8e96e8:
	push_s blink
L_8e96ea:
	mov_s r1,0x1
L_8e96ec:
	st.a r1,[sp,-0x20]
L_8e96f0:
	st_s r1,[sp,0x1c]
L_8e96f2:
	mov_s r2,0x0
L_8e96f4:
	st_s r2,[sp,0x14]
L_8e96f6:
	st_s r2,[sp,0x18]
L_8e96f8:
	mov_s r1,0x2
L_8e96fa:
	st_s r1,[sp,0xc]
L_8e96fc:
	mov_s r1,0x3
L_8e96fe:
	st_s r1,[sp,0x10]
L_8e9700:
	st_s r2,[sp,0x4]
L_8e9702:
	st_s r0,[sp,0x8]
L_8e9704:
	bl.d L_8e9668
L_8e9708:
	mov_s r0,sp
L_8e970a:
	add_s sp,sp,0x20
L_8e970c:
	pop_s blink
L_8e970e:
	j_s [blink]
