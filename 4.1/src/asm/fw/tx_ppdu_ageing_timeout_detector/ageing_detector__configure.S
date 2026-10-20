/* ageing_detector__configure @ 0x8c5acc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector.cpp
 * Зовут его: ageing_detector__rearm, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r13_ret, ageing_detector__is_active, fw_sysassert_fatal
 */
	.section .text.ageing_detector__configure,"ax",@progbits
	.global ageing_detector__configure
ageing_detector__configure:
	.global L_8c5acc
L_8c5acc:
	push_s blink
L_8c5ace:
	push_s r13
L_8c5ad0:
	bl.d L_8d72cc
L_8c5ad4:
	mov_s r13,r0
L_8c5ad6:
	breq_s r0,0,L_8c5af0
L_8c5ad8:
	ldb r0,[r13, 0x30]
L_8c5adc:
	brge r0,0x8,L_8c5b00
	.global L_8c5ae0
L_8c5ae0:
	ld_s r0,[r13,0x34]
L_8c5ae2:
	mov_s r2,0x0
L_8c5ae4:
	ldb r1,[r13, 0x30]
L_8c5ae8:
	add r0,r0,0x164
L_8c5aec:
	add2_s r0,r0,r1
L_8c5aee:
	st_s r2,[r0]
	.global L_8c5af0
L_8c5af0:
	mov_s r0,0x0
L_8c5af2:
	st_s r0,[r13,0x38]
L_8c5af4:
	st_s r0,[r13,0x3c]
L_8c5af6:
	st_s r0,[r13,0x40]
L_8c5af8:
	st_s r0,[r13,0x44]
L_8c5afa:
	b.d L_8c033c
L_8c5afe:
	st_s r0,[r13,0x48]
	.global L_8c5b00
L_8c5b00:
	mov_s r0,blink
L_8c5b02:
	mov_s r2,0x1010ff0
L_8c5b08:
	mov_s r1,0x1479
L_8c5b0e:
	bl.d L_8c82c0
L_8c5b12:
	mov_s r3,0x85
L_8c5b14:
	b_s L_8c5ae0
L_8c5b16:
	nop_s
