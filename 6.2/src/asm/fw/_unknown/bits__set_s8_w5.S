/* bits__set_s8_w5 @ 0x8ed580, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ftm_main_sm__radio_allocated_cb, install_key__parse_flags, mac_filter__write_entries, stream_mgr__prepare_1f
 * Зовёт сам: bf__set_field_word_fw, rm_main_sm__inject_lock_evt, rx_pkt_srvs__dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bits__set_s8_w5
bits__set_s8_w5:
	.global L_8ed580
L_8ed580:
	mov r10,0x8
L_8ed584:
	b.d L_8edcb8
L_8ed588:
	mov r11,0x4
L_8ed58c:
	b.d L_8e3c70
L_8ed590:
	/* _sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
L_8ed592:
	nop_s
L_8ed594:
	j_s [blink]
L_8ed596:
	nop_s
L_8ed598:
	j_s [blink]
L_8ed59a:
	nop_s
L_8ed59c:
	ld_s r2,[r0]
L_8ed59e:
	ld_s r0,[r0,0x4]
L_8ed5a0:
	st_s r2,[r1]
L_8ed5a2:
	j_s.d [blink]
L_8ed5a4:
	st_s r0,[r1,0x4]
L_8ed5a6:
	nop_s
L_8ed5a8:
	mov_s r0,0x0
L_8ed5aa:
	stb_s r0,[r2]
L_8ed5ac:
	stb_s r0,[r2,0x1]
L_8ed5ae:
	j_s.d [blink]
L_8ed5b0:
	mov_s r0,0x1
L_8ed5b2:
	nop_s
L_8ed5b4:
	j_s.d [blink]
L_8ed5b6:
	mov_s r0,0x1
L_8ed5b8:
	j_s.d [blink]
L_8ed5ba:
	mov_s r0,0x1
L_8ed5bc:
	j_s.d [blink]
L_8ed5be:
	mov_s r0,0x1
L_8ed5c0:
	j_s.d [blink]
L_8ed5c2:
	mov_s r0,0x1
L_8ed5c4:
	j_s.d [blink]
L_8ed5c6:
	mov_s r0,0x1
L_8ed5c8:
	j_s.d [blink]
L_8ed5ca:
	mov_s r0,0x1
L_8ed5cc:
	j_s.d [blink]
L_8ed5ce:
	ld_s r0,[r0,0x10]
L_8ed5d0:
	j_s.d [blink]
L_8ed5d2:
	ld_s r0,[r0,0x18]
L_8ed5d4:
	sub_s sp,sp,0x4
L_8ed5d6:
	mov r0,-0x1
L_8ed5da:
	st_s r0,[r2,0x8]
L_8ed5dc:
	j_s.d [blink]
L_8ed5de:
	add_s sp,sp,0x4
L_8ed5e0:
	j_s.d [blink]
L_8ed5e2:
	mov_s r0,r1
L_8ed5e4:
	b.d L_8cd294
L_8ed5e8:
	add_s r0,r0,0x28
L_8ed5ea:
	nop_s
