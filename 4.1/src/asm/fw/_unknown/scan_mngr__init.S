/* scan_mngr__init @ 0x8ea540, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__open_reset_state
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, channels_switch_sm__init, scan__entry_by_index
 */
	.section .text.scan_mngr__init,"ax",@progbits
	.global scan_mngr__init
scan_mngr__init:
	.global L_8ea540
L_8ea540:
	push_s blink
L_8ea542:
	bl L_8c02c4
L_8ea546:
	mov_s r14,r0
L_8ea548:
	mov_s r13,r1
L_8ea54a:
	bl.d L_8ebd04
L_8ea54e:
	ldb_s r0,[r1,0x10]
L_8ea550:
	mov_s r1,r14
L_8ea552:
	st r0,[r14, 0x84]
L_8ea556:
	bl.d L_8ed244
L_8ea55a:
	mov_s r2,r13
L_8ea55c:
	b.d L_8c0334
L_8ea560:
	st_s r13,[r14,0x7c]
L_8ea562:
	nop_s
