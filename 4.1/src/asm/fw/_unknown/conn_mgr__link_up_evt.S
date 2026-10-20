/* conn_mgr__link_up_evt @ 0x8d7bdc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::link_up_evt() conn=0x%x. status=%d, pend_connect=%d
 * Зовут его: SW_TX_MGMT_API__link_up_evt, l2_mgr__link_up_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__add_to_rinking_list, conn_mgr__link_down_evt, conn_mgr__ranking_remove, fw_log__emit3
 */
	.section .text.conn_mgr__link_up_evt,"ax",@progbits
	.global conn_mgr__link_up_evt
conn_mgr__link_up_evt:
	.global L_8d7bdc
L_8d7bdc:
	push_s blink
L_8d7bde:
	bl L_8c02c4
L_8d7be2:
	mov_s r13,r0
L_8d7be4:
	mov_s r14,r1
L_8d7be6:
	mov_s r2,0x100a9ec
L_8d7bec:
	ld r5,[r0, 0x18]
L_8d7bf0:
	mov_s r0,0xb
L_8d7bf2:
	mov_s r1,0x2
L_8d7bf4:
	mov_s r3,r13
L_8d7bf6:
	bl.d L_8ee034
L_8d7bfa:
	mov_s r4,r14
L_8d7bfc:
	mov_s r0,r13
L_8d7bfe:
	brne_s r14,0,L_8d7c06
L_8d7c00:
	bl L_8c25e4
L_8d7c04:
	b_s L_8d7c10
	.global L_8d7c06
L_8d7c06:
	bl L_8c8b8c
L_8d7c0a:
	bl.d L_8d79cc
L_8d7c0e:
	mov_s r0,r13
	.global L_8d7c10
L_8d7c10:
	b L_8c0334
