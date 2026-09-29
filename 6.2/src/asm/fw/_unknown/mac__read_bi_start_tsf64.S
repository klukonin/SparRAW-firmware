/* mac__read_bi_start_tsf64 @ 0x8e9890, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__read_next_tbtt64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_bi_start_tsf64
mac__read_bi_start_tsf64:
	.global L_8e9890
L_8e9890:
	breq_s r2,0,L_8e989e
	.global L_8e9892
L_8e9892:
	mov_s r0,0x886e80
L_8e9898:
	ld_s r0,[r0,0x34]
L_8e989a:
	bbit0 r0,0x1f,L_8e9892
	.global L_8e989e
L_8e989e:
	mov_s r2,0x886f80
L_8e98a4:
	ld_s r3,[r2,0x44]
L_8e98a6:
	st_s r3,[r1]
L_8e98a8:
	ld_s r0,[r2,0x48]
L_8e98aa:
	st_s r0,[r1,0x4]
L_8e98ac:
	ld_s r0,[r2,0x44]
L_8e98ae:
	brne r3,r0,L_8e989e
L_8e98b2:
	j_s [blink]
