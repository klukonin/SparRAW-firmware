/* user_led__prepare_halt @ 0x8da774, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global user_led__prepare_halt
user_led__prepare_halt:
	.global L_8da774
L_8da774:
	mov_s r1,0x880280
L_8da77a:
	ld_s r0,[r1]
L_8da77c:
	bclr_s r0,r0,0x2
L_8da77e:
	or r0,r0,0x48
L_8da782:
	st_s r0,[r1]
L_8da784:
	ld_s r0,[r1]
L_8da786:
	bclr_s r0,r0,0x3
L_8da788:
	st_s r0,[r1]
L_8da78a:
	j_s [blink]
