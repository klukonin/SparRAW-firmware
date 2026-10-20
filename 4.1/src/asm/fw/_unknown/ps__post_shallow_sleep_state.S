/* ps__post_shallow_sleep_state @ 0x8f0d08, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_ps_shallow_sleep_ntf_handler
 * Зовёт сам: L2MGR__system_state_evt_handler
 */
	.section .text.ps__post_shallow_sleep_state,"ax",@progbits
	.global ps__post_shallow_sleep_state
ps__post_shallow_sleep_state:
	.global L_8f0d08
L_8f0d08:
	cmp_s r0,0x0
L_8f0d0a:
	mov_s r0,0x14
L_8f0d0c:
	mov.eq r0,0x15
L_8f0d10:
	mov.eq r1,0x0
L_8f0d14:
	b L_8e3a08
