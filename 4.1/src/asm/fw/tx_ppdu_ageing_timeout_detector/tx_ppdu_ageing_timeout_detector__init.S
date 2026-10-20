/* tx_ppdu_ageing_timeout_detector__init @ 0x8d6140, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector::init(): this=0x%x, cid=%d, m_p_lm_info=0x%x
 *   tx_ppdu_ageing_timeout_detector.cpp
 * Зовут его: detectors_init_sweep
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, detector__init_common, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.tx_ppdu_ageing_timeout_detector__init,"ax",@progbits
	.global tx_ppdu_ageing_timeout_detector__init
tx_ppdu_ageing_timeout_detector__init:
	.global L_8d6140
L_8d6140:
	push_s blink
L_8d6142:
	bl L_8c02b8
L_8d6146:
	mov_s r13,r0
L_8d6148:
	mov_s r16,r1
L_8d614a:
	brge.d r1,0x8,L_8d618c
L_8d614e:
	mov_s r17,r2
	.global L_8d6150
L_8d6150:
	stb r16,[r13, 0x30]
L_8d6154:
	st r17,[r13, 0x34]
L_8d6158:
	mov_s r14,0x0
L_8d615a:
	st_s r14,[r13,0x4c]
L_8d615c:
	st_s r14,[r13,0x50]
L_8d615e:
	mov_s r2,0x1010fa0
L_8d6164:
	mov_s r0,0xb
L_8d6166:
	mov_s r1,0x2
L_8d6168:
	mov_s r3,r13
L_8d616a:
	mov r4,r16
L_8d616e:
	bl.d L_8ee034
L_8d6172:
	mov r5,r17
L_8d6176:
	mov_s r0,r13
L_8d6178:
	mov r1,-0x1
L_8d617c:
	mov_s r2,r14
L_8d617e:
	mov_s r3,0x1
L_8d6180:
	bl.d L_8d5e80
L_8d6184:
	mov r4,0x5
L_8d6188:
	b L_8c031c
	.global L_8d618c
L_8d618c:
	mov_s r0,blink
L_8d618e:
	mov_s r2,0x1010ff0
L_8d6194:
	mov_s r1,0x1479
L_8d619a:
	bl.d L_8c82c0
L_8d619e:
	mov_s r3,0x1a
L_8d61a0:
	b_s L_8d6150
L_8d61a2:
	nop_s
