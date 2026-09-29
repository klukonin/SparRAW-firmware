/* pcp_restart @ 0x8f7018, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_restart() m:%d, s:%d <<<< security_en = %d >>>>>
 *   pcp_restart() failed, BSS not active m: %d, s:%d
 * Зовут его: assoc_ready_check_trig
 * Зовёт сам: __ld_r13_to_r13_ret, add_bcon, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_restart
pcp_restart:
	.global L_8f7018
L_8f7018:
	push_s blink
L_8f701a:
	push_s r13
L_8f701c:
	mov_s r13,r0
L_8f701e:
	ld_s r0,[r0,0x4]
L_8f7020:
	add3 r2,r0,0x9
L_8f7024:
	ld_s r3,[r2,0x4]
L_8f7026:
	brne r3,0x2,L_8f705a
L_8f702a:
	bl L_8c2778
L_8f702e:
	mov_s r1,0x843158
L_8f7034:
	ld_s r0,[r1,0x20]
L_8f7036:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7038:
	st_s r0,[r1,0x20]
L_8f703a:
	ld_s r3,[r13,0x4]
L_8f703c:
	mov_s r1,0x1016d60
L_8f7042:
	add_s r3,r3,0x48
L_8f7044:
	mov_s r0,0x803b80
L_8f704a:
	ld r4,[r0, 0x6c]
L_8f704e:
	mov_s r0,0xc
L_8f7050:
	ld_s r2,[r3,0x8]
L_8f7052:
	bl.d L_8dcd00
L_8f7056:
	ld_s r3,[r3,0x4]
L_8f7058:
	b_s L_8f7068
	.global L_8f705a
L_8f705a:
	mov_s r1,0x1016d98
L_8f7060:
	mov_s r0,0xc
L_8f7062:
	bl.d L_8dcc80
L_8f7066:
	ld_s r2,[r2,0x8]
	.global L_8f7068
L_8f7068:
	b L_8c025c
