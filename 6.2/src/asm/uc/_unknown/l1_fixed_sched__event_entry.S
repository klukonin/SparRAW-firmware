/* l1_fixed_sched__event_entry @ 0x92cd94, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc__check_g8004f4_0_1_2
 * Зовёт сам: l1_fixed_sched_ap_sm, l1_fixed_sched_sta_sm
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_fixed_sched__event_entry
l1_fixed_sched__event_entry:
	.global L_92cd94
L_92cd94:
	mov_s r0,r54
L_92cd96:
	bbit0 r0,0xf,L_92cdae
L_92cd9a:
	mov_s r0,0x49008000
L_92cda0:
	mov_s r32,r0
L_92cda2:
	st.ab r0,[r25,0x4]
L_92cda6:
	bclr r25,r25,0xa
L_92cdaa:
	mov_s r1,0x4
L_92cdac:
	b_s L_92cdc6
	.global L_92cdae
L_92cdae:
	mov_s r0,r54
L_92cdb0:
	bbit0 r0,0x11,L_92cdc4
L_92cdb4:
	mov_s r0,0x49020000
L_92cdba:
	mov_s r32,r0
L_92cdbc:
	st.ab r0,[r25,0x4]
L_92cdc0:
	bclr r25,r25,0xa
	.global L_92cdc4
L_92cdc4:
	mov_s r1,0x0
	.global L_92cdc6
L_92cdc6:
	breq_s r1,0,L_92cdd6
L_92cdc8:
	ld_s r0,[gp,-0x34]
L_92cdca:
	cmp_s r0,0x1
L_92cdcc:
	mov_s r0,r1
L_92cdce:
	beq L_92c66c
L_92cdd2:
	b L_92c840
	.global L_92cdd6
L_92cdd6:
	j_s [blink]
