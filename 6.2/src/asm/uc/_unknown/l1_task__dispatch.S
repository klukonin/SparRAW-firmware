/* l1_task__dispatch @ 0x934e30, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__bti_timer_step, bi__run_bti_cycle, bti__dispatch_sweep_step, l1__on_event4, l1_task__main_step, l1_task__phase_of, l1_task__report_link_lost
 * Зовёт сам: bi_timing_snapshot_b, l1__snapshot_bi_counter, l1_task__reset_units, mac_prog__cmd02_body, peer_slots__scan_by_masks, uc_sm__handle_event, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__dispatch
l1_task__dispatch:
	.global L_934e30
L_934e30:
	st.a r13,[sp,-0x8]
L_934e34:
	cmp r0,0x6
L_934e38:
	st blink,[sp, 0x4]
L_934e3c:
	bhi.d L_934f30
L_934e40:
	mov_s r13,r1
L_934e42:
	ld.as r1,[0x801ac0,r0]
L_934e4a:
	j_s [r1]
L_934e4c:
	mov r5,0x801030
L_934e54:
	ldb r4,[r5, 0x50]
L_934e58:
	mov_s r2,0x1
L_934e5a:
	cmp r4,0x0
L_934e5e:
	sub_s.ne r2,r2,r2
L_934e60:
	bl.d L_922354
L_934e64:
	stb r2,[r5, 0x50]
L_934e68:
	add_s r0,gp,0xd8
L_934e6a:
	mov_s r1,0x0
L_934e6c:
	bl.d L_92b6fc
L_934e70:
	mov r2,r13
L_934e74:
	ld blink,[sp, 0x4]
L_934e78:
	j.d [blink]
L_934e7c:
	ld.ab r13,[sp,0x8]
L_934e80:
	add_s r0,gp,0xd8
L_934e82:
	mov_s r1,0x2
L_934e84:
	bl.d L_92b6fc
L_934e88:
	mov r2,0x0
L_934e8c:
	bl L_93cd2c
L_934e90:
	bl L_92ec50
L_934e94:
	ld blink,[sp, 0x4]
L_934e98:
	j.d [blink]
L_934e9c:
	ld.ab r13,[sp,0x8]
L_934ea0:
	add_s r0,gp,0xd8
L_934ea2:
	b.d L_934ee4
L_934ea6:
	mov_s r1,0x1
L_934ea8:
	bl L_93cd2c
L_934eac:
	bl L_92ec50
L_934eb0:
	add_s r0,gp,0xd8
L_934eb2:
	b.d L_934ee4
L_934eb6:
	mov_s r1,0x2
L_934eb8:
	bl L_93cd2c
L_934ebc:
	bl L_9239dc
L_934ec0:
	ld.as r1,[gp,-0x33]
L_934ec4:
	add r13,gp,0xd8
L_934ecc:
	breq_s r1,0,L_934ef8
L_934ece:
	ld_s r0,[gp,-0x94]
L_934ed0:
	brne_s r0,0,L_934ef8
L_934ed2:
	ld r3,[0x8022a8]
L_934eda:
	breq r3,0x2,L_934ef8
L_934ede:
	mov_s r0,r13
L_934ee0:
	mov r1,0x3
	.global L_934ee4
L_934ee4:
	bl.d L_92b6fc
L_934ee8:
	mov r2,0x0
L_934eec:
	ld blink,[sp, 0x4]
L_934ef0:
	j.d [blink]
L_934ef4:
	ld.ab r13,[sp,0x8]
	.global L_934ef8
L_934ef8:
	bl L_921460
L_934efc:
	mov r0,r13
L_934f00:
	b.d L_934ee4
L_934f04:
	mov r1,0x2
L_934f08:
	bl L_921460
L_934f0c:
	add_s r0,gp,0xd8
L_934f0e:
	b.d L_934ee4
L_934f12:
	mov_s r1,0x4
L_934f14:
	brne_s r13,0,L_934f48
L_934f16:
	add_s r0,gp,0xd8
L_934f18:
	mov r1,0x0
L_934f1c:
	bl.d L_92b6fc
L_934f20:
	mov r2,0x1
L_934f24:
	ld blink,[sp, 0x4]
L_934f28:
	j.d [blink]
L_934f2c:
	ld.ab r13,[sp,0x8]
	.global L_934f30
L_934f30:
	mov r0,blink
L_934f34:
	bl.d L_926618
L_934f38:
	mov r1,0x5c
L_934f3c:
	ld blink,[sp, 0x4]
L_934f40:
	j.d [blink]
L_934f44:
	ld.ab r13,[sp,0x8]
	.global L_934f48
L_934f48:
	ld blink,[sp, 0x4]
L_934f4c:
	j.d [blink]
L_934f50:
	ld.ab r13,[sp,0x8]
