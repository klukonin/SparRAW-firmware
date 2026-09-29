/* abif__wait_88afec_bit0_clear @ 0x8cd0e0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_abif.c
 * Зовут его: power_halt_seq
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.abif__wait_88afec_bit0_clear,"ax",@progbits
	.global abif__wait_88afec_bit0_clear
abif__wait_88afec_bit0_clear:
	.global L_8cd0e0
L_8cd0e0:
	mov lp_count,0x12c
L_8cd0e4:
	push_s blink
L_8cd0e6:
	lp L_8cd0f8
L_8cd0ea:
	mov_s r1,0x88af80
L_8cd0f0:
	ld_s r1,[r1,0x6c]
L_8cd0f2:
	btst_s r1,0x0
L_8cd0f4:
	bne_s L_8cd0f8
L_8cd0f6:
	nop_s
	.global L_8cd0f8
L_8cd0f8:
	bbit1 r1,0x0,L_8cd11e
L_8cd0fc:
	mov_s r2,0x1019934
L_8cd102:
	mov_s r0,0x0
L_8cd104:
	bl.d L_8edfb0
L_8cd108:
	mov_s r1,r0
L_8cd10a:
	mov_s r0,blink
L_8cd10c:
	mov_s r2,0x1019954
L_8cd112:
	mov_s r1,0x1325
L_8cd118:
	bl.d L_8c82c0
L_8cd11c:
	mov_s r3,0xfa
	.global L_8cd11e
L_8cd11e:
	pop_s blink
L_8cd120:
	j_s [blink]
L_8cd122:
	nop_s
