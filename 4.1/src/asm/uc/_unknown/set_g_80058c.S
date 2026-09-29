/* set_g_80058c @ 0x936d40, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd__rx_on, ucode_pm__rx_off_step
 * Зовёт сам: uc_read_tsf64
 * Глобалы (через gp): 0x80058c
 */
	.section .text.set_g_80058c,"ax",@progbits
	.global set_g_80058c
set_g_80058c:
	.global L_936d40
L_936d40:
	mov_s r0,0x1
L_936d42:
	st.as r0,[gp,0x19]
L_936d46:
	mov_s r0,0x8009d4
L_936d4c:
	b L_930cb0
