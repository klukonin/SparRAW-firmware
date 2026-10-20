/* uc_send_event @ 0x925dd8, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sending event=0x%x ,curr tsf 0x%08x %08x
 * Зовут его: uc_send_evt__bf_done, uc_send_evt__get_rf_sector_done, uc_send_evt__link_lost, uc_send_evt__mac_monitor, uc_send_evt__new_link, uc_send_evt__ps_awake_peer, uc_send_evt__ps_shallow_sleep_ntf, uc_send_evt__ps_wake_pcie, uc_send_evt__rs_done, uc_send_evt__rs_started
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, basic_if__post_to_fw_mailbox, uc_read_tsf64
 */
	.section .text.uc_send_event,"ax",@progbits
	.global uc_send_event
uc_send_event:
	.global L_925dd8
L_925dd8:
	push_s blink
L_925dda:
	bl L_920210
L_925dde:
	st.a r0,[sp,-0x14]
L_925de2:
	mov_s r13,r1
L_925de4:
	st_s r2,[sp,0x4]
L_925de6:
	st_s r3,[sp,0x8]
L_925de8:
	bl.d L_930cb0
L_925dec:
	add_s r0,sp,0xc
L_925dee:
	mov_s r2,0x80209c
L_925df4:
	ldb_s r0,[r2,0x4]
L_925df6:
	mov_s r1,0x1001138
L_925dfc:
	bbit0 r0,0x2,L_925e3e
L_925e00:
	ld_s r0,[r2]
L_925e02:
	ld_s r14,[sp,0xc]
L_925e04:
	add_s r15,r0,0x3
L_925e06:
	extb_s r15,r15
L_925e08:
	mov_s r3,0x8020b0
L_925e0e:
	add2 r15,r3,r15
L_925e12:
	st_s r14,[r15]
L_925e14:
	add_s r15,r0,0x2
L_925e16:
	extb_s r15,r15
L_925e18:
	ld_s r14,[sp,0x10]
L_925e1a:
	add2 r15,r3,r15
L_925e1e:
	st_s r14,[r15]
L_925e20:
	add_s r14,r0,0x1
L_925e22:
	extb_s r14,r14
L_925e24:
	add2 r14,r3,r14
L_925e28:
	st_s r13,[r14]
L_925e2a:
	bmsk_s r1,r1,0x13
L_925e2c:
	or r1,r1,0xae000000
L_925e34:
	extb_s r14,r0
L_925e36:
	add2_s r3,r3,r14
L_925e38:
	st_s r1,[r3]
L_925e3a:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_925e3c:
	st_s r0,[r2]
	.global L_925e3e
L_925e3e:
	mov_s r3,0x0
L_925e40:
	ld_s r1,[sp,0x0]
L_925e42:
	mov_s r0,0x801618
L_925e48:
	ld r4,[sp, 0x4]
L_925e4c:
	mov_s r2,r13
L_925e4e:
	ld r5,[sp, 0x8]
L_925e52:
	mov_s r6,r3
L_925e54:
	bl.d L_930150
L_925e58:
	mov_s r7,r3
L_925e5a:
	mov r1,0x200
L_925e5e:
	mov_s r0,0x880b00
L_925e64:
	st_s r1,[r0,0x58]
L_925e66:
	sync
L_925e6a:
	b.d L_92027c
L_925e6e:
	add_s sp,sp,0x14
