/* ba__on_uc_timeout_evt @ 0x8dc430, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: ba__schedule_timeout_update
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba__on_uc_timeout_evt
ba__on_uc_timeout_evt:
	.global L_8dc430
L_8dc430:
	ldb_s r1,[r0,0x1]
L_8dc432:
	ldw_s r2,[r0,0x2]
L_8dc434:
	b.d L_8ead48
L_8dc438:
	ldb_s r0,[r0]
L_8dc43a:
	nop_s
