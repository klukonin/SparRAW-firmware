/* rx_desc__fill_defaults @ 0x8df994, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_bringup__init_rx_desc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac_indirect__write_entry
 */
	.section .text.rx_desc__fill_defaults,"ax",@progbits
	.global rx_desc__fill_defaults
rx_desc__fill_defaults:
	.global L_8df994
L_8df994:
	push_s blink
L_8df996:
	bl.d L_8c02c0
L_8df99a:
	mov_s r2,0x1
L_8df99c:
	mov_s r15,r1
L_8df99e:
	add3 r14,r0,0xa
L_8df9a2:
	add r13,r0,0x20
L_8df9a6:
	mov_s r3,0x0
L_8df9a8:
	mov_s r4,r3
L_8df9aa:
	mov_s r5,r3
L_8df9ac:
	mov_s r6,r3
L_8df9ae:
	bl.d L_8c46a4
L_8df9b2:
	mov r7,0x2
L_8df9b6:
	mov_s r0,r14
L_8df9b8:
	mov_s r1,r15
L_8df9ba:
	mov_s r2,0x1
L_8df9bc:
	mov_s r3,0x2
L_8df9be:
	mov r4,0x0
L_8df9c2:
	mov r5,0x0
L_8df9c6:
	mov r6,0x0
L_8df9ca:
	bl.d L_8c46a4
L_8df9ce:
	mov_s r7,r2
L_8df9d0:
	mov_s r0,r13
L_8df9d2:
	mov_s r1,r15
L_8df9d4:
	mov_s r2,0x1
L_8df9d6:
	mov_s r3,0x3
L_8df9d8:
	mov r4,0x0
L_8df9dc:
	mov r5,0x0
L_8df9e0:
	mov r6,0x0
L_8df9e4:
	bl.d L_8c46a4
L_8df9e8:
	mov_s r7,r3
L_8df9ea:
	.byte 0x45,0x01
