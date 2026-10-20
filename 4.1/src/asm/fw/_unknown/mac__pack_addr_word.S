/* mac__pack_addr_word @ 0x8ce0c8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__program_mac_addr
 * Глобалы (через gp): 0x800270, 0x800274, 0x800278, 0x80027c
 */
	.section .text.mac__pack_addr_word,"ax",@progbits
	.global mac__pack_addr_word
mac__pack_addr_word:
	.global L_8ce0c8
L_8ce0c8:
	ldw_s r0,[gp,0x108]
L_8ce0ca:
	ldw.as r1,[gp,0x80]
L_8ce0ce:
	bmsk_s r0,r0,0xc
L_8ce0d0:
	asl_s r1,r1,0x10
L_8ce0d2:
	mov_s r2,0x1fff0000
L_8ce0d8:
	and_s r1,r1,r2
L_8ce0da:
	or_s r1,r1,r0
L_8ce0dc:
	bset_s r1,r1,0x1f
L_8ce0de:
	mov_s r0,0x88c000
L_8ce0e4:
	st_s r1,[r0,0x68]
L_8ce0e6:
	ldw.as r1,[gp,0x86]
L_8ce0ea:
	ldw.as r3,[gp,0x82]
L_8ce0ee:
	bmsk_s r1,r1,0xc
L_8ce0f0:
	asl_s r3,r3,0x10
L_8ce0f2:
	and_s r2,r2,r3
L_8ce0f4:
	or_s r1,r1,r2
L_8ce0f6:
	bset_s r1,r1,0x1f
L_8ce0f8:
	st_s r1,[r0,0x6c]
L_8ce0fa:
	j_s [blink]
