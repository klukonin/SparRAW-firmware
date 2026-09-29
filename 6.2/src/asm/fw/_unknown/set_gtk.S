/* set_gtk @ 0x8e6704, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   In the set_gtk function. key_index: %d, key_usage: %d,cid: %d
 *    New GTK is handled:
 *    Fixed GTK:
 * Зовут его: wmi_add_cipher_key
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_log_emit3, hexdump_words, key__install_by_type
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global set_gtk
set_gtk:
	.global L_8e6704
L_8e6704:
	push_s blink
L_8e6706:
	bl L_8c01d4
L_8e670a:
	mov_s r16,r0
L_8e670c:
	mov_s r13,r1
L_8e670e:
	mov_s r14,r2
L_8e6710:
	mov_s r18,r3
L_8e6712:
	mov r17,r4
L_8e6716:
	mov_s r1,0x100cf34
L_8e671c:
	bl.d L_8dcd00
L_8e6720:
	mov_s r0,0x2e
L_8e6722:
	mov_s r1,0x100cf74
L_8e6728:
	bl.d L_8dcba8
L_8e672c:
	mov_s r0,0x2e
L_8e672e:
	mov_s r0,r13
L_8e6730:
	bl.d L_8c9790
L_8e6734:
	mov_s r1,0x10
L_8e6736:
	mov_s r2,0xf
L_8e6738:
	mov_s r1,0x0
L_8e673a:
	mov_s r15,r16
L_8e673c:
	mov lp_count,0x10
L_8e6740:
	add r15,r15,0x200
L_8e6744:
	lp L_8e6758
L_8e6748:
	ldb_s r0,[r13,r2]
L_8e674a:
	mov_s r3,r16
L_8e674c:
	add r3,r3,0x294
L_8e6750:
	add_s r3,r3,r1
L_8e6752:
	stb_s r0,[r3]
L_8e6754:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8e6756:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e6758
L_8e6758:
	stb r14,[r15, 0xa4]
L_8e675c:
	mov_s r1,0x100cf8c
L_8e6762:
	bl.d L_8dcba8
L_8e6766:
	mov_s r0,0x2e
L_8e6768:
	mov_s r13,r16
L_8e676a:
	add r13,r13,0x294
L_8e676e:
	mov_s r0,r13
L_8e6770:
	bl.d L_8c9790
L_8e6774:
	mov_s r1,0x10
L_8e6776:
	mov_s r0,r13
L_8e6778:
	ldb r1,[r15, 0xa4]
L_8e677c:
	mov_s r2,r18
L_8e677e:
	bl.d L_8d6e68
L_8e6782:
	mov_s r3,r17
L_8e6784:
	b L_8c0234
