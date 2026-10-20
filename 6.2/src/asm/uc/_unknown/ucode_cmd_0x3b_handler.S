/* ucode_cmd_0x3b_handler @ 0x926954, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x3b_handler
ucode_cmd_0x3b_handler:
	.global L_926954
L_926954:
	mov_s r1,0x80088c
L_92695a:
	j_s.d [blink]
L_92695c:
	st_s r0,[r1]
L_92695e:
	nop_s
