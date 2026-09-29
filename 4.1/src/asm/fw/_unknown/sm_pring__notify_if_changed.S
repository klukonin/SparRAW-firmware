/* sm_pring__notify_if_changed @ 0x8e4e8c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, pring__by_index, sm_pring__connectivity_update
 */
	.section .text.sm_pring__notify_if_changed,"ax",@progbits
	.global sm_pring__notify_if_changed
sm_pring__notify_if_changed:
	.byte 0x8f
	.byte 0xed
	.global sub_8e4e8e
sub_8e4e8e:
L_8e4e8e:
	nop_s
L_8e4e90:
	push_s blink
L_8e4e92:
	push_s r13
L_8e4e94:
	mov_s r13,r0
L_8e4e96:
	bl.d L_8ca7dc
L_8e4e9a:
	mov_s r0,r1
L_8e4e9c:
	bl.d L_8e4ea8
L_8e4ea0:
	mov_s r1,r13
L_8e4ea2:
	b L_8c033c
L_8e4ea6:
	nop_s
