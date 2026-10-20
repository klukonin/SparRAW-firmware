/* rf__set_normal_mode @ 0x92abe4, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__power_sequence_rf
 * Зовёт сам: abif__set_88a204_field, abif__set_enable_bit, hwd_phy__set_mode_uc, hwd_phy__uses_rgf_883000, hwd_phy__uses_rgf_884000, mac__core_write_3d_0200, mac__core_write_3e_then_3d_0007
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf__set_normal_mode
rf__set_normal_mode:
	.global L_92abe4
L_92abe4:
	push_s r13
L_92abe6:
	mov_s r6,r0
L_92abe8:
	mov r13,blink
L_92abec:
	brne.d r6,0x1,L_92ac14
L_92abf0:
	mov r0,0x0
L_92abf4:
	bl L_92999c
L_92abf8:
	bl.d L_929960
L_92abfc:
	mov r0,0x0
L_92ac00:
	bl L_92960c
L_92ac04:
	bl L_9295f4
L_92ac08:
	bl.d L_928b4c
L_92ac0c:
	mov r0,0x1
L_92ac10:
	b L_92ac78
	.global L_92ac14
L_92ac14:
	bl L_928b4c
L_92ac18:
	mov r5,0x88a000
L_92ac20:
	ld.as r2,[r5,0x81]
L_92ac24:
	or r2,r2,0x7e000
L_92ac2c:
	st.as r2,[r5,0x81]
L_92ac30:
	ldb r3,[gp, -0xfe]
L_92ac34:
	breq r3,0x0,L_92ac44
L_92ac38:
	ldb r1,[gp, -0xff]
L_92ac3c:
	b.d L_92ac48
L_92ac40:
	mov r0,0x1
	.global L_92ac44
L_92ac44:
	mov_s r0,0x0
L_92ac46:
	mov_s r1,r0
	.global L_92ac48
L_92ac48:
	bl L_928cd8
L_92ac4c:
	ldb r4,[gp, -0xfd]
L_92ac50:
	cmp r4,0x0
L_92ac54:
	mov r0,0x1
L_92ac58:
	mov.eq r0,0x0
L_92ac5c:
	bl L_9299d8
L_92ac60:
	bl L_92960c
L_92ac64:
	bl L_9295f4
L_92ac68:
	bl.d L_92999c
L_92ac6c:
	mov r0,0x1
L_92ac70:
	bl.d L_929960
L_92ac74:
	mov r0,0x1
	.global L_92ac78
L_92ac78:
	mov_s blink,r13
L_92ac7a:
	j_s.d [blink]
L_92ac7c:
	pop_s r13
L_92ac7e:
	nop_s
