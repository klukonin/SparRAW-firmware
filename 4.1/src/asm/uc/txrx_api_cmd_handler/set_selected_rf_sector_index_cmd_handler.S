/* set_selected_rf_sector_index_cmd_handler @ 0x930a40, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   set_selected_rf_sector_index_cmd_handler(): Invalid sector type specified %d, cid=%d
 *   txrx_api_cmd_handler.c
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, rf_sector__program_selected, uc_send_evt__set_rf_sector_done, uc_sysassert
 */
	.section .text.set_selected_rf_sector_index_cmd_handler,"ax",@progbits
	.global set_selected_rf_sector_index_cmd_handler
set_selected_rf_sector_index_cmd_handler:
	.global L_930a40
L_930a40:
	push_s blink
L_930a42:
	bl L_920210
L_930a46:
	mov_s r13,r0
L_930a48:
	mov_s r0,0x800cac
L_930a4e:
	ld_s r0,[r0,0x10]
L_930a50:
	push_s r0
L_930a52:
	mov_s r0,0x0
L_930a54:
	stb_s r0,[sp,0x0]
L_930a56:
	ldb_s r3,[r13,0x1]
L_930a58:
	brne r3,0x1,L_930a9a
L_930a5c:
	ldw_s r2,[r13,0x2]
L_930a5e:
	mov_s r1,0x8010e8
L_930a64:
	breq r2,0xffff,L_930a92
L_930a6c:
	mov_s r3,0x1
L_930a6e:
	st_s r3,[r1,0x1c]
L_930a70:
	ldw_s r0,[r13,0x2]
L_930a72:
	stb r0,[r1, 0x20]
L_930a76:
	ldb_s r0,[r13]
L_930a78:
	mov_s r1,0x857400
L_930a7e:
	mul64 r0,0x3c
L_930a82:
	ld r2,[r1,mlo]
L_930a86:
	ldw_s r1,[r13,0x2]
L_930a88:
	lsr_s r2,r2,0x6
L_930a8a:
	bl.d L_937448
L_930a8e:
	bmsk_s r2,r2,0x1
L_930a90:
	b_s L_930afa
	.global L_930a92
L_930a92:
	st_s r0,[r1,0x1c]
L_930a94:
	stb r0,[r1, 0x20]
L_930a98:
	b_s L_930afa
	.global L_930a9a
L_930a9a:
	brne_s r3,0,L_930aa2
L_930a9c:
	mov_s r0,0x3
L_930a9e:
	stb_s r0,[sp,0x0]
L_930aa0:
	b_s L_930afa
	.global L_930aa2
L_930aa2:
	mov_s r2,0x80209c
L_930aa8:
	ldb_s r0,[r2,0x4]
L_930aaa:
	mov_s r1,0x100198c
L_930ab0:
	ldb_s r14,[r13]
L_930ab2:
	bbit0 r0,0x2,L_930ae6
L_930ab6:
	ld_s r0,[r2]
L_930ab8:
	mov_s r13,0x8020b0
L_930abe:
	add_s r15,r0,0x2
L_930ac0:
	extb_s r15,r15
L_930ac2:
	add2 r15,r13,r15
L_930ac6:
	st_s r14,[r15]
L_930ac8:
	add_s r14,r0,0x1
L_930aca:
	extb_s r14,r14
L_930acc:
	add2 r14,r13,r14
L_930ad0:
	st_s r3,[r14]
L_930ad2:
	bmsk_s r1,r1,0x13
L_930ad4:
	or r1,r1,0xaa000000
L_930adc:
	extb_s r3,r0
L_930ade:
	add2_s r13,r13,r3
L_930ae0:
	st_s r1,[r13]
L_930ae2:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_930ae4:
	st_s r0,[r2]
	.global L_930ae6
L_930ae6:
	mov_s r0,blink
L_930ae8:
	mov_s r2,0x1001830
L_930aee:
	mov r1,0x106
L_930af2:
	bl.d L_925548
L_930af6:
	mov r3,0x350
	.global L_930afa
L_930afa:
	bl.d L_925cfc
L_930afe:
	mov_s r0,sp
L_930b00:
	b.d L_92027c
L_930b04:
	add_s sp,sp,0x4
L_930b06:
	nop_s
