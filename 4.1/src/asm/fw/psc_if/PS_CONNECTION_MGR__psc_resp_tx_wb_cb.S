/* PS_CONNECTION_MGR__psc_resp_tx_wb_cb @ 0x8dd9e0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION_MGR::psc_resp_tx_wb_cb - p_conn is NULL
 *   psc_if::psc_resp_tx_wb_cb. received WB after disconnect
 *   psc_if::psc_resp_tx_wb_cb, success:%d
 * Зовёт сам: TX_API__free_memory, __ld_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit0, fw_log__emit1, pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c
 */
	.section .text.PS_CONNECTION_MGR__psc_resp_tx_wb_cb,"ax",@progbits
	.global PS_CONNECTION_MGR__psc_resp_tx_wb_cb
PS_CONNECTION_MGR__psc_resp_tx_wb_cb:
	.global L_8dd9e0
L_8dd9e0:
	b.d L_8dda24
L_8dd9e4:
	add_s r0,r0,0x5c
L_8dd9e6:
	nop_s
L_8dd9e8:
	push_s blink
L_8dd9ea:
	push_s r13
L_8dd9ec:
	mov_s r13,r0
L_8dd9ee:
	mov_s r3,r1
L_8dd9f0:
	brne_s r2,0,L_8dda02
L_8dd9f2:
	mov_s r2,0x1002890
L_8dd9f8:
	mov_s r0,0xe
L_8dd9fa:
	bl.d L_8edfb0
L_8dd9fe:
	mov_s r1,0x2
L_8dda00:
	b_s L_8dda18
	.global L_8dda02
L_8dda02:
	ldb_s r0,[r2,0x8]
L_8dda04:
	mov_s r1,r13
L_8dda06:
	mul64 r0,0xf4
L_8dda0a:
	add r0,mlo,0x80361c
L_8dda12:
	bl.d L_8dd9e0
L_8dda16:
	mov_s r2,r3
	.global L_8dda18
L_8dda18:
	bl.d L_8c94c4
L_8dda1c:
	mov_s r0,r13
L_8dda1e:
	b L_8c033c
L_8dda22:
	nop_s
	.global L_8dda24
L_8dda24:
	push_s blink
L_8dda26:
	bl L_8c02c4
L_8dda2a:
	mov_s r14,r0
L_8dda2c:
	bl.d L_8c5c4c
L_8dda30:
	mov_s r13,r2
L_8dda32:
	ld r0,[r14, 0x8c]
L_8dda36:
	brne_s r0,0,L_8dda48
L_8dda38:
	mov_s r2,0x1002b20
L_8dda3e:
	mov_s r0,0xe
L_8dda40:
	bl.d L_8edfb0
L_8dda44:
	mov_s r1,0x2
L_8dda46:
	b_s L_8dda6c
	.global L_8dda48
L_8dda48:
	mov_s r2,0x1002b58
L_8dda4e:
	cmp_s r13,0x0
L_8dda50:
	mov_s r13,0x1
L_8dda52:
	sub_s.ne r13,r13,r13
L_8dda54:
	mov_s r0,0xe
L_8dda56:
	mov_s r1,0x2
L_8dda58:
	bl.d L_8edfcc
L_8dda5c:
	mov_s r3,r13
L_8dda5e:
	mov_s r0,r14
L_8dda60:
	mov_s r1,0x2
L_8dda62:
	mov_s r2,r13
L_8dda64:
	mov_s r3,0x0
L_8dda66:
	bl.d L_8d6a1c
L_8dda6a:
	mov_s r4,r3
	.global L_8dda6c
L_8dda6c:
	b L_8c0334
