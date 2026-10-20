/* hwd_pcie__get_882b80 @ 0x8d1428, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, fw_vector_16, hwd_pcie_exit_l1, pcie__ready_for_deep_sleep
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__get_882b80
hwd_pcie__get_882b80:
	.global L_8d1428
L_8d1428:
	mov_s r0,0x882b80
L_8d142e:
	ld_s r0,[r0,0x8]
L_8d1430:
	j_s.d [blink]
L_8d1432:
	bmsk_s r0,r0,0x0
