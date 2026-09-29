/* evt_ring__push_1c @ 0x8e0b2c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete_8e1794, deep_sleep_enter, deep_sleep_exit, ps_assoc_mgr__shallow_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global evt_ring__push_1c
evt_ring__push_1c:
	.global L_8e0b2c
L_8e0b2c:
	push_s r13
L_8e0b2e:
	mov_s r3,0x84012c
L_8e0b34:
	ldb_s r1,[r3]
L_8e0b36:
	mov_s r13,0x84008c
L_8e0b3c:
	add2_s r13,r13,r1
L_8e0b3e:
	st_s r2,[r13]
L_8e0b40:
	add r2,r1,0x84010c
L_8e0b48:
	stb_s r0,[r2]
L_8e0b4a:
	add_s r0,r1,0x1
L_8e0b4c:
	extb_s r0,r0
L_8e0b4e:
	bmsk_s r0,r0,0x4
L_8e0b50:
	stb_s r0,[r3]
L_8e0b52:
	j_s.d [blink]
L_8e0b54:
	pop_s r13
L_8e0b56:
	nop_s
