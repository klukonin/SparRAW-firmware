/* mac_kick_ring @ 0x8ddb54, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_ring_enable, tx_dma_if__push_desc
 */
	.section .text.mac_kick_ring,"ax",@progbits
	.global mac_kick_ring
mac_kick_ring:
	.global L_8ddb54
L_8ddb54:
	mov_s r2,0x1
L_8ddb56:
	mov_s r1,0x0
L_8ddb58:
	bset r1,r1,r0
L_8ddb5c:
	mov_s r0,0x886a00
L_8ddb62:
	st_s r1,[r0,0x18]
L_8ddb64:
	st_s r1,[r0,0x1c]
L_8ddb66:
	st_s r2,[r0,0x20]
