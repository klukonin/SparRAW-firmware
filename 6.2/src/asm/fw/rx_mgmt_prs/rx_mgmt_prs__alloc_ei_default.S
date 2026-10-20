/* rx_mgmt_prs__alloc_ei_default @ 0x8e3c3c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery__rx_pkt_handler, rx_pkt_handler
 * Зовёт сам: rx_mgmt_prs__alloc_ei
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt_prs__alloc_ei_default
rx_mgmt_prs__alloc_ei_default:
	.global L_8e3c3c
L_8e3c3c:
	mov_s r1,r0
L_8e3c3e:
	mov_s r0,0x842840
L_8e3c44:
	b L_8e0a84
