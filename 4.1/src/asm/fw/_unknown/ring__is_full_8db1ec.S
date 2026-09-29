/* ring__is_full_8db1ec @ 0x8db1ec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_mbox__is_full
 */
	.section .text.ring__is_full_8db1ec,"ax",@progbits
	.global ring__is_full_8db1ec
ring__is_full_8db1ec:
	.global L_8db1ec
L_8db1ec:
	ld_s r0,[r0,0x14]
L_8db1ee:
	ld_s r1,[r0,0xc]
L_8db1f0:
	ld_s r0,[r0,0x10]
L_8db1f2:
	cmp_s r1,r0
L_8db1f4:
	mov_s r0,0x1
L_8db1f6:
	j_s.d [blink]
L_8db1f8:
	sub.cs r0,r0,r0
