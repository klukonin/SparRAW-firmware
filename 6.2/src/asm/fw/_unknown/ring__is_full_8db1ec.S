/* ring__is_full_8db1ec @ 0x8df49c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_mbox__is_full
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ring__is_full_8db1ec
ring__is_full_8db1ec:
	.global L_8df49c
L_8df49c:
	ld_s r0,[r0,0x14]
L_8df49e:
	ld_s r1,[r0,0xc]
L_8df4a0:
	ld_s r0,[r0,0x10]
L_8df4a2:
	cmp_s r1,r0
L_8df4a4:
	mov_s r0,0x1
L_8df4a6:
	j_s.d [blink]
L_8df4a8:
	sub.cs r0,r0,r0
