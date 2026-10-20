/* vring__reg_write_locked_0c @ 0x8cd64c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, l2mgr__mac_bringup, tx_dma_if__submit
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.vring__reg_write_locked_0c,"ax",@progbits
	.global vring__reg_write_locked_0c
vring__reg_write_locked_0c:
	.global L_8cd64c
L_8cd64c:
	push_s blink
L_8cd64e:
	push_s r13
L_8cd650:
	lr r13,[0xa]
L_8cd654:
	bclr r2,r13,0x1
L_8cd658:
	flag r2
L_8cd65c:
	mov_s r2,0x881c00
L_8cd662:
	st_s r0,[r2,0xc]
L_8cd664:
	breq_s r1,0,L_8cd66a
L_8cd666:
	sync
	.global L_8cd66a
L_8cd66a:
	lr r0,[0xa]
L_8cd66e:
	bic r13,r13,-0x3
L_8cd672:
	or_s r13,r13,r0
L_8cd674:
	flag r13
L_8cd678:
	b L_8c033c
