/* fw_stats_blk__init @ 0x8f538c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, fw_stats_blk__bits_set32_s24_w4, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_stats_blk__init
fw_stats_blk__init:
	.global L_8f538c
L_8f538c:
	push_s blink
L_8f538e:
	push_s r13
L_8f5390:
	mov_s r13,0x853800
L_8f5396:
	mov_s r0,r13
L_8f5398:
	bl.d L_8c1cd8
L_8f539c:
	mov r1,0x1c0
L_8f53a0:
	mov_s r0,0x5
L_8f53a2:
	st_s r0,[r13]
L_8f53a4:
	mov r0,0x1c0
L_8f53a8:
	stw_s r0,[r13,0x4]
L_8f53aa:
	mov_s r1,0xf
L_8f53ac:
	add3 r0,r13,0x23
L_8f53b0:
	bl L_8ed46c
L_8f53b4:
	b L_8c025c
