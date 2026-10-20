/* gpio__880b64_set_bit18 @ 0x8e54fc, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.gpio__880b64_set_bit18,"ax",@progbits
	.global gpio__880b64_set_bit18
gpio__880b64_set_bit18:
L_8e54fc:
	lr r0,[0xa]
L_8e5500:
	bclr r1,r0,0x1
L_8e5504:
	flag r1
L_8e5508:
	mov_s r1,0x880b00
L_8e550e:
	st 0x40000,[r1, 0x64]
L_8e5516:
	lr r1,[0xa]
L_8e551a:
	bic r0,r0,-0x3
L_8e551e:
	or_s r0,r0,r1
L_8e5520:
	flag r0
