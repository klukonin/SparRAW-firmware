/* rladder__mark_invalid @ 0x8c075c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rladder_scan
 */
	.section .text.rladder__mark_invalid,"ax",@progbits
	.global rladder__mark_invalid
rladder__mark_invalid:
	.global L_8c075c
L_8c075c:
	mov r3,-0x1
L_8c0760:
	brne_s r0,0,L_8c076a
L_8c0762:
	stb_s r3,[r1]
L_8c0764:
	mov_s r0,0x1
L_8c0766:
	stb_s r0,[r2]
L_8c0768:
	/* b_s 0x008c0770 */
	.byte 0x04,0xf0
	.global L_8c076a
L_8c076a:
	mov_s r0,0x20
L_8c076c:
	stb_s r0,[r1]
L_8c076e:
	stb_s r3,[r2]
