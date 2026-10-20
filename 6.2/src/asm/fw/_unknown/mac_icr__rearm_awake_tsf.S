/* mac_icr__rearm_awake_tsf @ 0x8e9a78, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_icr__rearm_awake_tsf
mac_icr__rearm_awake_tsf:
	.global L_8e9a78
L_8e9a78:
	mov_s r0,0x886e00
L_8e9a7e:
	st 0x8000,[r0, 0x40]
L_8e9a86:
	st 0x8000,[r0, 0x54]
L_8e9a8e:
	j_s [blink]
