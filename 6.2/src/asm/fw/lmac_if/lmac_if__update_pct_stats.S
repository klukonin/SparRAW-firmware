/* lmac_if__update_pct_stats @ 0x8db9c0, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_divmod64_signed, fw_divmod_unsigned, fw_mul64, mac_rx_cnt__get_u64_bc, mac_tx_cnt__get_u64_14, sys_state__broadcast_16, sysapi_mgr__stats_lut_find_index
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__update_pct_stats
lmac_if__update_pct_stats:
	.global L_8db9c0
L_8db9c0:
	push_s blink
L_8db9c2:
	bl L_8c01d8
L_8db9c6:
	mov_s r14,0x853a00
L_8db9cc:
	ldb r0,[r14, -0xa8]
L_8db9d0:
	breq_s r0,0,L_8db9ec
L_8db9d2:
	mov_s r0,0x805170
L_8db9d8:
	mov_s r13,0x853900
L_8db9de:
	bl.d L_8f2038
L_8db9e2:
	ld_s r1,[r13,0x5c]
L_8db9e4:
	st_s r0,[r13,0x64]
L_8db9e6:
	mov_s r0,0x1
L_8db9e8:
	stb r0,[r14, -0xa0]
	.global L_8db9ec
L_8db9ec:
	ld r1,[r14, -0x70]
L_8db9f0:
	ld r0,[r14, -0x54]
L_8db9f4:
	ld r15,[r14, -0x78]
L_8db9f8:
	add_s r0,r0,r1
L_8db9fa:
	sub.f r15,r15,r0
L_8db9fe:
	beq_s L_8dba8e
L_8dba00:
	lsr r17,r15
L_8dba04:
	mov_s r13,0x0
L_8dba06:
	ld r0,[r14, -0x74]
L_8dba0a:
	mov_s r1,r13
L_8dba0c:
	mov_s r2,0x64
L_8dba0e:
	bl.d L_8c045c
L_8dba12:
	mov_s r3,r13
L_8dba14:
	add.f r0,r0,r17
L_8dba18:
	mov_s r2,r15
L_8dba1a:
	adc r1,r1,r13
L_8dba1e:
	bl.d L_8c047c
L_8dba22:
	mov_s r3,r13
L_8dba24:
	mov_s r16,r0
L_8dba26:
	ld r0,[r14, -0x6c]
L_8dba2a:
	mov_s r1,r13
L_8dba2c:
	mov_s r2,0x64
L_8dba2e:
	bl.d L_8c045c
L_8dba32:
	mov_s r3,r13
L_8dba34:
	add.f r0,r0,r17
L_8dba38:
	mov_s r2,r15
L_8dba3a:
	adc r1,r1,r13
L_8dba3e:
	bl.d L_8c047c
L_8dba42:
	mov_s r3,r13
L_8dba44:
	mov_s r14,0x80426c
L_8dba4a:
	ld_s r2,[r14,0x4]
L_8dba4c:
	stb_s r0,[r14,0x2]
L_8dba4e:
	add_s r0,r0,r2
L_8dba50:
	ld_s r2,[r14,0xc]
L_8dba52:
	stb r16,[r14, 0x9]
L_8dba56:
	add_s r2,r2,r16
L_8dba58:
	mov_s r16,r2
L_8dba5a:
	st_s r2,[r14,0xc]
L_8dba5c:
	mov_s r2,0x803c00
L_8dba62:
	ldb_s r2,[r2,0x1c]
L_8dba64:
	ldw_s r15,[r14]
L_8dba66:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8dba68:
	brlt.d r15,r2,L_8dba8a
L_8dba6c:
	st_s r0,[r14,0x4]
L_8dba6e:
	bl.d L_8c02d4
L_8dba72:
	mov_s r1,r15
L_8dba74:
	stb_s r0,[r14,0x8]
L_8dba76:
	mov_s r0,r16
L_8dba78:
	bl.d L_8c02d4
L_8dba7c:
	mov_s r1,r15
L_8dba7e:
	stb_s r0,[r14,0x10]
L_8dba80:
	st_s r13,[r14,0x4]
L_8dba82:
	st_s r13,[r14,0xc]
L_8dba84:
	mov_s r0,0x1
L_8dba86:
	stw_s r0,[r14]
L_8dba88:
	b_s L_8dba8e
	.global L_8dba8a
L_8dba8a:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8dba8c:
	stw_s r15,[r14]
	.global L_8dba8e
L_8dba8e:
	bl L_8dd7a4
L_8dba92:
	bl L_8dd798
L_8dba96:
	bl L_8dd8e4
L_8dba9a:
	b L_8c023c
L_8dba9e:
	nop_s
