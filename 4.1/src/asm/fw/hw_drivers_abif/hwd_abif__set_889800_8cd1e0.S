/* hwd_abif__set_889800_8cd1e0 @ 0x8cd1e0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abif__program_rf_clock_and_wait
 */
	.section .text.hwd_abif__set_889800_8cd1e0,"ax",@progbits
	.global hwd_abif__set_889800_8cd1e0
hwd_abif__set_889800_8cd1e0:
	.global L_8cd1e0
L_8cd1e0:
	mov_s r1,0x80
L_8cd1e2:
	mov_s r0,0x889800
L_8cd1e8:
	st.as r1,[r0,-0xe4]
L_8cd1ec:
	st.as r1,[r0,-0xdf]
L_8cd1f0:
	j_s [blink]
L_8cd1f2:
	nop_s
