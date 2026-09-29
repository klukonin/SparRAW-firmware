/* rss_wait__get @ 0x9282a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_init__flow, txss_resp__flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rss_wait__get
rss_wait__get:
	.global L_9282a8
L_9282a8:
	mov_s r1,0x8020c4
L_9282ae:
	j_s.d [blink]
L_9282b0:
	ld.as r0,[r1,r0]
