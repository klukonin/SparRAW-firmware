/* pbss__disconnect_by_peer @ 0x8c7ab4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PBSS Disconnection: MAC-ADDR-%04X%08X
 * Зовут его: disconnect_by_peer
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__disconnect, fw_log__emit2, iter__has_more, iter__init, iter__next
 */
	.section .text.pbss__disconnect_by_peer,"ax",@progbits
	.global pbss__disconnect_by_peer
pbss__disconnect_by_peer:
	.global L_8c7ab4
L_8c7ab4:
	push_s blink
L_8c7ab6:
	bl L_8c02bc
L_8c7aba:
	sub_s sp,sp,0x4
L_8c7abc:
	mov_s r16,r1
L_8c7abe:
	mov_s r15,r2
L_8c7ac0:
	mov_s r14,sp
L_8c7ac2:
	add r1,r0,0x18
L_8c7ac6:
	bl.d L_8e1138
L_8c7aca:
	mov_s r0,r14
L_8c7acc:
	b_s L_8c7ada
	.global L_8c7ace
L_8c7ace:
	bl.d L_8db188
L_8c7ad2:
	mov_s r0,r14
L_8c7ad4:
	mov_s r13,r0
L_8c7ad6:
	ld_s r0,[r0,0x1c]
L_8c7ad8:
	brne_s r0,0,L_8c7ae8
	.global L_8c7ada
L_8c7ada:
	bl.d L_8cb674
L_8c7ade:
	mov_s r0,r14
L_8c7ae0:
	brne_s r0,0,L_8c7ace
L_8c7ae2:
	b.d L_8c0324
L_8c7ae6:
	add_s sp,sp,0x4
	.global L_8c7ae8
L_8c7ae8:
	add r3,r13,0x10
L_8c7aec:
	mov_s r2,0x100b734
L_8c7af2:
	ld r4,[r3]
L_8c7af6:
	mov_s r0,0xb
L_8c7af8:
	mov_s r1,0x2
L_8c7afa:
	bl.d L_8edff8
L_8c7afe:
	ldb_s r3,[r3,0x2]
L_8c7b00:
	mov_s r0,r13
L_8c7b02:
	mov_s r1,r16
L_8c7b04:
	bl.d L_8eb190
L_8c7b08:
	mov_s r2,r15
L_8c7b0a:
	b_s L_8c7ada
