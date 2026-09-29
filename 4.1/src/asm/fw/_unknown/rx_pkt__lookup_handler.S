/* rx_pkt__lookup_handler @ 0x8c9f74, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r13_ret, get_g_800140_8c9f8c
 */
	.section .text.rx_pkt__lookup_handler,"ax",@progbits
	.global rx_pkt__lookup_handler
rx_pkt__lookup_handler:
	.global L_8c9f74
L_8c9f74:
	push_s blink
L_8c9f76:
	push_s r13
L_8c9f78:
	sub_s sp,sp,0x4
L_8c9f7a:
	mov_s r13,r1
L_8c9f7c:
	bl.d L_8c9f8c
L_8c9f80:
	mov_s r0,sp
L_8c9f82:
	ld_s r1,[sp,0x0]
L_8c9f84:
	stb_s r1,[r13]
L_8c9f86:
	b.d L_8c033c
L_8c9f8a:
	add_s sp,sp,0x4
