/* mac__current_sector_index @ 0x93432c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__tx_sector_frame, ucode_cmd_0x0c_handler
 */
	.section .text.mac__current_sector_index,"ax",@progbits
	.global mac__current_sector_index
mac__current_sector_index:
	.global L_93432c
L_93432c:
	push_s r13
L_93432e:
	mov_s r2,0x886d00
L_934334:
	ld_s r3,[r2,0xc]
L_934336:
	mov_s r13,0x800a38
L_93433c:
	ld_s r2,[r13,0xc]
L_93433e:
	lsr_s r3,r3,0x18
L_934340:
	add_s r2,r2,r3
L_934342:
	mul64_s r2,r1
L_934344:
	stw mlo,[r0]
L_934348:
	ld_s r1,[r13,0xc]
L_93434a:
	stw_s r3,[r0,0x4]
L_93434c:
	stw_s r1,[r0,0x2]
L_93434e:
	j_s.d [blink]
L_934350:
	pop_s r13
L_934352:
	nop_s
