/* tx_bcon__inject_evt4 @ 0x8dffb8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__snapshot_step
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_bcon__inject_evt4
tx_bcon__inject_evt4:
	.global L_8dffb8
L_8dffb8:
	push_s blink
L_8dffba:
	bl.d L_8c01e4
L_8dffbe:
	mov_s r3,0x0
L_8dffc0:
	mov_s r14,r0
L_8dffc2:
	mov_s r13,r1
L_8dffc4:
	mov_s r1,0x4
L_8dffc6:
	mov_s r2,r13
L_8dffc8:
	bl.d L_8d9b6c
L_8dffcc:
	mov_s r4,r3
L_8dffce:
	add r0,r14,0x10
L_8dffd2:
	mov_s r1,0x1
L_8dffd4:
	mov_s r2,r13
L_8dffd6:
	mov_s r3,0x0
L_8dffd8:
	bl.d L_8d9b6c
L_8dffdc:
	mov_s r4,r3
L_8dffde:
	b L_8c0254
L_8dffe2:
	nop_s
