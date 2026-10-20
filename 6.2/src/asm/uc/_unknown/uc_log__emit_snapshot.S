/* uc_log__emit_snapshot @ 0x92d13c, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_initiator_brp_transaction_flow, bti__bi2_event_step, disable_tsf_event, fixed_sched_manager__decrement_curr_sta_rd_counter, hwd_phy_pwr, hwd_rfc_powerdown_deep_all_rfs, hwd_rfc_powerup_deep_all_rfs, hwd_rfc_write_core, mailbox_debug_dump_uc, mtp_queue__release_mgmt
 * Зовёт сам: uc_sysassert__snapshot_mac
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_log__emit_snapshot
uc_log__emit_snapshot:
	.global L_92d13c
L_92d13c:
	st.a r13,[sp,-0xc]
L_92d140:
	st blink,[sp, 0x4]
L_92d144:
	st_s r14,[sp,0x8]
L_92d146:
	bmsk r11,r0,0x3
L_92d14a:
	lsr_s r0,r0,0x4
L_92d14c:
	mov_s r13,0x803234
L_92d152:
	add r7,r13,0x4
L_92d156:
	ldb r4,[r7,r11]
L_92d15a:
	bmsk_s r0,r0,0x1
L_92d15c:
	sub sp,sp,0x8
L_92d160:
	bbit0.d r4,r0,L_92d1c0
L_92d164:
	mov_s r14,r1
L_92d166:
	mov_s r1,sp
L_92d168:
	mov r0,0x0
L_92d16c:
	bl.d L_93756c
L_92d170:
	mov r2,r0
L_92d174:
	ld r8,[sp, 0x4]
L_92d178:
	mov r10,0xff
L_92d17c:
	cmp r8,0xff
L_92d180:
	mov.cc r2,r10
L_92d184:
	ld_s r1,[r13]
L_92d186:
	mov.cs r2,r8
L_92d18a:
	add r9,r1,0x1
L_92d18e:
	extb r9,r9
L_92d192:
	ld r5,[sp]
L_92d196:
	add2 r9,r13,r9
L_92d19a:
	st r5,[r9, 0x14]
L_92d19e:
	bmsk r3,r14,0x13
L_92d1a2:
	or r3,r3,0xa0000000
L_92d1aa:
	extb_s r2,r2
L_92d1ac:
	asl_s r2,r2,0x12
L_92d1ae:
	or_s r2,r2,r3
L_92d1b0:
	extb r6,r1
L_92d1b4:
	add2 r6,r13,r6
L_92d1b8:
	st r2,[r6, 0x14]
L_92d1bc:
	/* add_s r1,0x2 */
	.byte 0x02,0xe1
L_92d1be:
	st_s r1,[r13]
	.global L_92d1c0
L_92d1c0:
	add_s sp,sp,0x8
L_92d1c2:
	ld blink,[sp, 0x4]
L_92d1c6:
	ld_s r14,[sp,0x8]
L_92d1c8:
	j.d [blink]
L_92d1cc:
	ld.ab r13,[sp,0xc]
