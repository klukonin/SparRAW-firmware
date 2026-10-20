/* lmac_mbox__drain_task @ 0x8ca22c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_mailbox__has_pending, mbox__consume_one
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_mbox__drain_task
lmac_mbox__drain_task:
	.global L_8ca22c
L_8ca22c:
	push_s blink
L_8ca22e:
	push_s r13
L_8ca230:
	b_s L_8ca238
	.global L_8ca232
L_8ca232:
	bl.d L_8e3764
L_8ca236:
	mov_s r0,r13
	.global L_8ca238
L_8ca238:
	mov_s r13,0x804280
L_8ca23e:
	bl.d L_8c37ec
L_8ca242:
	mov_s r0,r13
L_8ca244:
	brne_s r0,0,L_8ca232
L_8ca246:
	mov r1,0x200
L_8ca24a:
	mov_s r0,0x880b00
L_8ca250:
	st_s r1,[r0,0x64]
L_8ca252:
	sync
L_8ca256:
	b L_8c025c
L_8ca25a:
	nop_s
