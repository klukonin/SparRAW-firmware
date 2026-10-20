/* rx_macq__program_desc_848018 @ 0x8df908, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__program_desc_for_conn, rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set16h_s4_w5, mac_parser__pack_rule_halfword, macq_desc__write, rx_macq__pack_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__program_desc_848018
rx_macq__program_desc_848018:
	.global L_8df908
L_8df908:
	push_s blink
L_8df90a:
	bl.d L_8c01e4
L_8df90e:
	mov_s r8,r1
L_8df910:
	mov_s r14,r0
L_8df912:
	mov_s r7,r2
L_8df914:
	mov_s r6,r3
L_8df916:
	mov r5,r4
L_8df91a:
	ld_s r0,[r0,0x8]
L_8df91c:
	mov_s r13,0x848008
L_8df922:
	ldb_s r1,[r14,0x1]
L_8df924:
	cmp_s r0,0x0
L_8df926:
	add r0,r13,0x10
L_8df92a:
	mov_s r2,r8
L_8df92c:
	mov_s r3,r7
L_8df92e:
	mov r4,r6
L_8df932:
	mov r6,0x1
L_8df936:
	sub.ne r7,r7,r7
L_8df93a:
	mov.eq r6,0x0
L_8df93e:
	mov.eq r7,0x1
L_8df942:
	bl L_8e4340
L_8df946:
	add r0,r13,0x10
L_8df94a:
	ldb_s r1,[r14]
L_8df94c:
	mov_s r2,0x1
L_8df94e:
	mov_s r3,0x2
L_8df950:
	mov r4,0x0
L_8df954:
	mov r5,r4
L_8df958:
	mov r6,r4
L_8df95c:
	bl.d L_8c5010
L_8df960:
	mov_s r7,r2
L_8df962:
	b L_8c0254
L_8df966:
	nop_s
	.global L_8df968
L_8df968:
	push_s blink
L_8df96a:
	mov_s r4,r1
L_8df96c:
	mov_s r1,r2
L_8df96e:
	ldw_s r2,[r0]
L_8df970:
	bmsk_s r1,r1,0x4
L_8df972:
	stw.a r2,[sp,-0x8]
L_8df976:
	ldw_s r2,[r0,0x2]
L_8df978:
	stw r2,[sp, 0x2]
L_8df97c:
	ldw_s r0,[r0,0x4]
L_8df97e:
	stw r0,[sp, 0x4]
L_8df982:
	add r0,sp,0x6
L_8df986:
	bl L_8ed31c
L_8df98a:
	ldw r0,[sp, 0x6]
L_8df98e:
	bset_s r0,r0,0x0
L_8df990:
	stw r0,[sp, 0x6]
L_8df994:
	mov_s r0,sp
L_8df996:
	bl.d L_8df6a4
L_8df99a:
	mov_s r1,r4
L_8df99c:
	add_s sp,sp,0x8
L_8df99e:
	pop_s blink
L_8df9a0:
	j_s [blink]
L_8df9a2:
	nop_s
