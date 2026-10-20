/* range_check_lt3 @ 0x8da75c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_ch__enable_once
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global range_check_lt3
range_check_lt3:
	.global L_8da75c
L_8da75c:
	brhs.d r0,0x3,L_8da766
L_8da760:
	push_s blink
	.global L_8da762
L_8da762:
	pop_s blink
L_8da764:
	j_s [blink]
	.global L_8da766
L_8da766:
	mov_s r0,blink
L_8da768:
	mov_s r1,0xb
L_8da76a:
	bl.d L_8c9b28
L_8da76e:
	bset_s r1,r1,0xc
L_8da770:
	b_s L_8da762
L_8da772:
	nop_s
