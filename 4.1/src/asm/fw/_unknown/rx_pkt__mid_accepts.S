/* rx_pkt__mid_accepts @ 0x8defec, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r13_ret, mid_list__by_mid
 */
	.section .text.rx_pkt__mid_accepts,"ax",@progbits
	.global rx_pkt__mid_accepts
rx_pkt__mid_accepts:
	.global L_8defec
L_8defec:
	push_s blink
L_8defee:
	push_s r13
L_8deff0:
	mov_s r13,r1
L_8deff2:
	bl.d L_8ca1b0
L_8deff6:
	ldb r0,[r1, 0x35]
L_8deffa:
	ld_s r1,[r13,0x8]
L_8deffc:
	ldw_s r1,[r1]
L_8deffe:
	bic.f r1,r1,-0xf1
L_8df002:
	bne_s L_8df010
L_8df004:
	add r0,r0,0x234
L_8df008:
	ld_s r1,[r0]
L_8df00a:
	ld_s r2,[r1,0x4]
L_8df00c:
	jl_s.d [r2]
L_8df00e:
	mov_s r1,r13
	.global L_8df010
L_8df010:
	b L_8c033c
