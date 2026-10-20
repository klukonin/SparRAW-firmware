/* l2_mgr__lmac_high_false_alarm_evt_handler @ 0x8edc48, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::lmac_high_false_alarm_evt_handler locking secondary
 *   l2_mgr::lmac_high_false_alarm_evt_handler already locked m_radio_handle=0x%06x
 * Зовут его: lmac_if_link_lost_handler
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, fw_log__emit0, fw_log__emit1, fw_read_timer
 */
	.section .text.l2_mgr__lmac_high_false_alarm_evt_handler,"ax",@progbits
	.global l2_mgr__lmac_high_false_alarm_evt_handler
l2_mgr__lmac_high_false_alarm_evt_handler:
	.global L_8edc48
L_8edc48:
	push_s blink
L_8edc4a:
	push_s r13
L_8edc4c:
	ld.as r3,[gp,-0xf]
L_8edc50:
	brne_s r3,0,L_8edc82
L_8edc52:
	bl L_8e4694
L_8edc56:
	mov_s r2,0x100dc54
L_8edc5c:
	mov_s r13,r0
L_8edc5e:
	mov_s r0,0xb
L_8edc60:
	bl.d L_8edfb0
L_8edc64:
	mov_s r1,0x2
L_8edc66:
	mov_s r0,0x2bfd4
L_8edc6c:
	mov_s r1,r13
L_8edc6e:
	mov_s r2,0x0
L_8edc70:
	mov_s r3,0xffff
L_8edc76:
	bl.d L_8d938c
L_8edc7a:
	mov_s r4,r2
L_8edc7c:
	st.as r0,[gp,-0xf]
L_8edc80:
	b_s L_8edc90
	.global L_8edc82
L_8edc82:
	mov_s r2,0x100dc90
L_8edc88:
	mov_s r0,0xb
L_8edc8a:
	bl.d L_8edfcc
L_8edc8e:
	mov_s r1,0x2
	.global L_8edc90
L_8edc90:
	b L_8c033c
