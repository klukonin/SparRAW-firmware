/* stream_mgr__pring_by_index @ 0x8d6ff8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.stream_mgr__pring_by_index,"ax",@progbits
	.global stream_mgr__pring_by_index
stream_mgr__pring_by_index:
	.global L_8d6ff8
L_8d6ff8:
	push_s blink
L_8d6ffa:
	push_s r13
L_8d6ffc:
	mov_s r1,0x8485dc
L_8d7002:
	sub3 r1,r1,0x100
L_8d7006:
	add2_s r1,r1,r0
L_8d7008:
	ld r13,[r1,0x818]
L_8d7010:
	breq_s r13,0,L_8d7018
	.global L_8d7012
L_8d7012:
	b.d L_8c033c
L_8d7016:
	ld_s r0,[r13,0xc]
	.global L_8d7018
L_8d7018:
	mov_s r0,blink
L_8d701a:
	mov_s r2,0x100e398
L_8d7020:
	mov_s r1,0x6030
L_8d7026:
	bl.d L_8c82c0
L_8d702a:
	mov r3,0x36f
L_8d702e:
	b_s L_8d7012
