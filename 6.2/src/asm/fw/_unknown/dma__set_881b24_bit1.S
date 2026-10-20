/* dma__set_881b24_bit1 @ 0x8df5c4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_dma__build_desc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, radio_mgr__call_method_10, wmi_handler_get_rf_sector_params__on_radio_locked_cb, wmi_handler_set_rf_sector_params__set_rf_sector_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma__set_881b24_bit1
dma__set_881b24_bit1:
	.global L_8df5c4
L_8df5c4:
	mov_s r1,0x881b00
L_8df5ca:
	ld_s r0,[r1,0x24]
L_8df5cc:
	bset_s r0,r0,0x1
L_8df5ce:
	st_s r0,[r1,0x24]
L_8df5d0:
	j_s [blink]
L_8df5d2:
	nop_s
L_8df5d4:
	push_s blink
L_8df5d6:
	bl L_8c01e4
L_8df5da:
	mov_s r14,r0
L_8df5dc:
	mov_s r13,r1
L_8df5de:
	bl.d L_8cd2dc
L_8df5e2:
	mov_s r0,r1
L_8df5e4:
	bl.d L_8ea800
L_8df5e8:
	mov_s r0,r14
L_8df5ea:
	mov_s r0,0x0
L_8df5ec:
	b.d L_8c0254
L_8df5f0:
	st_s r0,[r13,0x8]
L_8df5f2:
	nop_s
L_8df5f4:
	push_s blink
L_8df5f6:
	bl L_8c01e4
L_8df5fa:
	mov_s r14,r0
L_8df5fc:
	mov_s r13,r1
L_8df5fe:
	bl.d L_8cd410
L_8df602:
	mov_s r0,r1
L_8df604:
	bl.d L_8ea800
L_8df608:
	mov_s r0,r14
L_8df60a:
	mov_s r0,0x0
L_8df60c:
	b.d L_8c0254
L_8df610:
	st r0,[r13, 0xc8]
