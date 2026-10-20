/* mac__get_beacon_interval_tu @ 0x8e9868, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__get_beacon_interval_tu
mac__get_beacon_interval_tu:
	.global L_8e9868
L_8e9868:
	mov_s r0,0x886d00
L_8e986e:
	ld_s r0,[r0,0x64]
L_8e9870:
	j_s.d [blink]
L_8e9872:
	extw_s r0,r0
