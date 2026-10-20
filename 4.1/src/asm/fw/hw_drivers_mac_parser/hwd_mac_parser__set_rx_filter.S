/* hwd_mac_parser__set_rx_filter @ 0x8dbc3c, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac_parser.c
 * Зовут его: discovery__rx_start, discovery__rx_stop, mac_parser__init
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, mac_parser__write_rule
 */
	.section .text.hwd_mac_parser__set_rx_filter,"ax",@progbits
	.global hwd_mac_parser__set_rx_filter
hwd_mac_parser__set_rx_filter:
	.global L_8dbc3c
L_8dbc3c:
	push_s blink
L_8dbc3e:
	bl L_8c02bc
L_8dbc42:
	sub_s sp,sp,0x8
L_8dbc44:
	mov_s r16,r0
L_8dbc46:
	mov_s r15,r1
L_8dbc48:
	mov_s r14,0x0
L_8dbc4a:
	b_s L_8dbc76
	.global L_8dbc4c
L_8dbc4c:
	mov_s r3,0x0
L_8dbc4e:
	bset_s r3,r3,0xe
	.global L_8dbc50
L_8dbc50:
	or_s r2,r2,r3
L_8dbc52:
	bset_s r2,r2,0xf
L_8dbc54:
	stw_s r2,[r13,0x2]
L_8dbc56:
	asl r2,r16,0x12
L_8dbc5a:
	or r2,r2,0x1af7f
L_8dbc62:
	asl_s r0,r0,0x13
L_8dbc64:
	or_s r0,r0,r2
L_8dbc66:
	bset_s r0,r0,0x16
L_8dbc68:
	bset_s r0,r0,0x17
L_8dbc6a:
	st_s r0,[r13,0x4]
L_8dbc6c:
	mov_s r0,r13
L_8dbc6e:
	bl.d L_8dbb00
L_8dbc72:
	mov_s r2,0x3
	.global L_8dbc74
L_8dbc74:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dbc76
L_8dbc76:
	brhs r14,0xf,L_8dbd0c
L_8dbc7a:
	brlo r14,0x6,L_8dbc82
L_8dbc7e:
	brlo r14,0x8,L_8dbc74
	.global L_8dbc82
L_8dbc82:
	mov_s r13,sp
L_8dbc84:
	asl_s r0,r14,0x2
L_8dbc86:
	bset_s r0,r0,0xa
L_8dbc88:
	brhs.d r14,0xf,L_8dbcae
L_8dbc8c:
	stw r0,[sp]
L_8dbc90:
	ldb.x r10,[0x8030e8,r14]
L_8dbc98:
	add r0,pcl,0xa
L_8dbc9c:
	add1 r0,r0,r10
L_8dbca0:
	j_s [r0]
L_8dbca2:
	add_s r1,r14,0x1
L_8dbca4:
	b_s L_8dbcc2
L_8dbca6:
	sub_s r1,r14,0x1
L_8dbca8:
	b_s L_8dbcc2
L_8dbcaa:
	mov_s r1,0xf
L_8dbcac:
	b_s L_8dbcc2
	.global L_8dbcae
L_8dbcae:
	mov_s r0,blink
L_8dbcb0:
	mov_s r2,0x1019b0c
L_8dbcb6:
	mov_s r1,0xe
L_8dbcb8:
	bset_s r1,r1,0xc
L_8dbcba:
	bl.d L_8c82c0
L_8dbcbe:
	mov_s r3,0x30
L_8dbcc0:
	mov_s r1,0x0
	.global L_8dbcc2
L_8dbcc2:
	sub_s r3,r1,0x5
L_8dbcc4:
	brhs.d r3,0xb,L_8dbcf0
L_8dbcc8:
	mov_s r0,0x1
L_8dbcca:
	ldb.x r3,[0x8030f8,r3]
L_8dbcd2:
	add r2,pcl,0xa
L_8dbcd6:
	add1_s r2,r2,r3
L_8dbcd8:
	j_s [r2]
L_8dbcda:
	mov_s r1,0xc
L_8dbcdc:
	cmp_s r15,0x0
L_8dbcde:
	mov_s r0,0x1
L_8dbce0:
	sub_s.ne r0,r0,r0
L_8dbce2:
	neg_s r0,r0
L_8dbce4:
	bmsk_s r0,r0,0x1
L_8dbce6:
	b_s L_8dbcf0
L_8dbce8:
	mov_s r0,0x3
L_8dbcea:
	b_s L_8dbcf0
L_8dbcec:
	mov_s r1,0x6
L_8dbcee:
	mov_s r0,0x0
	.global L_8dbcf0
L_8dbcf0:
	cmp_s r1,0xc
L_8dbcf2:
	mov_s r2,0x1
L_8dbcf4:
	sub_s.ne r2,r2,r2
L_8dbcf6:
	asl_s r2,r2,0x8
L_8dbcf8:
	or r2,r2,0x3007
L_8dbd00:
	cmp_s r1,0xf
L_8dbd02:
	cmp.ne r1,0x8
L_8dbd06:
	bne_s L_8dbc4c
L_8dbd08:
	mov_s r3,0x0
L_8dbd0a:
	b_s L_8dbc50
	.global L_8dbd0c
L_8dbd0c:
	b.d L_8c0324
L_8dbd10:
	add_s sp,sp,0x8
L_8dbd12:
	nop_s
