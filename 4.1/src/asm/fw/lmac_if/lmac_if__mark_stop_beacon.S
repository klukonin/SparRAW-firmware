/* lmac_if__mark_stop_beacon @ 0x8d8154, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__stop_beacon
 */
	.section .text.lmac_if__mark_stop_beacon,"ax",@progbits
	.global lmac_if__mark_stop_beacon
lmac_if__mark_stop_beacon:
	.global L_8d8154
L_8d8154:
	mov_s r1,0x1
L_8d8156:
	j_s.d [blink]
L_8d8158:
	st_s r1,[r0]
L_8d815a:
	nop_s
