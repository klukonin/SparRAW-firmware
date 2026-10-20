/* assert__restore_hw_for_dump @ 0x8e864c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: hwd_pcie__set_low_power, hwd_phy__power_up_seq, hwm__apply_mode_flags, power_mngr__read_g800380
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global assert__restore_hw_for_dump
assert__restore_hw_for_dump:
	.global L_8e864c
L_8e864c:
	push_s blink
L_8e864e:
	bl.d L_8d7b84
L_8e8652:
	mov_s r0,0x0
L_8e8654:
	bl L_8cc1fc
L_8e8658:
	add r1,r0,0xc
L_8e865c:
	bl.d L_8d7818
L_8e8660:
	mov_s r0,0x0
L_8e8662:
	bl.d L_8d77dc
L_8e8666:
	mov_s r0,0x0
L_8e8668:
	pop_s blink
L_8e866a:
	j_s [blink]
