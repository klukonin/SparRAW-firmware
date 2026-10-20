/* mac__set_own_addr @ 0x8e8548, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__apply_mac_address, rm_ch_switch__program_mac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_own_addr
mac__set_own_addr:
	.global L_8e8548
L_8e8548:
	ldw_s r1,[r0,0x2]
L_8e854a:
	ldw_s r2,[r0]
L_8e854c:
	asl_s r1,r1,0x10
L_8e854e:
	or_s r1,r1,r2
L_8e8550:
	mov_s r2,0x886d80
L_8e8556:
	st_s r1,[r2,0x70]
L_8e8558:
	ldw_s r0,[r0,0x4]
L_8e855a:
	st_s r0,[r2,0x74]
L_8e855c:
	j_s [blink]
L_8e855e:
	nop_s
