/* conn__notify_link_via_l2mgr @ 0x8dace4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif, conn_main_sm__action_8c4898
 * Зовёт сам: l2mgr__notify_link_up
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__notify_link_via_l2mgr
conn__notify_link_via_l2mgr:
	.global L_8dace4
L_8dace4:
	b.d L_8cd76c
L_8dace8:
	add r0,r0,0x234
