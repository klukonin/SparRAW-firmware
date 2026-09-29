/* ba_sm__prepare_ba_td @ 0x8dcad8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_sm::prepare_ba_td: Vring Index: %d, Pring Index: %d, CID: %d
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ba_sm__pring_id_of_conn, ba_sm__vring_field6, ba_sm__vring_field7, basic_sm__inject_event, fw_log__emit3
 */
	.section .text.ba_sm__prepare_ba_td,"ax",@progbits
	.global ba_sm__prepare_ba_td
ba_sm__prepare_ba_td:
	.byte 0xcf
	.byte 0xf1
	.global fwlog_ba_sm_prepare_ba_td_Vring_Index_d_Pring_
fwlog_ba_sm_prepare_ba_td_Vring_Index_d_Pring_:
L_8dcada:
	nop_s
L_8dcadc:
	push_s blink
L_8dcade:
	bl L_8c02bc
L_8dcae2:
	mov_s r13,r0
L_8dcae4:
	bl.d L_8cab50
L_8dcae8:
	mov_s r16,r1
L_8dcaea:
	mov_s r15,r0
L_8dcaec:
	bl.d L_8ca7ec
L_8dcaf0:
	mov_s r0,r13
L_8dcaf2:
	mov_s r14,r0
L_8dcaf4:
	bl.d L_8c9d84
L_8dcaf8:
	mov_s r0,r13
L_8dcafa:
	mov_s r5,r0
L_8dcafc:
	mov_s r2,0x101015c
L_8dcb02:
	mov_s r0,0xb
L_8dcb04:
	mov_s r1,0x2
L_8dcb06:
	mov_s r3,r15
L_8dcb08:
	bl.d L_8ee034
L_8dcb0c:
	mov_s r4,r14
L_8dcb0e:
	add2 r0,r13,0x1d
L_8dcb12:
	mov_s r1,0x0
L_8dcb14:
	mov_s r2,r16
L_8dcb16:
	mov_s r3,0x1
L_8dcb18:
	bl.d L_8d6a1c
L_8dcb1c:
	mov_s r4,r1
L_8dcb1e:
	ld r0,[r13, 0xac]
L_8dcb22:
	ld r1,[r0, 0xd4]
L_8dcb26:
	ld_s r1,[r1,0x8]
L_8dcb28:
	jl_s [r1]
L_8dcb2a:
	.byte 0xfd,0x07
