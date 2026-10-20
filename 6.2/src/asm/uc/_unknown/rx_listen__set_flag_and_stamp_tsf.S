/* rx_listen__set_flag_and_stamp_tsf @ 0x93c864, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__enter_listen_mode, ucode_cmd_0x01_handler
 * Зовёт сам: mac__read_tsf64_uc
 * Глобалы (через gp): 0x800588
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_listen__set_flag_and_stamp_tsf
rx_listen__set_flag_and_stamp_tsf:
	.global L_93c864
L_93c864:
	mov_s r0,0x1
L_93c866:
	st.as r0,[gp,0x18]
L_93c86a:
	mov_s r0,0x8014ac
L_93c870:
	b L_9356cc
