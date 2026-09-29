/* lmac_if_link_lost_handler @ 0x8d8620, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r13_ret, bf_w_s8_w24, l2_mgr__lmac_high_false_alarm_evt_handler, sta_ctx__reset, sta_trace__push_record
 */
	.section .text.lmac_if_link_lost_handler,"ax",@progbits
	.global lmac_if_link_lost_handler
lmac_if_link_lost_handler:
	.global L_8d8620
L_8d8620:
	push_s blink
L_8d8622:
	push_s r13
L_8d8624:
	mov_s r13,r0
L_8d8626:
	mov_s r0,0x80345c
L_8d862c:
	ld_s r0,[r0,0x18]
L_8d862e:
	bbit1 r0,0x1,L_8d8658
L_8d8632:
	ld_s r0,[r13,0x8]
L_8d8634:
	cmp_s r0,0x1
L_8d8636:
	bl.eq L_8edc48
L_8d863a:
	bl.d L_8e34e4
L_8d863e:
	mov_s r0,0x7
L_8d8640:
	mov_s r2,r0
L_8d8642:
	mov_s r0,0x1
L_8d8644:
	stb_s r0,[r2,0xc]
L_8d8646:
	ld_s r1,[r13,0x8]
L_8d8648:
	add r0,r2,0xc
L_8d864c:
	bmsk_s r1,r1,0x17
L_8d864e:
	bl L_8e854c
L_8d8652:
	bl.d L_8e3488
L_8d8656:
	mov_s r0,0x7
	.global L_8d8658
L_8d8658:
	b L_8c033c
