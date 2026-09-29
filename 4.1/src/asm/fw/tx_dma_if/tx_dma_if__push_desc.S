/* tx_dma_if__push_desc @ 0x8ddb68, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_dma_if.cpp
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_sysassert_fatal, hwd_dma__write_ring_reg, mac_kick_ring, ring__is_full, rm_ch_switch_sm__bump_turn, tx_desc__build, tx_desc__build_b, tx_desc_by_index, vring_by_index
 */
	.section .text.tx_dma_if__push_desc,"ax",@progbits
	.global tx_dma_if__push_desc
tx_dma_if__push_desc:
L_8ddb68:
	j_s [blink]
	.global sub_8ddb6a
sub_8ddb6a:
L_8ddb6a:
	nop_s
L_8ddb6c:
	push_s blink
L_8ddb6e:
	bl L_8c02a4
L_8ddb72:
	sub_s sp,sp,0xc
L_8ddb74:
	mov_s r14,r0
L_8ddb76:
	mov_s r21,r1
L_8ddb78:
	mov_s r20,r2
L_8ddb7a:
	mov_s r19,r3
L_8ddb7c:
	st r4,[sp, 0x8]
L_8ddb80:
	mov r17,r5
L_8ddb84:
	mov r18,r6
L_8ddb88:
	mov r16,r7
L_8ddb8c:
	add_s r13,r0,0x4
L_8ddb8e:
	bl.d L_8d7220
L_8ddb92:
	mov_s r0,r13
L_8ddb94:
	cmp_s r0,0x0
L_8ddb96:
	mov_s r0,0x0
L_8ddb98:
	bne_s L_8ddc0a
L_8ddb9a:
	mov_s r0,r13
L_8ddb9c:
	bl.d L_8c9ff8
L_8ddba0:
	ld_s r1,[r13,0xc]
L_8ddba2:
	mov_s r15,r0
L_8ddba4:
	ld_s r0,[r0,0x1c]
L_8ddba6:
	bbit1 r0,0x8,L_8ddc10
	.global L_8ddbaa
L_8ddbaa:
	mov_s r0,r15
L_8ddbac:
	ld_s r1,[r14,0x14]
L_8ddbae:
	mov r22,0x1
L_8ddbb2:
	mov_s r2,r22
L_8ddbb4:
	mov_s r3,r21
L_8ddbb6:
	mov r4,r20
L_8ddbba:
	bl.d L_8e4b54
L_8ddbbe:
	mov r5,r18
L_8ddbc2:
	bl.d L_8cacc0
L_8ddbc6:
	ld_s r0,[r14,0x14]
L_8ddbc8:
	mov.f r3,r16
L_8ddbcc:
	mov.ne r3,0x1
L_8ddbd0:
	ldb_s r1,[sp,0x38]
L_8ddbd2:
	st r17,[sp]
L_8ddbd6:
	st_s r1,[sp,0x4]
L_8ddbd8:
	mov_s r1,r15
L_8ddbda:
	ld_s r2,[sp,0x3c]
L_8ddbdc:
	mov r4,r22
L_8ddbe0:
	mov r5,r16
L_8ddbe4:
	mov r6,r19
L_8ddbe8:
	bl.d L_8c8858
L_8ddbec:
	ld r7,[sp, 0x8]
L_8ddbf0:
	add r1,r13,0xc
L_8ddbf4:
	bl.d L_8c6d20
L_8ddbf8:
	mov_s r0,r13
L_8ddbfa:
	ld_s r0,[r14,0x18]
L_8ddbfc:
	bl.d L_8cdeac
L_8ddc00:
	ld_s r1,[r13,0xc]
L_8ddc02:
	bl.d L_8ddb54
L_8ddc06:
	ld_s r0,[r14,0x14]
L_8ddc08:
	mov_s r0,r22
	.global L_8ddc0a
L_8ddc0a:
	b.d L_8c02f4
L_8ddc0e:
	add_s sp,sp,0xc
	.global L_8ddc10
L_8ddc10:
	mov_s r0,blink
L_8ddc12:
	mov_s r2,0x1015994
L_8ddc18:
	mov_s r1,0x1227
L_8ddc1e:
	bl.d L_8c82c0
L_8ddc22:
	mov_s r3,0x1b
L_8ddc24:
	b_s L_8ddbaa
L_8ddc26:
	nop_s
