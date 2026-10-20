/* conn_disc_sm__disassoc_sent_cb @ 0x8eb048, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_disc_sm::disassoc_sent_cb() arrived.
 *   conn_disc_sm::disassoc_sent_cb - p_conn is NULL
 * Зовёт сам: TX_API__free_memory, __ld_r14_to_r13_ret, __st_r14_to_r13, conn_sm__inject_event, fw_log__emit0
 */
	.section .text.conn_disc_sm__disassoc_sent_cb,"ax",@progbits
	.global conn_disc_sm__disassoc_sent_cb
conn_disc_sm__disassoc_sent_cb:
	.byte 0x8f
	.byte 0xea
	.global fwlog_conn_disc_sm_disassoc_sent_cb_p_conn_is_
fwlog_conn_disc_sm_disassoc_sent_cb_p_conn_is_:
L_8eb04a:
	nop_s
L_8eb04c:
	push_s blink
L_8eb04e:
	bl.d L_8c02c4
L_8eb052:
	mov_s r1,0x2
L_8eb054:
	mov_s r14,r0
L_8eb056:
	mov_s r13,r2
L_8eb058:
	mov_s r2,0x100fabc
L_8eb05e:
	bl.d L_8edfb0
L_8eb062:
	mov_s r0,0xb
L_8eb064:
	brne_s r13,0,L_8eb076
L_8eb066:
	mov_s r2,0x100fae8
L_8eb06c:
	mov_s r0,0xe
L_8eb06e:
	bl.d L_8edfb0
L_8eb072:
	mov_s r1,0x2
L_8eb074:
	b_s L_8eb07c
	.global L_8eb076
L_8eb076:
	mov_s r0,0x0
L_8eb078:
	st.as r0,[r13,0x5a]
	.global L_8eb07c
L_8eb07c:
	bl.d L_8c94c4
L_8eb080:
	mov_s r0,r14
L_8eb082:
	mov_s r0,r13
L_8eb084:
	mov_s r1,0x6
L_8eb086:
	mov_s r2,0x0
L_8eb088:
	mov_s r3,r2
L_8eb08a:
	bl.d L_8d6b78
L_8eb08e:
	mov_s r4,r2
L_8eb090:
	b L_8c0334
