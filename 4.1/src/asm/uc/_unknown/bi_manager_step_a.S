/* bi_manager_step_a @ 0x922a34, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__enter_dti
 * Зовёт сам: memset0_words_uc, rw_g_800994, sxd_hal__mac_select_indexed, uc_read_bi_sync
 */
	.section .text.bi_manager_step_a,"ax",@progbits
	.global bi_manager_step_a
bi_manager_step_a:
	.global L_922a34
L_922a34:
	st.a r13,[sp,-0xc]
L_922a38:
	st blink,[sp, 0x4]
L_922a3c:
	mov r13,0x0
L_922a40:
	bl.d L_9250a8
L_922a44:
	mov r0,r13
L_922a48:
	ldb r6,[0x801034]
L_922a50:
	st_s r14,[sp,0x8]
L_922a52:
	mov_s r14,0x801e68
L_922a58:
	breq r6,0x0,L_922ad8
L_922a5c:
	ld r4,[0x8009e8]
L_922a64:
	brne r4,0x0,L_922ad8
L_922a68:
	ldb r2,[r14]
L_922a6c:
	breq r2,0x0,L_922ad8
L_922a70:
	mov r8,0x801b08
L_922a78:
	mov r9,0x801038
L_922a80:
	ldw r10,[r9, 0x14]
L_922a84:
	ldw r1,[r8, 0x22]
L_922a88:
	st r13,[r8, 0x18]
L_922a8c:
	brne.d r1,r10,L_922aa0
L_922a90:
	norm r11,r6
L_922a94:
	ldw r7,[r9, 0x12]
L_922a98:
	ldw r3,[r8, 0x20]
L_922a9c:
	breq r3,r7,L_922aa8
	.global L_922aa0
L_922aa0:
	ld r0,[r8, 0x10]
L_922aa4:
	breq r0,0x0,L_922ab8
	.global L_922aa8
L_922aa8:
	st r13,[r8, 0x14]
L_922aac:
	st r13,[r8, 0x10]
L_922ab0:
	b.d L_922ac4
L_922ab4:
	st r13,[r8, 0x1c]
	.global L_922ab8
L_922ab8:
	ld r7,[r8, 0x14]
L_922abc:
	add r7,r7,0x1
L_922ac0:
	st r7,[r8, 0x14]
	.global L_922ac4
L_922ac4:
	mov r10,0x886000
L_922acc:
	ld r5,[r10, 0x24]
L_922ad0:
	bset r5,r5,0x1f
L_922ad4:
	st r5,[r10, 0x24]
	.global L_922ad8
L_922ad8:
	bl L_931c64
L_922adc:
	cmp r0,0x0
L_922ae0:
	bl.ne L_92a5ec
L_922ae4:
	mov r0,r14
L_922ae8:
	bl.d L_92166c
L_922aec:
	mov r1,0x18
L_922af0:
	ld blink,[sp, 0x4]
L_922af4:
	ld_s r14,[sp,0x8]
L_922af6:
	j_s.d [blink]
L_922af8:
	ld.ab r13,[sp,0xc]
