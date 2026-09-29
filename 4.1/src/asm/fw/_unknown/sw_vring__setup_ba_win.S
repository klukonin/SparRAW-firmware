/* sw_vring__setup_ba_win @ 0x8c6cdc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__set_ba_params, sw_vring__setup_macq
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, rf_chain__program_sector_desc
 */
	.section .text.sw_vring__setup_ba_win,"ax",@progbits
	.global sw_vring__setup_ba_win
sw_vring__setup_ba_win:
	.global L_8c6cdc
L_8c6cdc:
	push_s blink
L_8c6cde:
	bl.d L_8c02c4
L_8c6ce2:
	mov_s r8,r1
L_8c6ce4:
	sub_s sp,sp,0x10
L_8c6ce6:
	mov_s r13,r0
L_8c6ce8:
	mov_s r7,r2
L_8c6cea:
	mov_s r6,r3
L_8c6cec:
	mov r5,r4
L_8c6cf0:
	mov_s r14,sp
L_8c6cf2:
	mov_s r0,r14
L_8c6cf4:
	ldb_s r1,[r13,0x1]
L_8c6cf6:
	mov_s r2,r8
L_8c6cf8:
	mov_s r3,r7
L_8c6cfa:
	bl.d L_8f2474
L_8c6cfe:
	mov r4,r6
L_8c6d02:
	mov_s r0,r14
L_8c6d04:
	ldb_s r1,[r13]
L_8c6d06:
	mov_s r2,0x2
L_8c6d08:
	mov_s r3,0x0
L_8c6d0a:
	mov_s r4,r3
L_8c6d0c:
	mov_s r5,r3
L_8c6d0e:
	mov r6,0x1
L_8c6d12:
	bl.d L_8c46a4
L_8c6d16:
	mov r7,r6
L_8c6d1a:
	b.d L_8c0334
L_8c6d1e:
	add_s sp,sp,0x10
