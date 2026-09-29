/* discovery__rx_start @ 0x8efd74, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::rx_start()
 * Зовут его: channels_switch_sm__action_allocate_radio, find_mng__listen, find_mng__search, find_mngr__session_start
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, hwd_mac_parser__set_rx_filter, mac_parser__set_886260
 */
	.section .text.discovery__rx_start,"ax",@progbits
	.global discovery__rx_start
discovery__rx_start:
	.global L_8efd74
L_8efd74:
	push_s blink
L_8efd76:
	push_s r13
L_8efd78:
	mov_s r13,r0
L_8efd7a:
	mov_s r2,0x10127e8
L_8efd80:
	mov_s r0,0xc
L_8efd82:
	bl.d L_8edfb0
L_8efd86:
	mov_s r1,0x2
L_8efd88:
	cmp_s r13,0x0
L_8efd8a:
	mov_s r1,0x1
L_8efd8c:
	sub_s.ne r1,r1,r1
L_8efd8e:
	asl_s r1,r1,0xb
L_8efd90:
	or r1,r1,0x3702
L_8efd98:
	bl.d L_8dbae4
L_8efd9c:
	mov_s r0,0x2
L_8efd9e:
	mov_s r0,0x0
L_8efda0:
	bl.d L_8dbc3c
L_8efda4:
	mov_s r1,0x1
L_8efda6:
	b L_8c033c
L_8efdaa:
	nop_s
