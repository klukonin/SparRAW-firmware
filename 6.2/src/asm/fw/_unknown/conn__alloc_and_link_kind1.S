/* conn__alloc_and_link_kind1 @ 0x8c733c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__association_done
 * Зовёт сам: conn__alloc_and_link
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__alloc_and_link_kind1
conn__alloc_and_link_kind1:
	.global L_8c733c
L_8c733c:
	mov_s r3,r0
L_8c733e:
	mov_s r2,r1
L_8c7340:
	mov_s r0,0x1
L_8c7342:
	b.d L_8e5258
L_8c7346:
	mov_s r1,r3
