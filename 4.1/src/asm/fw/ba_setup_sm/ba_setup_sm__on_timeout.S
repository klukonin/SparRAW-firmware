/* ba_setup_sm__on_timeout @ 0x8e9cf4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.ba_setup_sm__on_timeout,"ax",@progbits
	.global ba_setup_sm__on_timeout
ba_setup_sm__on_timeout:
L_8e9cf4:
	st_s r13,[r14,0x2c]
	.global sub_8e9cf6
sub_8e9cf6:
L_8e9cf6:
	nop_s
L_8e9cf8:
	push_s blink
L_8e9cfa:
	push_s r13
L_8e9cfc:
	mov.f r13,r0
L_8e9d00:
	beq_s L_8e9d1c
	.global L_8e9d02
L_8e9d02:
	mov_s r0,0x0
L_8e9d04:
	st_s r0,[r13,0x38]
L_8e9d06:
	ld_s r0,[r13,0x30]
L_8e9d08:
	brne_s r0,0,L_8e9d32
	.global L_8e9d0a
L_8e9d0a:
	mov_s r0,r13
L_8e9d0c:
	mov_s r1,0xa
L_8e9d0e:
	mov_s r2,0x0
L_8e9d10:
	mov_s r3,r2
L_8e9d12:
	bl.d L_8d6a1c
L_8e9d16:
	mov_s r4,r2
L_8e9d18:
	b L_8c033c
	.global L_8e9d1c
L_8e9d1c:
	mov_s r0,blink
L_8e9d1e:
	mov_s r2,0x10102c4
L_8e9d24:
	mov_s r1,0x1293
L_8e9d2a:
	bl.d L_8c82c0
L_8e9d2e:
	mov_s r3,0xb7
L_8e9d30:
	b_s L_8e9d02
	.global L_8e9d32
L_8e9d32:
	mov_s r0,blink
L_8e9d34:
	mov_s r2,0x10102c4
L_8e9d3a:
	mov_s r1,0x129c
L_8e9d40:
	bl.d L_8c82c0
L_8e9d44:
	mov_s r3,0xbc
L_8e9d46:
	b_s L_8e9d0a
