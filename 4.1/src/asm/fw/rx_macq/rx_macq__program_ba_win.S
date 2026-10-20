/* rx_macq__program_ba_win @ 0x8ded90, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_macq.cpp
 * Зовут его: rx_macq__setup
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, mac_indirect__write_entry, rx_queue__calc_offset
 * Глобалы (через gp): 0x800294
 */
	.section .text.rx_macq__program_ba_win,"ax",@progbits
	.global rx_macq__program_ba_win
rx_macq__program_ba_win:
	.global L_8ded90
L_8ded90:
	push_s blink
L_8ded92:
	bl L_8c02bc
L_8ded96:
	mov_s r14,r0
L_8ded98:
	mov_s r16,r1
L_8ded9a:
	ldb_s r1,[r0]
L_8ded9c:
	mov_s r13,r5
L_8ded9e:
	st.a r1,[sp,-0xc]
L_8deda2:
	ld_s r0,[gp,0x124]
L_8deda4:
	stw r3,[sp, 0x6]
L_8deda8:
	stw r2,[sp, 0x4]
L_8dedac:
	stw r4,[sp, 0x8]
L_8dedb0:
	breq_s r0,0,L_8dedb6
L_8dedb2:
	cmp_s r13,0x40
L_8dedb4:
	bgt_s L_8dede8
	.global L_8dedb6
L_8dedb6:
	stw r13,[sp, 0xa]
L_8dedba:
	stw_s r13,[r14,0x2]
L_8dedbc:
	mov_s r13,0x84861c
L_8dedc2:
	mov_s r2,sp
L_8dedc4:
	mov_s r0,r13
L_8dedc6:
	mov_s r1,r16
L_8dedc8:
	bl.d L_8df8b0
L_8dedcc:
	ldb_s r3,[r14,0x1]
L_8dedce:
	mov_s r0,r13
L_8dedd0:
	ldb_s r1,[r14]
L_8dedd2:
	mov_s r2,0x1
L_8dedd4:
	mov_s r3,0x0
L_8dedd6:
	mov_s r4,r3
L_8dedd8:
	mov_s r5,r3
L_8dedda:
	mov_s r6,r3
L_8deddc:
	bl.d L_8c46a4
L_8dede0:
	mov_s r7,r2
L_8dede2:
	b.d L_8c0324
L_8dede6:
	add_s sp,sp,0xc
	.global L_8dede8
L_8dede8:
	mov_s r0,blink
L_8dedea:
	mov_s r2,0x1015b2c
L_8dedf0:
	mov_s r1,0x1276
L_8dedf6:
	bl.d L_8c82c0
L_8dedfa:
	mov_s r3,0xda
L_8dedfc:
	b_s L_8dedb6
L_8dedfe:
	nop_s
