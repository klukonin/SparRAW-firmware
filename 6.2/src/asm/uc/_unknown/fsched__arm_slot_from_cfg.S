/* fsched__arm_slot_from_cfg @ 0x935a6c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: get_mem_857744_x2, sxd_hal__write_qset_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__arm_slot_from_cfg
fsched__arm_slot_from_cfg:
	.global L_935a6c
L_935a6c:
	push_s blink
L_935a6e:
	mov_s r0,0x801be8
L_935a74:
	bl L_927a34
L_935a78:
	mulu64 r0,0xa5
L_935a7c:
	mov_s r0,0x0
L_935a7e:
	bl.d L_934f54
L_935a82:
	mov_s r1,mlo
L_935a84:
	mov_s r1,0x1
L_935a86:
	mov_s r0,0x80064c
L_935a8c:
	st_s r1,[r0]
L_935a8e:
	mov_s r0,0x0
L_935a90:
	pop_s blink
L_935a92:
	j_s [blink]
