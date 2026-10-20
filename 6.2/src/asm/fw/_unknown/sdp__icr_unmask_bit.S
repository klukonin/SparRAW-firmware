/* sdp__icr_unmask_bit @ 0x8d477c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__init_pair
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__icr_unmask_bit
sdp__icr_unmask_bit:
	.global L_8d477c
L_8d477c:
	mov_s r1,0x0
L_8d477e:
	bset r1,r1,r0
L_8d4782:
	mov_s r0,0x880b00
L_8d4788:
	st_s r1,[r0,0x64]
L_8d478a:
	j_s [blink]
