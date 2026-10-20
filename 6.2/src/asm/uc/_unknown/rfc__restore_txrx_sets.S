/* rfc__restore_txrx_sets @ 0x92a014, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_powerup_deep_all_rfs
 * Зовёт сам: hwd_rfc_write_core, rf__set_txrx_sets_save, rfc__write_core_checked
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfc__restore_txrx_sets
rfc__restore_txrx_sets:
	.global L_92a014
L_92a014:
	push_s blink
L_92a016:
	sub_s sp,sp,0x8
L_92a018:
	mov_s r2,sp
L_92a01a:
	add_s r3,sp,0x4
L_92a01c:
	mov r0,0xf
L_92a020:
	bl.d L_92a314
L_92a024:
	mov r1,0xff
L_92a028:
	mov r9,0x889000
L_92a030:
	ld.as r4,[r9,0x46]
L_92a034:
	bclr r4,r4,0x4
L_92a038:
	st.as r4,[r9,0x46]
L_92a03c:
	ldb r5,[gp, -0xe2]
L_92a040:
	asl r5,r5,0x4
L_92a044:
	add2 r5,r5,r5
L_92a048:
	mov lp_count,r5
L_92a04c:
	nop_s
L_92a04e:
	lp L_92a056
L_92a052:
	nop_s
L_92a054:
	nop_s
	.global L_92a056
L_92a056:
	mov r8,0x889000
L_92a05e:
	ld.as r3,[r8,0x46]
L_92a062:
	mov_s r0,0x0
L_92a064:
	bset_s r3,r3,0x4
L_92a066:
	st.as r3,[r8,0x46]
L_92a06a:
	ld r6,[sp]
L_92a06e:
	mov_s r1,0x6
L_92a070:
	st r6,[0x889488]
L_92a078:
	ld r7,[sp, 0x4]
L_92a07c:
	mov_s r2,r0
L_92a07e:
	st.as r7,[r8,0x55]
L_92a082:
	bl.d L_92a3d8
L_92a086:
	mov r3,r0
L_92a08a:
	mov r0,0x0
L_92a08e:
	mov r1,0x470
L_92a092:
	bl.d L_92a5f8
L_92a096:
	mov r2,0x10
L_92a09a:
	add_s sp,sp,0x8
L_92a09c:
	pop_s blink
L_92a09e:
	j_s [blink]
