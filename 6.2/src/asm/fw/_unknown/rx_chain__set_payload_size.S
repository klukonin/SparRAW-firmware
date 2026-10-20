/* rx_chain__set_payload_size @ 0x8e7138, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_cfg_rx_chain
 * Глобалы (через gp): 0x80020c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__set_payload_size
rx_chain__set_payload_size:
	.global L_8e7138
L_8e7138:
	j_s.d [blink]
L_8e713a:
	stw.as r0,[gp,0x44]
L_8e713e:
	nop_s
