/* rx_pkt__mid_accepts @ 0x8e3b7c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt__mid_accepts
rx_pkt__mid_accepts:
	.global L_8e3b7c
L_8e3b7c:
	push_s blink
L_8e3b7e:
	push_s r13
L_8e3b80:
	mov_s r13,r1
L_8e3b82:
	bl.d L_8cc3dc
L_8e3b86:
	ldb r0,[r1, 0x35]
L_8e3b8a:
	ld_s r1,[r13,0x8]
L_8e3b8c:
	ldw_s r1,[r1]
L_8e3b8e:
	bic.f r1,r1,-0xf1
L_8e3b92:
	bne_s L_8e3ba0
L_8e3b94:
	add r0,r0,0x234
L_8e3b98:
	ld_s r1,[r0]
L_8e3b9a:
	ld_s r2,[r1,0x4]
L_8e3b9c:
	jl_s.d [r2]
L_8e3b9e:
	mov_s r1,r13
	.global L_8e3ba0
L_8e3ba0:
	b L_8c025c
