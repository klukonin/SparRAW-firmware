/* pcie__set_event_bit @ 0x8cedf0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__HOST_8edad4, WBE_DRIVER__link_down, tail_pcie__set_event_bit, tail_pcie__set_event_bit_8cee50, tail_pcie__set_event_bit_8cee58, tail_pcie__set_event_bit_8cee60, tail_pcie__set_event_bit_8cee68, tail_pcie__set_event_bit_8cee70
 * Зовёт сам: __ld_r13_ret, hwd_pcie_exit_l1
 */
	.section .text.pcie__set_event_bit,"ax",@progbits
	.global pcie__set_event_bit
pcie__set_event_bit:
	.global L_8cedf0
L_8cedf0:
	push_s blink
L_8cedf2:
	push_s r13
L_8cedf4:
	mov_s r13,r0
L_8cedf6:
	bl.d L_8ce578
L_8cedfa:
	mov_s r0,0x1
L_8cedfc:
	mov_s r1,0x0
L_8cedfe:
	bset r1,r1,r13
L_8cee02:
	mov_s r0,0x882680
L_8cee08:
	st_s r1,[r0,0x30]
L_8cee0a:
	sync
L_8cee0e:
	bl.d L_8ce578
L_8cee12:
	mov_s r0,0x0
L_8cee14:
	b L_8c033c
