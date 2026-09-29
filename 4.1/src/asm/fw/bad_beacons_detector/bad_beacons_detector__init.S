/* bad_beacons_detector__init @ 0x8d5f8c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector::init(): cid=%d, m_p_lm_info=0x%x
 *   bad_beacons_detector.cpp
 * Зовут его: detectors_init_sweep
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bad_beacons_detector__configure, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.bad_beacons_detector__init,"ax",@progbits
	.global bad_beacons_detector__init
bad_beacons_detector__init:
	.global L_8d5f8c
L_8d5f8c:
	push_s blink
L_8d5f8e:
	bl L_8c02bc
L_8d5f92:
	mov_s r14,r0
L_8d5f94:
	mov_s r13,r1
L_8d5f96:
	brge.d r1,0x8,L_8d5fc4
L_8d5f9a:
	mov_s r16,r2
	.global L_8d5f9c
L_8d5f9c:
	stb_s r13,[r14]
L_8d5f9e:
	st r16,[r14, 0x4]
L_8d5fa2:
	mov_s r0,0x0
L_8d5fa4:
	st_s r0,[r14,0x8]
L_8d5fa6:
	mov_s r2,0x1011704
L_8d5fac:
	mov_s r0,0xb
L_8d5fae:
	mov_s r1,0x2
L_8d5fb0:
	mov_s r3,r13
L_8d5fb2:
	bl.d L_8edff8
L_8d5fb6:
	mov r4,r16
L_8d5fba:
	bl.d L_8c5a34
L_8d5fbe:
	mov_s r0,r14
L_8d5fc0:
	b L_8c0324
	.global L_8d5fc4
L_8d5fc4:
	mov_s r0,blink
L_8d5fc6:
	mov_s r2,0x10116e8
L_8d5fcc:
	mov_s r1,0x147b
L_8d5fd2:
	bl.d L_8c82c0
L_8d5fd6:
	mov_s r3,0x10
L_8d5fd8:
	b_s L_8d5f9c
L_8d5fda:
	nop_s
