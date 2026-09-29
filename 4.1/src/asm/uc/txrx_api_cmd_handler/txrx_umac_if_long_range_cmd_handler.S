/* txrx_umac_if_long_range_cmd_handler @ 0x934fdc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txrx_umac_if_long_range_cmd_handler Long Range is now enabled
 * Зовут его: umac_if_cmd_handler
 */
	.section .text.txrx_umac_if_long_range_cmd_handler,"ax",@progbits
	.global txrx_umac_if_long_range_cmd_handler
txrx_umac_if_long_range_cmd_handler:
	.global L_934fdc
L_934fdc:
	push_s r13
L_934fde:
	mov_s r2,0x80209c
L_934fe4:
	ldb_s r0,[r2,0x4]
L_934fe6:
	mov_s r1,0x10019e4
L_934fec:
	bbit0 r0,0x2,L_93500a
L_934ff0:
	bmsk_s r1,r1,0x13
L_934ff2:
	bset_s r1,r1,0x19
L_934ff4:
	bset_s r1,r1,0x1d
L_934ff6:
	ld_s r0,[r2]
L_934ff8:
	bset_s r1,r1,0x1f
L_934ffa:
	extb_s r13,r0
L_934ffc:
	mov_s r3,0x8020b0
L_935002:
	add2_s r3,r3,r13
L_935004:
	st_s r1,[r3]
L_935006:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935008:
	st_s r0,[r2]
	.global L_93500a
L_93500a:
	mov_s r0,0x857280
L_935010:
	ld_s r0,[r0,0x18]
L_935012:
	cmp_s r0,0x0
L_935014:
	mov.ne r0,0x1
L_935018:
	neg_s r0,r0
L_93501a:
	bmsk_s r0,r0,0x1
L_93501c:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_93501e:
	stw.as r0,[gp,-0x12]
L_935022:
	stw.as r0,[gp,-0x11]
L_935026:
	j_s.d [blink]
L_935028:
	pop_s r13
L_93502a:
	nop_s
