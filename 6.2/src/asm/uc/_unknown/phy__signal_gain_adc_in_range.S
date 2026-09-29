/* phy__signal_gain_adc_in_range @ 0x924f28, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: phy__read_signal_gain_adc_db
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy__signal_gain_adc_in_range
phy__signal_gain_adc_in_range:
	.global L_924f28
L_924f28:
	push_s blink
L_924f2a:
	bl L_929b74
L_924f2e:
	cmp_s r0,0x3f
L_924f30:
	bgt_s L_924f40
L_924f32:
	mov_s r1,0x800634
L_924f38:
	ldb_s r1,[r1,0xd]
L_924f3a:
	cmp_s r0,r1
L_924f3c:
	mov_s r0,0x1
L_924f3e:
	bge_s L_924f42
	.global L_924f40
L_924f40:
	mov_s r0,0x0
	.global L_924f42
L_924f42:
	pop_s blink
L_924f44:
	j_s [blink]
L_924f46:
	nop_s
