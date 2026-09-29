/* vring__reg_write_locked_20 @ 0x8cd67c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring, fwq_tx__handle_completion, tx_dma_if__submit
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.vring__reg_write_locked_20,"ax",@progbits
	.global vring__reg_write_locked_20
vring__reg_write_locked_20:
	.global L_8cd67c
L_8cd67c:
	push_s blink
L_8cd67e:
	push_s r13
L_8cd680:
	lr r13,[0xa]
L_8cd684:
	bclr r2,r13,0x1
L_8cd688:
	flag r2
L_8cd68c:
	mov_s r2,0x881c00
L_8cd692:
	st_s r0,[r2,0x20]
L_8cd694:
	breq_s r1,0,L_8cd69a
L_8cd696:
	sync
	.global L_8cd69a
L_8cd69a:
	lr r0,[0xa]
L_8cd69e:
	bic r13,r13,-0x3
L_8cd6a2:
	or_s r13,r13,r0
L_8cd6a4:
	flag r13
L_8cd6a8:
	b L_8c033c
