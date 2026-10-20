/* cpu__aux28_set_bits12_fw @ 0x8c02a4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cpu__aux28_set_bits12_fw
cpu__aux28_set_bits12_fw:
	.global L_8c02a4
L_8c02a4:
	lr r0,[0xa]
L_8c02a8:
	or r0,r0,0x6
L_8c02ac:
	j.d [blink]
L_8c02b0:
	flag r0
L_8c02b4:
	lr r0,[0xa]
L_8c02b8:
	or r0,r0,0x2
L_8c02bc:
	j.d [blink]
L_8c02c0:
	flag r0
L_8c02c4:
	lr r0,[0xa]
L_8c02c8:
	or r0,r0,0x4
L_8c02cc:
	j.d [blink]
L_8c02d0:
	flag r0
