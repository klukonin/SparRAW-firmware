/* hwd_abif__uses_rgf_88af80_8d0010 @ 0x8d0010, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: power_halt_seq
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__uses_rgf_88af80_8d0010
hwd_abif__uses_rgf_88af80_8d0010:
	.global L_8d0010
L_8d0010:
	mov lp_count,0x12c
L_8d0014:
	push_s blink
L_8d0016:
	lp L_8d0028
L_8d001a:
	mov_s r0,0x88af80
L_8d0020:
	ld_s r0,[r0,0x6c]
L_8d0022:
	btst_s r0,0x0
L_8d0024:
	bne_s L_8d0028
L_8d0026:
	nop_s
	.global L_8d0028
L_8d0028:
	bbit1 r0,0x0,L_8d0044
L_8d002c:
	mov_s r1,0x101eee4
L_8d0032:
	bl.d L_8dcba8
L_8d0036:
	mov_s r0,0x0
L_8d0038:
	mov_s r0,blink
L_8d003a:
	mov_s r1,0x1325
L_8d0040:
	bl L_8c9b28
	.global L_8d0044
L_8d0044:
	pop_s blink
L_8d0046:
	j_s [blink]
