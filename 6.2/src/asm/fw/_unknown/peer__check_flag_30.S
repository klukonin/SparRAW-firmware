/* peer__check_flag_30 @ 0x8c6844, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__stop_link_b, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, ll_detector__is_armed_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global peer__check_flag_30
peer__check_flag_30:
	.global L_8c6844
L_8c6844:
	push_s blink
L_8c6846:
	push_s r13
L_8c6848:
	bl.d L_8da378
L_8c684c:
	mov_s r13,r0
L_8c684e:
	breq_s r0,0,L_8c6868
L_8c6850:
	ldb r0,[r13, 0x30]
L_8c6854:
	brge r0,0x8,L_8c6878
	.global L_8c6858
L_8c6858:
	ld_s r0,[r13,0x34]
L_8c685a:
	mov_s r2,0x0
L_8c685c:
	ldb r1,[r13, 0x30]
L_8c6860:
	add r0,r0,0x164
L_8c6864:
	add2_s r0,r0,r1
L_8c6866:
	st_s r2,[r0]
	.global L_8c6868
L_8c6868:
	mov_s r0,0x0
L_8c686a:
	st_s r0,[r13,0x38]
L_8c686c:
	st_s r0,[r13,0x3c]
L_8c686e:
	st_s r0,[r13,0x40]
L_8c6870:
	st_s r0,[r13,0x44]
L_8c6872:
	b.d L_8c025c
L_8c6876:
	st_s r0,[r13,0x48]
	.global L_8c6878
L_8c6878:
	mov_s r0,blink
L_8c687a:
	mov_s r1,0x1503
L_8c6880:
	bl L_8c9b28
L_8c6884:
	b_s L_8c6858
L_8c6886:
	nop_s
