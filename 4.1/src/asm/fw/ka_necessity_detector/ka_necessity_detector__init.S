/* ka_necessity_detector__init @ 0x8d60a4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector::init(): cid=%d, m_p_lm_info=0x%x
 *   ka_necessity_detector.cpp
 * Зовут его: detectors_init_sweep
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, detector__init_common, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.ka_necessity_detector__init,"ax",@progbits
	.global ka_necessity_detector__init
ka_necessity_detector__init:
	.global L_8d60a4
L_8d60a4:
	push_s blink
L_8d60a6:
	bl L_8c02bc
L_8d60aa:
	mov_s r14,r0
L_8d60ac:
	mov_s r13,r1
L_8d60ae:
	brge.d r1,0x8,L_8d60ec
L_8d60b2:
	mov_s r16,r2
	.global L_8d60b4
L_8d60b4:
	stb r13,[r14, 0x30]
L_8d60b8:
	st r16,[r14, 0x34]
L_8d60bc:
	mov_s r15,0x0
L_8d60be:
	st_s r15,[r14,0x3c]
L_8d60c0:
	st_s r15,[r14,0x40]
L_8d60c2:
	mov_s r2,0x1011380
L_8d60c8:
	mov_s r0,0xb
L_8d60ca:
	mov_s r1,0x2
L_8d60cc:
	mov_s r3,r13
L_8d60ce:
	bl.d L_8edff8
L_8d60d2:
	mov r4,r16
L_8d60d6:
	mov_s r0,r14
L_8d60d8:
	mov r1,-0x1
L_8d60dc:
	mov_s r2,r15
L_8d60de:
	mov_s r3,0x1
L_8d60e0:
	bl.d L_8d5e80
L_8d60e4:
	mov r4,0x5
L_8d60e8:
	b L_8c0324
	.global L_8d60ec
L_8d60ec:
	mov_s r0,blink
L_8d60ee:
	mov_s r2,0x10113b8
L_8d60f4:
	mov_s r1,0x147a
L_8d60fa:
	bl.d L_8c82c0
L_8d60fe:
	mov_s r3,0x19
L_8d6100:
	b_s L_8d60b4
L_8d6102:
	nop_s
