/* rx_pkt__lookup_handler @ 0x8cc118, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, radio_mgr__get_current_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt__lookup_handler
rx_pkt__lookup_handler:
	.global L_8cc118
L_8cc118:
	push_s blink
L_8cc11a:
	push_s r13
L_8cc11c:
	sub_s sp,sp,0x4
L_8cc11e:
	mov_s r13,r1
L_8cc120:
	bl.d L_8cc130
L_8cc124:
	mov_s r0,sp
L_8cc126:
	ld_s r1,[sp,0x0]
L_8cc128:
	stb_s r1,[r13]
L_8cc12a:
	b.d L_8c025c
L_8cc12e:
	add_s sp,sp,0x4
