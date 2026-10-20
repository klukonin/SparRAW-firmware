/* conn_mgr__link_up_evt @ 0x8dad1c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::link_up_evt() conn=0x%x. status=%d, pend_connect=%d
 * Зовут его: SW_TX_MGMT_API__link_up_evt, WBE_DRIVER__link_down_notif
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__add_to_rinking_list, conn_mgr__link_down_evt, conn_mgr__ranking_remove, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__link_up_evt
conn_mgr__link_up_evt:
	.global L_8dad1c
L_8dad1c:
	push_s blink
L_8dad1e:
	bl L_8c01e4
L_8dad22:
	mov_s r13,r0
L_8dad24:
	mov_s r14,r1
L_8dad26:
	mov_s r1,0x100be90
L_8dad2c:
	ld r4,[r0, 0x24]
L_8dad30:
	mov_s r0,0x2b
L_8dad32:
	mov_s r2,r13
L_8dad34:
	bl.d L_8dcd00
L_8dad38:
	mov_s r3,r14
L_8dad3a:
	mov_s r0,r13
L_8dad3c:
	brne_s r14,0,L_8dad44
L_8dad3e:
	bl L_8c2d78
L_8dad42:
	b_s L_8dad4e
	.global L_8dad44
L_8dad44:
	bl L_8ca6fc
L_8dad48:
	bl.d L_8daae8
L_8dad4c:
	mov_s r0,r13
	.global L_8dad4e
L_8dad4e:
	b L_8c0254
L_8dad52:
	nop_s
