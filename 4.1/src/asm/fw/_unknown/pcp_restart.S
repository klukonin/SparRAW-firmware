/* pcp_restart @ 0x8eee64, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_restart() m:%d, s:%d <<<< security_en = %d >>>>>
 *   pcp_restart() failed, BSS not active m: %d, s:%d
 * Зовут его: assoc_ready_check_trig
 * Зовёт сам: __ld_r13_ret, fw_log__emit2, fw_log__emit3, tx_bcon__update_bcon
 */
	.section .text.pcp_restart,"ax",@progbits
	.global pcp_restart
pcp_restart:
	.global L_8eee64
L_8eee64:
	push_s blink
L_8eee66:
	push_s r13
L_8eee68:
	mov_s r13,r0
L_8eee6a:
	ld_s r0,[r0,0x4]
L_8eee6c:
	add3 r3,r0,0x9
L_8eee70:
	ld r4,[r3, 0x4]
L_8eee74:
	brne r4,0x2,L_8eeeac
L_8eee78:
	bl L_8c2190
L_8eee7c:
	mov_s r1,0x843104
L_8eee82:
	ld_s r0,[r1,0x20]
L_8eee84:
	ld_s r3,[r13,0x4]
L_8eee86:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8eee88:
	st_s r0,[r1,0x20]
L_8eee8a:
	add_s r3,r3,0x48
L_8eee8c:
	ld r4,[r3, 0x4]
L_8eee90:
	mov_s r2,0x1012584
L_8eee96:
	mov_s r0,0x8033dc
L_8eee9c:
	ld r5,[r0, 0x6c]
L_8eeea0:
	mov_s r0,0xc
L_8eeea2:
	mov_s r1,0x0
L_8eeea4:
	bl.d L_8ee034
L_8eeea8:
	ld_s r3,[r3,0x8]
L_8eeeaa:
	b_s L_8eeebc
	.global L_8eeeac
L_8eeeac:
	mov_s r2,0x10125bc
L_8eeeb2:
	mov_s r0,0xc
L_8eeeb4:
	mov_s r1,0x0
L_8eeeb6:
	bl.d L_8edff8
L_8eeeba:
	ld_s r3,[r3,0x8]
	.global L_8eeebc
L_8eeebc:
	b L_8c033c
