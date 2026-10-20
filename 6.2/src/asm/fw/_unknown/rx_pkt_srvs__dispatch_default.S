/* rx_pkt_srvs__dispatch_default @ 0x8e3a90, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_api__drain_list
 * Зовёт сам: rx_pkt_srvs__dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt_srvs__dispatch_default
rx_pkt_srvs__dispatch_default:
	.global L_8e3a90
L_8e3a90:
	mov_s r1,r0
L_8e3a92:
	mov_s r0,0x842840
L_8e3a98:
	b L_8e3c70
