/* vring__send_en_evt_u8 @ 0x8f5a54, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__enable_first_pending_gtk
 * Зовёт сам: l2mgr__send_vring_en_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__send_en_evt_u8
vring__send_en_evt_u8:
	.global L_8f5a54
L_8f5a54:
	b.d L_8f8ee4
L_8f5a58:
	extb_s r0,r0
L_8f5a5a:
	nop_s
