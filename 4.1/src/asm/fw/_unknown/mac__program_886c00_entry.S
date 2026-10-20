/* mac__program_886c00_entry @ 0x8e4fc8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__disconnect_done
 */
	.section .text.mac__program_886c00_entry,"ax",@progbits
	.global mac__program_886c00_entry
mac__program_886c00_entry:
	.global L_8e4fc8
L_8e4fc8:
	push_s blink
L_8e4fca:
	mov_s r3,0x886c00
L_8e4fd0:
	st_s r0,[r3]
L_8e4fd2:
	st_s r1,[r3,0x4]
L_8e4fd4:
	st_s r2,[r3,0x8]
L_8e4fd6:
	mov_s r0,0x886b80
L_8e4fdc:
	st 0x80000000,[r0, 0x7c]
L_8e4fe4:
	st 0x40000000,[r0, 0x78]
L_8e4fec:
	sync
	.global L_8e4ff0
L_8e4ff0:
	mov_s r0,0x886b80
L_8e4ff6:
	ld_s r0,[r0,0x78]
L_8e4ff8:
	bbit1 r0,0x1d,L_8e4ff0
L_8e4ffc:
	pop_s blink
L_8e4ffe:
	j_s [blink]
