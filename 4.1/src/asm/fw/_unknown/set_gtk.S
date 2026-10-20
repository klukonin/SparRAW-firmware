/* set_gtk @ 0x8e1898, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   In the set_gtk function. key_index: %d, key_usage: %d,cid: %d
 *    New GTK is handled:
 *    Fixed GTK:
 * Зовут его: WMI_ADD_CIPHER_KEY_CMD
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit0, fw_log__emit3, key__install_by_type, log_hexdump
 */
	.section .text.set_gtk,"ax",@progbits
	.global set_gtk
set_gtk:
	.global L_8e1898
L_8e1898:
	push_s blink
L_8e189a:
	bl L_8c02b4
L_8e189e:
	mov_s r16,r0
L_8e18a0:
	mov_s r13,r1
L_8e18a2:
	mov_s r15,r2
L_8e18a4:
	mov_s r18,r3
L_8e18a6:
	mov r17,r4
L_8e18aa:
	mov_s r2,0x100ba18
L_8e18b0:
	mov_s r0,0xe
L_8e18b2:
	mov_s r1,0x2
L_8e18b4:
	mov_s r3,r15
L_8e18b6:
	mov r4,r18
L_8e18ba:
	bl.d L_8ee034
L_8e18be:
	mov r5,r17
L_8e18c2:
	mov_s r2,0x100ba58
L_8e18c8:
	mov_s r0,0xe
L_8e18ca:
	bl.d L_8edfb0
L_8e18ce:
	mov_s r1,0x2
L_8e18d0:
	mov_s r0,r13
L_8e18d2:
	bl.d L_8c7f90
L_8e18d6:
	mov_s r1,0x10
L_8e18d8:
	mov_s r3,0xf
L_8e18da:
	mov_s r1,0x0
L_8e18dc:
	mov_s r14,r16
L_8e18de:
	add r14,r14,0x2c0
L_8e18e2:
	mov lp_count,0x10
L_8e18e6:
	add r2,r14,0xc
L_8e18ea:
	lp L_8e18f8
L_8e18ee:
	ldb_s r0,[r13,r3]
L_8e18f0:
	add_s r12,r2,r1
L_8e18f2:
	stb_s r0,[r12]
L_8e18f4:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8e18f6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e18f8
L_8e18f8:
	stb_s r15,[r14,0x1c]
L_8e18fa:
	mov_s r2,0x100ba70
L_8e1900:
	mov_s r0,0xe
L_8e1902:
	bl.d L_8edfb0
L_8e1906:
	mov_s r1,0x2
L_8e1908:
	add r16,r16,0x2cc
L_8e190c:
	mov_s r0,r16
L_8e190e:
	bl.d L_8c7f90
L_8e1912:
	mov_s r1,0x10
L_8e1914:
	mov_s r0,r16
L_8e1916:
	ldb_s r1,[r14,0x1c]
L_8e1918:
	mov_s r2,r18
L_8e191a:
	bl.d L_8d4104
L_8e191e:
	mov_s r3,r17
L_8e1920:
	b L_8c0314
