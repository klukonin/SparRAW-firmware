/* rx_macq__program_offload_desc_with_b4 @ 0x8e2474, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 * Зовёт сам: rx_macq__program_offload_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__program_offload_desc_with_b4
rx_macq__program_offload_desc_with_b4:
	.global L_8e2474
L_8e2474:
	b.d L_8df65c
L_8e2478:
	stb_s r1,[r0,0x4]
L_8e247a:
	nop_s
