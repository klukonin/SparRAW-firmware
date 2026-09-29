/* pring__by_index @ 0x8ca7dc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_stop, sm_pring__notify_if_changed, sm_pring__update_slot
 */
	.section .text.pring__by_index,"ax",@progbits
	.global pring__by_index
pring__by_index:
	.global L_8ca7dc
L_8ca7dc:
	mul64 r0,0x38
L_8ca7e0:
	add r0,mlo,0x8045a4
L_8ca7e8:
	j_s [blink]
L_8ca7ea:
	nop_s
