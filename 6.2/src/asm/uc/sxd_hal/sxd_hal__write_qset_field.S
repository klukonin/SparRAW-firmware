/* sxd_hal__write_qset_field @ 0x934f54, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__start_window, bi__dti_step, fsched__arm_slot_from_cfg, fsched__arm_slot_timer, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap_sm, l1_fixed_sched_sta_sm
 * Зовёт сам: mac_evt__select_timer_group, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sxd_hal__write_qset_field
sxd_hal__write_qset_field:
	.global L_934f54
L_934f54:
	st.a r13,[sp,-0xc]
L_934f58:
	st blink,[sp, 0x4]
L_934f5c:
	st_s r14,[sp,0x8]
L_934f5e:
	mov_s r14,r0
L_934f60:
	and.f 0x0,r1,0xff000000
L_934f68:
	bne.d L_934fe0
L_934f6c:
	mov r13,r1
	.global L_934f70
L_934f70:
	bl.d L_9258e0
L_934f74:
	mov r0,r14
L_934f78:
	asl r0,r14,0x14
L_934f7c:
	and r0,r0,0xf00000
L_934f84:
	or r0,r0,0x68000000
L_934f8c:
	mov r32,r0
L_934f90:
	st.ab r0,[r25,0x4]
L_934f94:
	bclr r25,r25,0xa
L_934f98:
	nop_s
L_934f9a:
	nop_s
L_934f9c:
	nop_s
L_934f9e:
	or r13,r13,0x67000000
L_934fa6:
	mov_s r32,r13
L_934fa8:
	st.ab r13,[r25,0x4]
L_934fac:
	bclr r25,r25,0xa
L_934fb0:
	nop_s
L_934fb2:
	nop_s
L_934fb4:
	nop_s
L_934fb6:
	asl r1,r14,0x14
L_934fba:
	and r1,r1,0xf00000
L_934fc2:
	or r1,r1,0x6800000b
L_934fca:
	mov_s r32,r1
L_934fcc:
	st.ab r1,[r25,0x4]
L_934fd0:
	bclr r25,r25,0xa
L_934fd4:
	ld blink,[sp, 0x4]
L_934fd8:
	ld_s r14,[sp,0x8]
L_934fda:
	j_s.d [blink]
L_934fdc:
	ld.ab r13,[sp,0xc]
	.global L_934fe0
L_934fe0:
	mov r0,blink
L_934fe4:
	bl.d L_926618
L_934fe8:
	mov r1,0x53
L_934fec:
	b_s L_934f70
L_934fee:
	nop_s
