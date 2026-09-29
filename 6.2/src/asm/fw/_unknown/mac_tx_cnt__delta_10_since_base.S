/* mac_tx_cnt__delta_10_since_base @ 0x8dd78c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ts_ring__time_delta_a_thunk
 * Глобалы (через gp): 0x8002e0, 0x8003d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_tx_cnt__delta_10_since_base
mac_tx_cnt__delta_10_since_base:
	.global L_8dd78c
L_8dd78c:
	ld_s r0,[gp,0x250]
L_8dd78e:
	ld_s r1,[r0,0x10]
L_8dd790:
	ld_s r0,[gp,0x15c]
L_8dd792:
	j_s.d [blink]
L_8dd794:
	rsub r0,r0,r1
