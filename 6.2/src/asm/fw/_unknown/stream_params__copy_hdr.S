/* stream_params__copy_hdr @ 0x8cc19c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__build_params, sw_vring__ba_params
 * Зовёт сам: bits__set32_s0_w12, bits__set32_s0_w4, bits__set32_s12_w12, bits__set32_s16_w12, bits__set32_s4_w12
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_params__copy_hdr
stream_params__copy_hdr:
	.global L_8cc19c
L_8cc19c:
	push_s blink
L_8cc19e:
	mov_s r3,r0
L_8cc1a0:
	ldw_s r0,[r0]
L_8cc1a2:
	mov_s r2,r1
L_8cc1a4:
	stw_s r0,[r1,0x6]
L_8cc1a6:
	ldw_s r0,[r3,0x4]
L_8cc1a8:
	stw_s r0,[r1,0x4]
L_8cc1aa:
	ldw_s r0,[r3]
L_8cc1ac:
	stw_s r0,[r1]
L_8cc1ae:
	ldw_s r0,[r3]
L_8cc1b0:
	stw_s r0,[r1,0x2]
L_8cc1b2:
	add r0,r1,0x8
L_8cc1b6:
	mov r1,0x3e5
L_8cc1ba:
	bl L_8ed340
L_8cc1be:
	ldw_s r1,[r3,0x2]
L_8cc1c0:
	bmsk_s r1,r1,0xb
L_8cc1c2:
	bl L_8ed3a0
L_8cc1c6:
	ldw_s r0,[r3,0x2]
L_8cc1c8:
	stb_s r0,[r2,0xb]
L_8cc1ca:
	ldw_s r1,[r3,0x2]
L_8cc1cc:
	add r0,r2,0xc
L_8cc1d0:
	asr_s r1,r1,0x8
L_8cc1d2:
	bmsk_s r1,r1,0x3
L_8cc1d4:
	bl L_8ed370
L_8cc1d8:
	ldw_s r1,[r3,0x8]
L_8cc1da:
	bmsk_s r1,r1,0xb
L_8cc1dc:
	bl L_8ed4f0
L_8cc1e0:
	ldw_s r1,[r3,0x2]
L_8cc1e2:
	bmsk_s r1,r1,0xb
L_8cc1e4:
	bl L_8ed3e8
L_8cc1e8:
	pop_s blink
L_8cc1ea:
	j_s [blink]
