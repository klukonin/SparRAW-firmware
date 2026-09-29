/* hwd_mac__enable_multicast @ 0x8d0ebc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HWD MAC: Enable Multi Cast traffic
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_mac__enable_multicast
hwd_mac__enable_multicast:
	.global L_8d0ebc
L_8d0ebc:
	push_s blink
L_8d0ebe:
	mov_s r1,0x101f4d4
L_8d0ec4:
	bl.d L_8dcba8
L_8d0ec8:
	mov_s r0,0x20
L_8d0eca:
	mov_s r1,0x886200
L_8d0ed0:
	ld_s r0,[r1,0x50]
L_8d0ed2:
	bclr_s r0,r0,0xd
L_8d0ed4:
	st_s r0,[r1,0x50]
L_8d0ed6:
	pop_s blink
L_8d0ed8:
	j_s [blink]
L_8d0eda:
	nop_s
