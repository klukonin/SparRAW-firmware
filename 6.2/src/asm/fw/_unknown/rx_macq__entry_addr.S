/* rx_macq__entry_addr @ 0x8ccb68, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, l2_offload__cfg_rx_decap, l2mgr__data_port_open_and_keys, rx_macq__init, sw_vring__ba_agreed, wmi_cfg_rx_chain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__entry_addr
rx_macq__entry_addr:
	.global L_8ccb68
L_8ccb68:
	asl_s r1,r0,0x4
L_8ccb6a:
	add r0,r1,0x843188
L_8ccb72:
	j_s [blink]
