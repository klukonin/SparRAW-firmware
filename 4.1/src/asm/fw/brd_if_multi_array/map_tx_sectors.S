/* map_tx_sectors @ 0x8d9cc4, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array.cpp
 *   map_tx_sectors vector_low: %x, vector_high: %x
 * Зовут его: brd_if_multi_array__init
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_div_unsigned, fw_log__emit2, fw_sysassert_fatal, tail_brd_if__clear_block_info, tail_brd_if__clear_section_info
 */
	.section .text.map_tx_sectors,"ax",@progbits
	.global map_tx_sectors
map_tx_sectors:
	.global L_8d9cc4
L_8d9cc4:
	push_s blink
L_8d9cc6:
	bl.d L_8c02ac
L_8d9cca:
	mov_s r1,0x0
L_8d9ccc:
	sub_s sp,sp,0x28
L_8d9cce:
	mov_s r18,r0
L_8d9cd0:
	mov_s r0,sp
L_8d9cd2:
	bl.d L_8c17e4
L_8d9cd6:
	mov_s r17,r0
L_8d9cd8:
	add_s r0,sp,0x10
L_8d9cda:
	mov_s r16,r0
L_8d9cdc:
	bl.d L_8c17e0
L_8d9ce0:
	mov_s r1,0x0
L_8d9ce2:
	ld r0,[r18]
L_8d9ce6:
	mov_s r1,0x3
L_8d9ce8:
	ld_s r3,[r0,0x4]
L_8d9cea:
	mov_s r0,r18
L_8d9cec:
	jl_s.d [r3]
L_8d9cee:
	mov_s r2,r17
L_8d9cf0:
	breq_s r0,0,L_8d9d5e
	.global L_8d9cf2
L_8d9cf2:
	ld r1,[r18, 0x4]
L_8d9cf6:
	ld_s r0,[sp,0x8]
L_8d9cf8:
	add_s r1,r1,0x8
L_8d9cfa:
	add r20,r0,r1
L_8d9cfe:
	ld_s r0,[sp,0x4]
L_8d9d00:
	add r13,r20,0x10
L_8d9d04:
	brlo.d r0,0x1,L_8d9d96
L_8d9d08:
	mov r19,0x0
	.global L_8d9d0c
L_8d9d0c:
	ld r0,[r18]
L_8d9d10:
	mov_s r1,r17
L_8d9d12:
	ld_s r14,[r0,0x8]
L_8d9d14:
	mov_s r0,r18
L_8d9d16:
	mov_s r2,r19
L_8d9d18:
	jl_s.d [r14]
L_8d9d1a:
	mov_s r3,r16
L_8d9d1c:
	mov_s r15,0x0
L_8d9d1e:
	b_s L_8d9d22
	.global L_8d9d20
L_8d9d20:
	/* add_s r15,0x6 */
	.byte 0x06,0xe7
	.global L_8d9d22
L_8d9d22:
	ld r0,[r20, 0x8]
L_8d9d26:
	lsr_s r0,r0,0x8
L_8d9d28:
	bmsk_s r0,r0,0xb
L_8d9d2a:
	brhs r15,r0,L_8d9d74
L_8d9d2e:
	mov_s r14,0x0
	.global L_8d9d30
L_8d9d30:
	brhs r14,0x6,L_8d9d20
L_8d9d34:
	ld_s r0,[r13]
L_8d9d36:
	brne_s r0,0,L_8d9d3c
L_8d9d38:
	ld_s r0,[r13,0x4]
L_8d9d3a:
	breq_s r0,0,L_8d9d58
	.global L_8d9d3c
L_8d9d3c:
	mov_s r0,r15
L_8d9d3e:
	bl.d L_8c03b4
L_8d9d42:
	mov_s r1,0x6
L_8d9d44:
	extb_s r1,r0
L_8d9d46:
	lsr_s r1,r1,0x5
L_8d9d48:
	add3 r2,r18,r19
L_8d9d4c:
	add2_s r2,r2,r1
L_8d9d4e:
	ld_s r1,[r2,0x10]
L_8d9d50:
	bmsk_s r0,r0,0x4
L_8d9d52:
	bset r1,r1,r0
L_8d9d56:
	st_s r1,[r2,0x10]
	.global L_8d9d58
L_8d9d58:
	add_s r13,r13,0x8
L_8d9d5a:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8d9d5c:
	b_s L_8d9d30
	.global L_8d9d5e
L_8d9d5e:
	mov_s r0,blink
L_8d9d60:
	mov_s r2,0x1009220
L_8d9d66:
	mov_s r1,0x1368
L_8d9d6c:
	bl.d L_8c82c0
L_8d9d70:
	mov_s r3,0x62
L_8d9d72:
	b_s L_8d9cf2
	.global L_8d9d74
L_8d9d74:
	mov_s r2,0x1009238
L_8d9d7a:
	add3 r3,r18,r19
L_8d9d7e:
	ld r4,[r3, 0x14]
L_8d9d82:
	mov_s r0,0x0
L_8d9d84:
	mov_s r1,0x2
L_8d9d86:
	bl.d L_8edff8
L_8d9d8a:
	ld_s r3,[r3,0x10]
L_8d9d8c:
	ld_s r0,[sp,0x4]
L_8d9d8e:
	add r19,r19,0x1
L_8d9d92:
	brlo r19,r0,L_8d9d0c
	.global L_8d9d96
L_8d9d96:
	b.d L_8c0304
L_8d9d9a:
	add_s sp,sp,0x28
