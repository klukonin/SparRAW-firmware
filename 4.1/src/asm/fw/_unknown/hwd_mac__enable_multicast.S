/* hwd_mac__enable_multicast @ 0x8ce15c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HWD MAC: Enable Multi Cast traffic
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: fw_log__emit0
 */
	.section .text.hwd_mac__enable_multicast,"ax",@progbits
	.global hwd_mac__enable_multicast
hwd_mac__enable_multicast:
	.global L_8ce15c
L_8ce15c:
	push_s blink
L_8ce15e:
	mov_s r2,0x1019e4c
L_8ce164:
	mov_s r0,0x0
L_8ce166:
	bl.d L_8edfb0
L_8ce16a:
	mov_s r1,0x2
L_8ce16c:
	mov_s r1,0x886200
L_8ce172:
	ld_s r0,[r1,0x50]
L_8ce174:
	bclr_s r0,r0,0xd
L_8ce176:
	st_s r0,[r1,0x50]
L_8ce178:
	pop_s blink
L_8ce17a:
	j_s [blink]
