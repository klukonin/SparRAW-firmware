/* ba_sm__on_ba_setup_sm_abort_done @ 0x8c39e8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ba_sm__on_ba_setup_sm_abort_done,"ax",@progbits
	.global ba_sm__on_ba_setup_sm_abort_done
ba_sm__on_ba_setup_sm_abort_done:
L_8c39e8:
	ld r0,[r0, 0xac]
L_8c39ec:
	ld r1,[r0, 0xd4]
L_8c39f0:
	ld_s r1,[r1,0x8]
L_8c39f2:
	j_s [r1]
