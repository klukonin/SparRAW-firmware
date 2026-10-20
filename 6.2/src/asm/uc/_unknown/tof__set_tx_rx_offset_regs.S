/* tof__set_tx_rx_offset_regs @ 0x929d10, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610, mac_mode__switch_sequence, ucode_cmd_0x2c_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tof__set_tx_rx_offset_regs
tof__set_tx_rx_offset_regs:
	.global L_929d10
L_929d10:
	mov_s r2,0x889800
L_929d16:
	st.as r0,[r2,-0xae]
L_929d1a:
	st.as r1,[r2,-0xac]
L_929d1e:
	j_s [blink]
